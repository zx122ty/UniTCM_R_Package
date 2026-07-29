# ============================================================================
# PPI Network & Enrichment Analysis
# ============================================================================
# Functions for protein-protein interaction (PPI) network construction via the
# STRING database API and GO/KEGG pathway enrichment analysis via the Enrichr
# API. These are standalone functions that call external web services directly
# — they do not require a UniTCM API key.
# ============================================================================

# ============================================================================
# 1. PPI Network — STRING Database
# ============================================================================

#' Query the STRING database for protein-protein interactions
#'
#' Queries the [STRING database](https://string-db.org/) REST API to retrieve
#' a protein-protein interaction (PPI) network for a list of gene symbols.
#' Large gene lists are automatically split into batches to respect API limits.
#'
#' @param gene_list Character vector of gene symbols (e.g. `c("TP53", "BRCA1")`).
#' @param species NCBI taxonomy ID. Default `9606` (Homo sapiens). Use
#'   `10090` for mouse, `10116` for rat.
#' @param score_threshold Minimum combined STRING score, in the 0–1000 range.
#'   Default `400` (medium confidence).
#' @param batch_size Maximum number of genes per API request. Default `500`.
#' @return A [tibble::tibble()] with columns:
#'   \describe{
#'     \item{gene1, gene2}{Preferred gene symbols of the interaction partners.}
#'     \item{score}{Combined STRING score (0–1000).}
#'   }
#' @export
#' @examples
#' \dontrun{
#' ppi <- query_string_ppi(c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF"))
#' head(ppi)
#' }
query_string_ppi <- function(gene_list, species = 9606L, score_threshold = 400L,
                             batch_size = 500L) {
  genes <- unique(gene_list)
  all_links <- list()

  for (i in seq(1L, length(genes), by = batch_size)) {
    batch <- genes[seq(i, min(i + batch_size - 1L, length(genes)))]
    cli::cli_inform("[PPI] Querying STRING for {length(batch)} genes (batch {ceiling(i / batch_size)}/{ceiling(length(genes) / batch_size)})...")

    req <- httr2::request("https://string-db.org/api/tsv/network") |>
      httr2::req_url_query(
        identifiers = paste(batch, collapse = "%0d"),
        species = species,
        required_score = score_threshold
      ) |>
      httr2::req_user_agent("unitcm R package (https://github.com/zx122ty/UniTCM_R_Package)") |>
      httr2::req_retry(max_tries = 2L) |>
      httr2::req_throttle(rate = 2 / 1)  # max 2 req/s to respect rate limits

    resp <- tryCatch(
      httr2::req_perform(req),
      error = function(e) {
        cli::cli_inform("[PPI] Request failed for batch {ceiling(i / batch_size)}: {e$message}")
        return(NULL)
      }
    )

    if (is.null(resp)) next

    body <- httr2::resp_body_string(resp)
    if (!nzchar(body)) next

    lines <- strsplit(body, "\n")[[1L]]
    if (length(lines) <= 1L) next

    # Parse TSV: first line is header
    header <- strsplit(lines[1L], "\t")[[1L]]
    data_lines <- lines[-1L]
    data_lines <- data_lines[nzchar(data_lines)]

    for (line in data_lines) {
      parts <- strsplit(line, "\t")[[1L]]
      if (length(parts) < length(header)) next
      names(parts) <- header

      raw_score <- parts[["score"]]
      score_val <- tryCatch(
        as.integer(round(as.numeric(raw_score) * 1000)),
        error = function(e) 0L
      )

      all_links[[length(all_links) + 1L]] <- list(
        gene1 = parts[["preferredName_A"]] %||% "",
        gene2 = parts[["preferredName_B"]] %||% "",
        score = score_val
      )
    }

    Sys.sleep(0.5)  # Rate limit
  }

  if (length(all_links) == 0L) {
    cli::cli_inform("[PPI] STRING returned 0 interactions for {length(genes)} genes.")
    return(tibble::tibble(
      gene1 = character(), gene2 = character(), score = integer()
    ))
  }

  df <- do.call(rbind, lapply(all_links, as.data.frame, stringsAsFactors = FALSE))
  df <- tibble::as_tibble(df)
  cli::cli_inform("[PPI] STRING returned {nrow(df)} interactions for {length(genes)} genes.")
  df
}


