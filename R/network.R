#' Build an Herb-Compound-Target network
#'
#' Given herb names or IDs, fetches herb-compound-target data from the API
#' and constructs a typed `igraph` network.
#'
#' @param herbs Character vector of herb names or UniTCM herb IDs.
#' @param target_method Target prediction method passed to
#'   [get_compound_targets()]: `"drugclip"` (default), `"chembl"`, or
#'   `"both"`.
#' @param max_compounds Maximum compounds per herb to include (default 50).
#' @param progress Show progress messages (default `TRUE`).
#' @return An `igraph` graph object with vertex attributes `name`, `type`
#'   (`"herb"`, `"compound"`, `"target"`), and `label`.
#' @export
#' @examples
#' \donttest{
#' g <- build_hct_network(c("UNITCM_H001", "UNITCM_H002"))
#' igraph::vcount(g)
#' }
build_hct_network <- function(herbs, target_method = "drugclip",
                              max_compounds = 50L, progress = TRUE) {
  check_pkg("igraph", reason = "to build network graphs")

  nodes <- list()
  edges <- list()

  for (herb in herbs) {
    if (progress) cli::cli_inform("Fetching compounds for {.val {herb}}...")

    is_id <- grepl("^UNITCM_H", herb, ignore.case = TRUE)
    if (is_id) {
      herb_id <- herb
      herb_info <- tryCatch(get_herb(herb_id), error = function(e) NULL)
      herb_label <- if (!is.null(herb_info)) {
        herb_info[["herb_english_name"]] %||% herb_id
      } else {
        herb_id
      }
    } else {
      result <- search_herbs(q = herb, page_size = 1L)
      if (nrow(result) == 0L) {
        if (progress) cli::cli_inform("  No herb found for {.val {herb}}, skipping.")
        next
      }
      herb_id <- result$unitcm_herb_id[1L]
      herb_label <- result$herb_english_name[1L] %||% herb_id
    }

    nodes[[herb_id]] <- list(name = herb_id, type = "herb", label = herb_label)

    comps <- get_herb_compounds(herb_id, page_size = max_compounds)
    if (nrow(comps) == 0L) next

    for (i in seq_len(nrow(comps))) {
      cid <- comps$unitcm_ingredient_id[i]
      cname <- comps$component_name[i] %||% cid
      nodes[[cid]] <- list(name = cid, type = "compound", label = cname)
      edges <- c(edges, list(list(from = herb_id, to = cid)))

      if (progress) cli::cli_inform("  Fetching targets for {.val {cname}}...")
      targets <- tryCatch(
        get_compound_targets(cid, method = target_method),
        error = function(e) tibble::tibble()
      )
      if (nrow(targets) > 0L && "gene_symbol" %in% names(targets)) {
        for (j in seq_len(nrow(targets))) {
          tid <- targets$gene_symbol[j]
          if (is.na(tid) || !nzchar(tid)) next
          nodes[[tid]] <- list(name = tid, type = "target", label = tid)
          edges <- c(edges, list(list(from = cid, to = tid)))
        }
      }
    }
  }

  if (length(nodes) == 0L) {
    rlang::abort("No data found for the given herbs.")
  }

  node_df <- do.call(rbind, lapply(nodes, as.data.frame,
    stringsAsFactors = FALSE))
  node_df <- node_df[!duplicated(node_df$name), ]

  edge_df <- do.call(rbind, lapply(edges, as.data.frame,
    stringsAsFactors = FALSE))

  g <- igraph::graph_from_data_frame(edge_df, directed = FALSE,
    vertices = node_df)

  if (progress) {
    cli::cli_inform("Network built: {igraph::vcount(g)} nodes, {igraph::ecount(g)} edges.")
  }
  g
}

