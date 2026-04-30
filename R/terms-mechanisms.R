#' Search terms molecular mechanisms
#'
#' Query the Terms Molecular Mechanisms database with optional filters.
#'
#' @param search Optional text search query.
#' @param category Category filter.
#' @param omics_type Omics type filter.
#' @param evidence_level Evidence level filter.
#' @param confidence_level Confidence level filter.
#' @param study_type Study type filter.
#' @param species Species filter.
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20).
#' @param all_pages If `TRUE`, fetch all pages via auto-pagination.
#' @return A [tibble::tibble()] of mechanism terms with attribute `"total"`.
#' @export
#' @examples
#' \donttest{
#' search_mechanisms(search = "Qi deficiency")
#' }
search_mechanisms <- function(search = NULL, category = NULL,
                              omics_type = NULL, evidence_level = NULL,
                              confidence_level = NULL, study_type = NULL,
                              species = NULL, page = 1L, page_size = 20L,
                              all_pages = FALSE) {
  query <- list(
    search = search,
    category = category,
    omics_type = omics_type,
    evidence_level = evidence_level,
    confidence_level = confidence_level,
    study_type = study_type,
    species = species
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/terms-molecular-mechanisms/", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/terms-molecular-mechanisms/", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Get a single mechanism term by ID
#'
#' Retrieve full detail for one term including nested arrays of biomarkers,
#' pathways, gene targets, metabolites, etc.
#'
#' @param term_id The mechanism term ID.
#' @return A named list with ~50 fields. Nested arrays (e.g. `biomarkers`,
#'   `signaling_pathways`, `gene_targets`) are returned as-is (lists).
#' @export
#' @examples
#' \donttest{
#' get_mechanism("TMM001")
#' }
get_mechanism <- function(term_id) {
  unitcm_request(paste0("/terms-molecular-mechanisms/", term_id, "/"))
}

#' Get mechanism filter options
#'
#' Fetches all 6 filter option endpoints and returns them as a named list
#' of tibbles.
#'
#' @return A named list with elements: `categories`, `omics_types`,
#'   `evidence_levels`, `confidence_levels`, `study_types`, `species`.
#'   Each is a [tibble::tibble()] with columns `value`, `label`, `count`.
#' @export
#' @examples
#' \donttest{
#' filters <- fetch_mechanism_filters()
#' filters$categories
#' }
fetch_mechanism_filters <- function() {
  endpoints <- list(
    categories = "/terms-molecular-mechanisms/filters/categories/",
    omics_types = "/terms-molecular-mechanisms/filters/omics-types/",
    evidence_levels = "/terms-molecular-mechanisms/filters/evidence-levels/",
    confidence_levels = "/terms-molecular-mechanisms/filters/confidence-levels/",
    study_types = "/terms-molecular-mechanisms/filters/study-types/",
    species = "/terms-molecular-mechanisms/filters/species/"
  )

  lapply(endpoints, function(path) {
    resp <- unitcm_request(path)
    if (is.data.frame(resp)) return(tibble::as_tibble(resp))
    if (is.list(resp) && length(resp) > 0L) {
      return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
    }
    tibble::tibble()
  })
}