#' Build a PPI network as an igraph object
#'
#' Creates an [igraph::graph()] from STRING PPI edges. All genes in the
#' input list are included as nodes (even those without interactions, as
#' singletons). Edge weights are set to the STRING combined score divided
#' by 1000 (i.e. in \[0, 1\]).
#'
#' @param ppi_df A data frame from [query_string_ppi()] with columns
#'   `gene1`, `gene2`, `score`.
#' @param gene_list Character vector of all gene symbols (used to ensure
#'   isolated nodes are included).
#' @return An undirected `igraph` object with edge attribute `weight`.
#' @export
#' @examples
#' \dontrun{
#' ppi <- query_string_ppi(c("TP53", "BRCA1", "EGFR"))
#' g <- build_ppi_network(ppi, c("TP53", "BRCA1", "EGFR"))
#' igraph::vcount(g)
#' igraph::ecount(g)
#' }
build_ppi_network <- function(ppi_df, gene_list) {
  check_pkg("igraph", reason = "to build PPI network graphs")

  g <- igraph::make_empty_graph(directed = FALSE)
  g <- igraph::add_vertices(g, length(gene_list), name = gene_list)

  if (nrow(ppi_df) > 0L) {
    edges <- data.frame(
      from = as.character(ppi_df$gene1),
      to   = as.character(ppi_df$gene2),
      weight = ppi_df$score / 1000,
      stringsAsFactors = FALSE
    )
    g <- igraph::graph_from_data_frame(edges, directed = FALSE,
                                       vertices = data.frame(name = gene_list,
                                                             stringsAsFactors = FALSE))
  }

  cli::cli_inform("[PPI-Network] {igraph::vcount(g)} nodes, {igraph::ecount(g)} edges.")
  g
}


#' Identify hub genes by degree centrality
#'
#' Calculates degree centrality for all nodes in a PPI network and returns
#' the top-ranked hub genes.
#'
#' @param graph An `igraph` object (from [build_ppi_network()]).
#' @param top_n Number of top hub genes to return. Default `10`.
#' @return A named numeric vector of degree centrality values for the top
#'   hub genes, sorted in descending order.
#' @export
#' @examples
#' \dontrun{
#' ppi <- query_string_ppi(c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF"))
#' g <- build_ppi_network(ppi, c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF"))
#' hubs <- identify_hub_genes(g, top_n = 5)
#' print(hubs)
#' }
identify_hub_genes <- function(graph, top_n = 10L) {
  check_pkg("igraph", reason = "to compute degree centrality")

  deg <- igraph::degree(graph)
  sorted_deg <- sort(deg, decreasing = TRUE)
  hubs <- utils::head(sorted_deg, top_n)

  hub_labels <- paste0(names(hubs), " (", round(hubs, 4), ")")
  cli::cli_inform("[PPI-Hubs] Top {top_n}: {.val {hub_labels}}")

  hubs
}


#' Detect communities in a PPI network using the Louvain algorithm
#'
#' Applies the Louvain community detection algorithm to partition the PPI
#' network into modules of densely connected genes.
#'
#' @param graph An `igraph` object (from [build_ppi_network()]).
#' @param resolution Resolution parameter for the Louvain algorithm.
#'   Larger values produce more, smaller communities. Default `1.0`.
#' @return A named list where each element is a character vector of gene
#'   symbols belonging to one community. Community IDs are used as names.
#' @export
#' @examples
#' \dontrun{
#' ppi <- query_string_ppi(c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF",
#'                            "MYC", "AKT1", "IL6", "JUN", "MAPK3"))
#' g <- build_ppi_network(ppi, unique(c(ppi$gene1, ppi$gene2)))
#' clusters <- louvain_cluster(g)
#' lengths(clusters)
#' }
louvain_cluster <- function(graph, resolution = 1.0) {
  check_pkg("igraph", reason = "to detect communities")

  partition <- igraph::cluster_louvain(graph, resolution = resolution)
  clusters <- igraph::communities(partition)

  # Convert to plain (unnamed) list of character vectors
  result <- lapply(seq_along(clusters), function(i) {
    as.character(clusters[[i]])
  })
  names(result) <- as.character(seq_along(result) - 1L)

  sizes <- lengths(result)
  cli::cli_inform("[PPI-Clusters] {length(clusters)} clusters, sizes: {.val {sort(as.integer(sizes), decreasing = TRUE)}}")

  result
}


# ============================================================================
# 2. GO / KEGG Enrichment — Enrichr API
# ============================================================================