#' Build a Formula-Herb network
#'
#' Given a formula order ID, fetches its herb doses and constructs a
#' star-topology network.
#'
#' @param formula_id The formula order ID (integer or character).
#' @return An `igraph` graph object with vertex attributes `name`, `type`
#'   (`"formula"`, `"herb"`), `label`, and `dose` (for herbs).
#' @export
#' @examples
#' \donttest{
#' g <- build_formula_herb_network(1)
#' igraph::V(g)$label
#' }
build_formula_herb_network <- function(formula_id) {
  check_pkg("igraph", reason = "to build network graphs")

  formula <- get_formula(formula_id)
  doses <- get_formula_doses(formula_id)

  fname <- formula[["formula_name"]] %||% paste0("Formula_", formula_id)
  fnode_id <- paste0("F:", formula_id)

  nodes <- data.frame(
    name = fnode_id,
    type = "formula",
    label = fname,
    dose = NA_character_,
    stringsAsFactors = FALSE
  )

  edges <- data.frame(from = character(), to = character(),
    stringsAsFactors = FALSE)

  if (nrow(doses) > 0L) {
    for (i in seq_len(nrow(doses))) {
      hname <- doses$herb_name[i]
      hid <- paste0("herb:", hname)
      dose_str <- doses$original_dose[i] %||% NA_character_

      nodes <- rbind(nodes, data.frame(
        name = hid, type = "herb", label = hname,
        dose = dose_str, stringsAsFactors = FALSE
      ))
      edges <- rbind(edges, data.frame(
        from = fnode_id, to = hid, stringsAsFactors = FALSE
      ))
    }
  }

  igraph::graph_from_data_frame(edges, directed = FALSE, vertices = nodes)
}

#' Convert a NetVis graph response to igraph
#'
#' @param graph_response A list with `$nodes` and `$edges` tibbles, as
#'   returned by [get_neighbors()], [get_subgraph()], or [find_path()].
#' @return An `igraph` graph object.
#' @export
#' @examples
#' \donttest{
#' resp <- get_neighbors("H:UNITCM_H001")
#' g <- as_igraph(resp)
#' }
as_igraph <- function(graph_response) {
  check_pkg("igraph", reason = "to convert graph responses")

  nodes <- graph_response$nodes
  edges <- graph_response$edges

  if (is.null(nodes) || nrow(nodes) == 0L) {
    return(igraph::make_empty_graph(directed = FALSE))
  }

  if (!is.null(edges) && nrow(edges) > 0L) {
    edge_cols <- intersect(c("source", "from"), names(edges))
    target_cols <- intersect(c("target", "to"), names(edges))
    if (length(edge_cols) > 0L && length(target_cols) > 0L) {
      edge_df <- data.frame(
        from = edges[[edge_cols[1L]]],
        to = edges[[target_cols[1L]]],
        stringsAsFactors = FALSE
      )
      extra_edge_cols <- setdiff(names(edges),
        c("source", "from", "target", "to"))
      for (col in extra_edge_cols) {
        edge_df[[col]] <- edges[[col]]
      }
    } else {
      edge_df <- data.frame(from = character(), to = character(),
        stringsAsFactors = FALSE)
    }
  } else {
    edge_df <- data.frame(from = character(), to = character(),
      stringsAsFactors = FALSE)
  }

  node_df <- as.data.frame(nodes, stringsAsFactors = FALSE)
  if (!"name" %in% names(node_df) && "id" %in% names(node_df)) {
    node_df$name <- node_df$id
  }

  igraph::graph_from_data_frame(edge_df, directed = FALSE,
    vertices = node_df)
}

#' Convert a NetVis graph response to tidygraph
#'
#' @inheritParams as_igraph
#' @return A `tidygraph::tbl_graph` object.
#' @export
#' @examples
#' \donttest{
#' resp <- get_neighbors("H:UNITCM_H001")
#' tg <- as_tidygraph(resp)
#' }
as_tidygraph <- function(graph_response) {
  check_pkg("tidygraph", reason = "to convert to tbl_graph")
  g <- as_igraph(graph_response)
  tidygraph::as_tbl_graph(g)
}
