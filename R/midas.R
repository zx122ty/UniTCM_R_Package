#' Query gene-to-disease associations (MIDAS)
#'
#' Given a list of gene symbols or IDs, find associated diseases across
#' multiple evidence sources.
#'
#' @param gene_list Character vector of gene identifiers.
#' @param gene_id_type ID type: `"symbol"` (default), `"entrez"`, or
#'   `"ensembl"`.
#' @param sources Character vector of source databases to query (or `NULL`
#'   for all).
#' @param min_sources Minimum number of sources supporting an association
#'   (default 1).
#' @param min_score Minimum association score (default 0).
#' @param evidence_types Character vector of evidence types to filter by.
#' @param scoring_method Scoring method: `"max"` (default) or `"mean"`.
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20).
#' @return A [tibble::tibble()] of gene-disease associations with attribute
#'   `"gene_mapping"` containing the gene ID resolution mapping.
#' @export
#' @examples
#' \donttest{
#' query_gene_diseases(c("TP53", "BRCA1"))
#' }
query_gene_diseases <- function(gene_list, gene_id_type = "symbol",
                                sources = NULL, min_sources = 1L,
                                min_score = 0, evidence_types = NULL,
                                scoring_method = "max",
                                page = 1L, page_size = 20L) {
  body <- list(
    gene_list = as.list(gene_list),
    gene_id_type = gene_id_type,
    min_sources = min_sources,
    min_score = min_score,
    scoring_method = scoring_method,
    page = page,
    page_size = page_size
  )
  if (!is.null(sources)) body[["sources"]] <- as.list(sources)
  if (!is.null(evidence_types)) body[["evidence_types"]] <- as.list(evidence_types)

  resp <- unitcm_request("/tools/midas/gene-to-disease", method = "POST",
                         body = body)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  attr(result, "gene_mapping") <- resp[["gene_mapping"]]
  result
}

#' Query disease-to-gene associations (MIDAS)
#'
#' Given a disease query, find associated genes across multiple evidence
#' sources.
#'
#' @param disease_query Disease name or ID.
#' @param disease_id_type ID type: `"name"` (default) or `"icd11"`.
#' @param sources Character vector of source databases (or `NULL` for all).
#' @param min_sources Minimum supporting sources (default 1).
#' @param scoring_method Scoring method: `"max"` (default) or `"mean"`.
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20).
#' @return A [tibble::tibble()] of disease-gene associations with attribute
#'   `"matched_diseases"`.
#' @export
#' @examples
#' \donttest{
#' query_disease_genes("breast cancer")
#' }
query_disease_genes <- function(disease_query, disease_id_type = "name",
                                sources = NULL, min_sources = 1L,
                                scoring_method = "max",
                                page = 1L, page_size = 20L) {
  body <- list(
    disease_query = disease_query,
    disease_id_type = disease_id_type,
    min_sources = min_sources,
    scoring_method = scoring_method,
    page = page,
    page_size = page_size
  )
  if (!is.null(sources)) body[["sources"]] <- as.list(sources)

  resp <- unitcm_request("/tools/midas/disease-to-gene", method = "POST",
                         body = body)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  attr(result, "matched_diseases") <- resp[["matched_diseases"]]
  result
}

#' Convert gene identifiers (MIDAS)
#'
#' Convert a mixed list of gene identifiers (symbols, Entrez IDs, Ensembl
#' IDs) to a standardized mapping.
#'
#' @param identifiers Character vector of gene identifiers.
#' @return A [tibble::tibble()] with columns including match status.
#' @export
#' @examples
#' \donttest{
#' convert_gene_ids(c("TP53", "7157", "ENSG00000141510"))
#' }
convert_gene_ids <- function(identifiers) {
  resp <- unitcm_request(
    "/tools/midas/convert-gene-ids",
    method = "POST",
    body = list(identifiers = as.list(identifiers))
  )

  results <- resp[["results"]] %||% list()
  if (length(results) > 0L) tibble::as_tibble(results) else tibble::tibble()
}