#' Perform GO and KEGG pathway enrichment via the Enrichr API
#'
#' Submits a gene list to the [Enrichr](https://maayanlab.cloud/Enrichr/)
#' web service and retrieves enrichment results for the specified gene-set
#' libraries. This is a programmatic interface analogous to using the
#' Enrichr website.
#'
#' @param gene_list Character vector of gene symbols.
#' @param gene_set_libraries Character vector of Enrichr library names,
#'   or `NULL` (the default) to use a standard set:
#'   `"GO_Biological_Process_2023"`, `"GO_Molecular_Function_2023"`,
#'   `"GO_Cellular_Component_2023"`, `"KEGG_2021_Human"`,
#'   `"WikiPathway_2021_Human"`.
#' @param top_n Maximum number of top terms to return per library.
#'   Default `10`.
#' @return A named list of [tibble::tibble()] data frames, one per
#'   successfully queried library. Each tibble contains:
#'   \describe{
#'     \item{Term}{Enriched term name.}
#'     \item{Overlap}{Gene overlap string (e.g. `"5/200"`).}
#'     \item{P_value}{Nominal p-value.}
#'     \item{Adjusted_P}{Adjusted p-value (FDR).}
#'     \item{Z_Score}{Enrichment z-score.}
#'     \item{Combined_Score}{Enrichr combined score.}
#'     \item{Genes}{Comma-separated overlapping gene symbols.}
#'   }
#' @export
#' @examples
#' \dontrun{
#' enrich <- enrichr_enrichment(c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF"))
#' names(enrich)
#' head(enrich[["KEGG_2021_Human"]])
#' }
enrichr_enrichment <- function(gene_list, gene_set_libraries = NULL, top_n = 10L) {
  if (is.null(gene_set_libraries)) {
    gene_set_libraries <- c(
      "GO_Biological_Process_2023",
      "GO_Molecular_Function_2023",
      "GO_Cellular_Component_2023",
      "KEGG_2021_Human",
      "WikiPathway_2021_Human"
    )
  }

  # Step 1: Submit gene list to Enrichr
  genes_str <- paste(gene_list, collapse = "\n")
  cli::cli_inform("[Enrichr] Submitting {length(gene_list)} genes...")

  submit_req <- httr2::request("https://maayanlab.cloud/Enrichr/addList") |>
    httr2::req_method("POST") |>
    httr2::req_body_form(
      list = genes_str,
      description = "unitcm_query"
    ) |>
    httr2::req_user_agent("unitcm R package (https://github.com/zx122ty/UniTCM_R_Package)") |>
    httr2::req_retry(max_tries = 2L)

  submit_resp <- tryCatch(
    httr2::req_perform(submit_req),
    error = function(e) {
      cli::cli_inform("[Enrichr] Failed to submit gene list: {e$message}")
      return(NULL)
    }
  )

  if (is.null(submit_resp)) return(list())
  if (httr2::resp_status(submit_resp) != 200L) {
    cli::cli_inform("[Enrichr] Failed to submit list: HTTP {httr2::resp_status(submit_resp)}")
    return(list())
  }

  submit_data <- httr2::resp_body_json(submit_resp)
  user_list_id <- submit_data[["userListId"]]
  if (is.null(user_list_id)) {
    cli::cli_inform("[Enrichr] No userListId in response.")
    return(list())
  }

  # Step 2: Query enrichment for each library
  results <- list()
  for (lib in gene_set_libraries) {
    cli::cli_inform("[Enrichr] Querying {.val {lib}}...")

    enrich_resp <- tryCatch(
      httr2::request("https://maayanlab.cloud/Enrichr/enrich") |>
        httr2::req_url_query(userListId = user_list_id, backgroundType = lib) |>
        httr2::req_user_agent("unitcm R package (https://github.com/zx122ty/UniTCM_R_Package)") |>
        httr2::req_retry(max_tries = 2L) |>
        httr2::req_perform(),
      error = function(e) {
        cli::cli_inform("[Enrichr] Error querying {.val {lib}}: {e$message}")
        return(NULL)
      }
    )

    if (is.null(enrich_resp)) next
    if (httr2::resp_status(enrich_resp) != 200L) next

    data <- httr2::resp_body_json(enrich_resp)
    entries <- data[[lib]]
    if (is.null(entries) || length(entries) == 0L) {
      cli::cli_inform("[Enrichr] {.val {lib}}: no significant terms.")
      next
    }

    # Parse entries (Enrichr format: [rank, term, pvalue, zscore, combined_score,
    #                                 overlapping_genes, adjusted_pvalue, ...])
    rows <- list()
    for (entry in utils::head(entries, top_n)) {
      overlap_genes <- if (length(entry) > 5L) entry[[6L]] else character()
      if (is.list(overlap_genes)) {
        overlap_str <- paste(unlist(overlap_genes), collapse = ", ")
        overlap_count <- length(unlist(overlap_genes))
      } else if (is.character(overlap_genes)) {
        overlap_str <- paste(overlap_genes, collapse = ", ")
        overlap_count <- length(overlap_genes)
      } else {
        overlap_str <- ""
        overlap_count <- 0L
      }

      # Enrichr returns total background size as oldGeneCount or similar
      # We use overlap_count for display; total size is not reliably available
      rows[[length(rows) + 1L]] <- list(
        Term           = if (length(entry) > 1L) entry[[2L]] else NA_character_,
        Overlap        = sprintf("%d/%d", overlap_count, overlap_count),
        P_value        = if (length(entry) > 2L) as.numeric(entry[[3L]]) else NA_real_,
        Adjusted_P     = if (length(entry) > 6L) as.numeric(entry[[7L]])
                         else if (length(entry) > 2L) as.numeric(entry[[3L]])
                         else NA_real_,
        Z_Score        = if (length(entry) > 3L) as.numeric(entry[[4L]]) else NA_real_,
        Combined_Score = if (length(entry) > 4L) as.numeric(entry[[5L]]) else NA_real_,
        Genes          = overlap_str
      )
    }

    if (length(rows) > 0L) {
      df <- do.call(rbind, lapply(rows, as.data.frame, stringsAsFactors = FALSE))
      df <- tibble::as_tibble(df)
      results[[lib]] <- df
      top_p <- df$P_value[1L]
      cli::cli_inform("[Enrichr] {.val {lib}}: {nrow(df)} terms (top P={format(top_p, scientific = TRUE, digits = 3)}).")
    } else {
      cli::cli_inform("[Enrichr] {.val {lib}}: no significant terms.")
    }

    Sys.sleep(0.3)
  }

  results
}
