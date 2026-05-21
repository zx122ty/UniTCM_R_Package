#' Search Target2NP compound-target interactions
#'
#' Query the UniTCM Target2NP database of natural-product to protein-target
#' interactions, combining records from experimental sources such as
#' BindingDB, HERB2, NPASS, BATMAN, and others.
#'
#' @param search Free-text search query.
#' @param search_field Field to restrict the search to. One of `"all"`,
#'   `"gene_symbol"`, `"compound_name"`, `"uniprot_id"`, `"inchikey"`,
#'   `"pubchem_cid"`, or `"chembl_id"`.
#' @param search_mode `"exact"` (case-insensitive equality) or `"fuzzy"`
#'   (substring match).
#' @param source_db Filter by source database (e.g. `"BindingDB"`).
#' @param evidence_level Filter by evidence level (integer 1-4 as string).
#' @param evidence_label Filter by evidence label.
#' @param target_organism Filter by target organism (e.g. `"Homo sapiens"`).
#' @param interaction_type Filter by interaction type.
#' @param activity_type Filter by activity type (e.g. `"IC50"`, `"Ki"`).
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20, max 100).
#' @param all_pages If `TRUE`, fetch all pages.
#' @return A [tibble::tibble()] of interaction records with attribute
#'   `"total"`.
#' @export
#' @examples
#' \donttest{
#' search_target2np(search = "quercetin")
#' search_target2np(search = "TP53", search_field = "gene_symbol",
#'                  source_db = "BindingDB")
#' }
search_target2np <- function(search = NULL,
                             search_field = c("all", "gene_symbol",
                                              "compound_name", "uniprot_id",
                                              "inchikey", "pubchem_cid",
                                              "chembl_id"),
                             search_mode = c("exact", "fuzzy"),
                             source_db = NULL, evidence_level = NULL,
                             evidence_label = NULL, target_organism = NULL,
                             interaction_type = NULL, activity_type = NULL,
                             page = 1L, page_size = 20L,
                             all_pages = FALSE) {
  search_field <- rlang::arg_match(search_field)
  search_mode <- rlang::arg_match(search_mode)

  query <- list(
    search = search,
    search_field = search_field,
    search_mode = search_mode,
    source_db = source_db,
    evidence_level = evidence_level,
    evidence_label = evidence_label,
    target_organism = target_organism,
    interaction_type = interaction_type,
    activity_type = activity_type
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/target2np", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/target2np", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Get a single Target2NP interaction record
#'
#' Retrieve the full detail for one compound-target interaction record.
#'
#' @param record_id Integer record ID.
#' @return A named list of interaction fields.
#' @export
#' @examples
#' \donttest{
#' get_target2np(1)
#' }
get_target2np <- function(record_id) {
  unitcm_request(paste0("/target2np/", as.integer(record_id)))
}

#' Fetch Target2NP filter options
#'
#' Returns the controlled values used by the Target2NP filter UI
#' (source databases, evidence labels, top target organisms, interaction
#' types, and top activity types).
#'
#' @return A named list with fields `source_db`, `evidence_label`,
#'   `target_organism`, `interaction_type`, `activity_type`.
#' @export
#' @examples
#' \donttest{
#' opts <- fetch_target2np_filters()
#' opts$source_db
#' }
fetch_target2np_filters <- function() {
  unitcm_request("/target2np/filter-options")
}

#' Fetch Target2NP database statistics
#'
#' Returns counts and distributions across source databases, evidence
#' levels, target organisms, and activity types.
#'
#' @return A named list with `total_records` and four distribution lists.
#' @export
#' @examples
#' \donttest{
#' stats <- fetch_target2np_stats()
#' stats$total_records
#' }
fetch_target2np_stats <- function() {
  unitcm_request("/target2np/statistics")
}

#' Batch query Target2NP by identifier list
#'
#' Look up interaction records for up to 50 gene symbols, UniProt IDs, or
#' Entrez gene IDs in one call.
#'
#' @param identifiers Character vector of identifiers (max 50).
#' @param id_type One of `"gene_symbol"` (default), `"uniprot_id"`, or
#'   `"entrez_gene_id"`.
#' @return A [tibble::tibble()] of matching records with attributes
#'   `"total"`, `"queries_matched"`, and `"queries_not_found"`.
#' @export
#' @examples
#' \donttest{
#' batch_target2np(c("TP53", "BRCA1", "EGFR"))
#' batch_target2np(c("P04637", "P38398"), id_type = "uniprot_id")
#' }
batch_target2np <- function(identifiers,
                            id_type = c("gene_symbol", "uniprot_id",
                                        "entrez_gene_id")) {
  id_type <- rlang::arg_match(id_type)
  body <- list(
    identifiers = as.list(identifiers),
    id_type = id_type
  )
  resp <- unitcm_request("/target2np/batch", method = "POST", body = body)

  results <- resp[["results"]] %||% list()
  out <- if (length(results) > 0L) tibble::as_tibble(results) else tibble::tibble()
  attr(out, "total") <- resp[["total"]] %||% 0L
  attr(out, "queries_matched") <- resp[["queries_matched"]] %||% 0L
  attr(out, "queries_not_found") <- resp[["queries_not_found"]] %||% character()
  out
}

#' Aggregated Target2NP view across data sources
#'
#' Return compound-target pairs (keyed by InChIKey + UniProt ID) supported
#' by interaction records in at least `min_sources` source databases.
#' Optionally extends each pair with DrugCLIP / SEA prediction support.
#'
#' @param search Free-text search query.
#' @param target_organism Optional target organism filter.
#' @param min_sources Minimum number of source databases supporting the
#'   pair (1-5, default 2).
#' @param include_predictions If `TRUE`, also count DrugCLIP and SEA
#'   predictions as additional supporting sources.
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20, max 50).
#' @return A [tibble::tibble()] of aggregated pairs with attribute `"total"`.
#' @export
#' @examples
#' \donttest{
#' aggregated_target2np(search = "quercetin")
#' aggregated_target2np(search = "TP53", min_sources = 3,
#'                      include_predictions = TRUE)
#' }
aggregated_target2np <- function(search = NULL, target_organism = NULL,
                                 min_sources = 2L,
                                 include_predictions = FALSE,
                                 page = 1L, page_size = 20L) {
  query <- list(
    search = search,
    target_organism = target_organism,
    min_sources = min_sources,
    include_predictions = include_predictions,
    page = page,
    page_size = page_size
  )
  resp <- unitcm_request("/target2np/aggregated", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Search DrugCLIP predicted compound-target interactions
#'
#' Query DrugCLIP deep-learning predictions, with optional confidence
#' filtering by predicted score.
#'
#' @param search Free-text search.
#' @param search_field One of `"all"`, `"gene_symbol"`, `"compound_name"`,
#'   or `"inchikey"`.
#' @param search_mode `"exact"` or `"fuzzy"`.
#' @param min_score Minimum DrugCLIP score (0-1).
#' @param confidence One of `"high"` (>= 0.8), `"medium"` (0.5-0.8),
#'   `"low"` (< 0.5).
#' @param page,page_size Pagination.
#' @param all_pages If `TRUE`, fetch all pages.
#' @return A [tibble::tibble()] of DrugCLIP predictions with attribute
#'   `"total"`.
#' @export
#' @examples
#' \donttest{
#' search_target2np_drugclip(search = "quercetin", confidence = "high")
#' }
search_target2np_drugclip <- function(search = NULL,
                                      search_field = c("all", "gene_symbol",
                                                       "compound_name",
                                                       "inchikey"),
                                      search_mode = c("exact", "fuzzy"),
                                      min_score = NULL, confidence = NULL,
                                      page = 1L, page_size = 20L,
                                      all_pages = FALSE) {
  search_field <- rlang::arg_match(search_field)
  search_mode <- rlang::arg_match(search_mode)

  query <- list(
    search = search,
    search_field = search_field,
    search_mode = search_mode,
    min_score = min_score,
    confidence = confidence
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/target2np/drugclip", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/target2np/drugclip", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Search SEA (ChEMBL similarity) predicted compound-target interactions
#'
#' Query SEA-style predictions derived from ChEMBL similarity scoring,
#' with optional adjusted p-value filtering.
#'
#' @param search Free-text search.
#' @param search_field One of `"all"`, `"gene_symbol"`, `"compound_name"`,
#'   `"uniprot_id"`, or `"inchikey"`.
#' @param search_mode `"exact"` or `"fuzzy"`.
#' @param max_pvalue Maximum adjusted p-value.
#' @param confidence One of `"high"` (adj. p < 0.01), `"medium"`
#'   (0.01-0.05), `"low"` (>= 0.05).
#' @param page,page_size Pagination.
#' @param all_pages If `TRUE`, fetch all pages.
#' @return A [tibble::tibble()] of SEA predictions with attribute `"total"`.
#' @export
#' @examples
#' \donttest{
#' search_target2np_sea(search = "quercetin", confidence = "high")
#' }
search_target2np_sea <- function(search = NULL,
                                 search_field = c("all", "gene_symbol",
                                                  "compound_name",
                                                  "uniprot_id", "inchikey"),
                                 search_mode = c("exact", "fuzzy"),
                                 max_pvalue = NULL, confidence = NULL,
                                 page = 1L, page_size = 20L,
                                 all_pages = FALSE) {
  search_field <- rlang::arg_match(search_field)
  search_mode <- rlang::arg_match(search_mode)

  query <- list(
    search = search,
    search_field = search_field,
    search_mode = search_mode,
    max_pvalue = max_pvalue,
    confidence = confidence
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/target2np/sea", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/target2np/sea", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Multi-source summary for a Target2NP query
#'
#' Combine experimental records, DrugCLIP predictions, and SEA predictions
#' for one query, returning source counts, target/compound overlap sets,
#' confidence distributions, cross-validated compound-target pairs, and
#' an interpretive suggestion string.
#'
#' @param search Free-text search query.
#' @param sources Character vector of sources to query. Subset of
#'   `c("experimental", "drugclip", "sea")` (default: all three).
#' @param search_field One of `"all"`, `"gene_symbol"`, `"compound_name"`,
#'   `"uniprot_id"`, `"inchikey"`, `"pubchem_cid"`, `"chembl_id"`.
#' @param search_mode `"exact"` or `"fuzzy"`.
#' @return A named list with fields `source_counts`, `target_overlap`,
#'   `compound_overlap`, `confidence_distribution`, `cross_validated`,
#'   and `suggestion_text`.
#' @export
#' @examples
#' \donttest{
#' summary <- target2np_multi_source_summary(
#'   search = "TP53", search_field = "gene_symbol"
#' )
#' summary$source_counts
#' summary$suggestion_text
#' }
target2np_multi_source_summary <- function(search = NULL,
                                           sources = c("experimental",
                                                       "drugclip", "sea"),
                                           search_field = c("all",
                                                            "gene_symbol",
                                                            "compound_name",
                                                            "uniprot_id",
                                                            "inchikey",
                                                            "pubchem_cid",
                                                            "chembl_id"),
                                           search_mode = c("exact", "fuzzy")) {
  search_field <- rlang::arg_match(search_field)
  search_mode <- rlang::arg_match(search_mode)
  sources <- match.arg(sources, several.ok = TRUE)

  query <- list(
    search = search,
    sources = collapse_param(sources, ","),
    search_field = search_field,
    search_mode = search_mode
  )
  unitcm_request("/target2np/multi-source-summary", query = query)
}