#' Disease enrichment analysis (MIDAS)
#'
#' Perform Fisher's exact test enrichment analysis to identify diseases
#' significantly associated with a gene list.
#'
#' @param gene_list Character vector of gene identifiers.
#' @param gene_id_type ID type: `"symbol"` (default), `"entrez"`, or
#'   `"ensembl"`.
#' @param sources Character vector of source databases (or `NULL`).
#' @param min_sources Minimum supporting sources (default 1).
#' @param background_gene_count Background gene count (default 20000).
#' @param p_value_cutoff P-value significance cutoff (default 0.05).
#' @param correction_method P-value correction: `"fdr"` (default),
#'   `"bonferroni"`, `"holm"`, or `"none"`.
#' @param min_hit_count Minimum gene hits per disease (default 2).
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20).
#' @return A [tibble::tibble()] of enrichment results with attributes
#'   `"total_significant"`, `"total_tested"`, and `"input_gene_count"`.
#' @export
#' @examples
#' \donttest{
#' query_disease_enrichment(c("TP53", "BRCA1", "EGFR", "VEGFA"))
#' }
query_disease_enrichment <- function(gene_list, gene_id_type = "symbol",
                                     sources = NULL, min_sources = 1L,
                                     background_gene_count = 20000L,
                                     p_value_cutoff = 0.05,
                                     correction_method = "fdr",
                                     min_hit_count = 2L,
                                     page = 1L, page_size = 20L) {
  body <- list(
    gene_list = as.list(gene_list),
    gene_id_type = gene_id_type,
    min_sources = min_sources,
    background_gene_count = background_gene_count,
    p_value_cutoff = p_value_cutoff,
    correction_method = correction_method,
    min_hit_count = min_hit_count,
    page = page,
    page_size = page_size
  )
  if (!is.null(sources)) body[["sources"]] <- as.list(sources)

  resp <- unitcm_request("/tools/midas/disease-enrichment", method = "POST",
                         body = body)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total_significant") <- resp[["total_significant"]]
  attr(result, "total_tested") <- resp[["total_tested"]]
  attr(result, "input_gene_count") <- resp[["input_gene_count"]]
  result
}

#' Compare gene-disease sources (MIDAS)
#'
#' Compare how different evidence sources cover a gene list, producing
#' Venn-diagram-ready set data.
#'
#' @param gene_list Character vector of gene identifiers.
#' @param sources Character vector of source databases (or `NULL`).
#' @param mode Comparison mode: `"union"` (default) or `"intersection"`.
#' @return A named list with elements: `$mode`, `$sources`, `$sets`
#'   (named list of gene vectors), `$intersections`, `$exclusives`,
#'   `$genes_used`.
#' @export
#' @examples
#' \donttest{
#' query_source_comparison(c("TP53", "BRCA1"), mode = "union")
#' }
query_source_comparison <- function(gene_list, sources = NULL,
                                    mode = c("union", "intersection")) {
  mode <- rlang::arg_match(mode)
  body <- list(
    gene_list = as.list(gene_list),
    mode = mode
  )
  if (!is.null(sources)) body[["sources"]] <- as.list(sources)

  unitcm_request("/tools/midas/source-comparison", method = "POST",
                 body = body)
}

#' Find disease intersection (MIDAS)
#'
#' Find genes shared across multiple diseases.
#'
#' @param disease_queries Character vector of disease names/IDs.
#' @param sources Character vector of source databases (or `NULL`).
#' @return A named list with elements: `$diseases`, `$per_source`,
#'   `$targets`, `$total_intersection_genes`.
#' @export
#' @examples
#' \donttest{
#' query_disease_intersection(c("breast cancer", "lung cancer"))
#' }
query_disease_intersection <- function(disease_queries, sources = NULL) {
  body <- list(disease_queries = as.list(disease_queries))
  if (!is.null(sources)) body[["sources"]] <- as.list(sources)

  unitcm_request("/tools/midas/disease-intersection", method = "POST",
                 body = body)
}

#' Autocomplete disease names (MIDAS)
#'
#' Search for disease names with autocomplete. Query must be at least 2
#' characters.
#'
#' @param q Search query (minimum 2 characters).
#' @return A [tibble::tibble()] with columns: `disease_name`, `disease_id`,
#'   `gene_count`.
#' @export
#' @examples
#' \donttest{
#' autocomplete_disease("breast")
#' }
autocomplete_disease <- function(q) {
  if (nchar(q) < 2L) {
    rlang::abort("Query `q` must be at least 2 characters.")
  }
  resp <- unitcm_request("/tools/midas/autocomplete-disease",
                         query = list(q = q))
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get MIDAS data sources
#'
#' List all available gene-disease association databases.
#'
#' @return A [tibble::tibble()] with columns: `key`, `label`, `has_score`,
#'   `weight`, `row_count`.
#' @export
#' @examples
#' \donttest{
#' fetch_midas_sources()
#' }
fetch_midas_sources <- function() {
  resp <- unitcm_request("/tools/midas/sources")
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get MIDAS statistics
#'
#' @return A named list with fields: `total_associations`, `total_genes`,
#'   `total_diseases`, `sources`.
#' @export
#' @examples
#' \donttest{
#' fetch_midas_stats()
#' }
fetch_midas_stats <- function() {
  unitcm_request("/tools/midas/statistics")
}
