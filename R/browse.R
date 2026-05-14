#' Search TCMomics datasets
#'
#' Query the TCMomics multi-omics database with optional text search and
#' faceted filters.
#'
#' @param q Optional search query string.
#' @param tcm TCM classification filter.
#' @param omics Omics type filter.
#' @param source Source type filter.
#' @param organism Organism filter.
#' @param tissue Tissue filter.
#' @param disease Disease filter.
#' @param repo Repository filter.
#' @param year_min Minimum publication year.
#' @param year_max Maximum publication year.
#' @param sort Sort field: `"relevance"`, `"date_desc"`, `"views_desc"`, or
#'   `"downloads_desc"`.
#' @param search_mode Search mode: `"fuzzy"` (default) or `"exact"`.
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20).
#' @param all_pages If `TRUE`, fetch all pages via auto-pagination.
#' @return A [tibble::tibble()] of datasets with attribute `"total"`.
#' @export
#' @examples
#' \dontrun{
#' search_datasets(q = "ginseng", omics = "Transcriptomics")
#' }
search_datasets <- function(q = NULL, tcm = NULL, omics = NULL,
                            source = NULL, organism = NULL,
                            tissue = NULL, disease = NULL,
                            repo = NULL, year_min = NULL, year_max = NULL,
                            sort = NULL, search_mode = NULL,
                            page = 1L, page_size = 20L,
                            all_pages = FALSE) {
  query <- list(
    q = q, tcm = tcm, omics = omics, source = source,
    organism = organism, tissue = tissue, disease = disease,
    repo = repo, year_min = year_min, year_max = year_max,
    sort = sort, search_mode = search_mode
  )

  path <- if (!is.null(search_mode)) "/browse/general_search" else "/browse"

  if (isTRUE(all_pages)) {
    return(unitcm_paginate(path, query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request(path, query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Get a single dataset by submission ID
#'
#' Retrieve full detail including nested persons, publications, grants,
#' and data files.
#'
#' @param submission_id The submission ID (e.g. `"TMA2025001"`).
#' @return A named list with nested sub-lists for `persons`, `publications`,
#'   `grants`, and `data_files`.
#' @export
#' @examples
#' \dontrun{
#' get_dataset("TMA2025001")
#' }
get_dataset <- function(submission_id) {
  unitcm_request(paste0("/browse/detailPage/", submission_id))
}

#' Get similar datasets
#'
#' Find datasets similar to a given submission based on content similarity.
#'
#' @param submission_id The submission ID.
#' @return A [tibble::tibble()] with columns: `submission_id`,
#'   `project_title`, `TCM_classification`, `similarity_score`.
#' @export
#' @examples
#' \dontrun{
#' get_similar_datasets("TMA2025001")
#' }
get_similar_datasets <- function(submission_id) {
  resp <- unitcm_request(paste0("/browse/similar-datasets/", submission_id))
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get dataset facets
#'
#' Returns available filter values and their counts for the TCMomics
#' database.
#'
#' @return A named list of tibbles for each facet field.
#' @export
#' @examples
#' \dontrun{
#' facets <- fetch_dataset_facets()
#' facets$omics_type
#' }
fetch_dataset_facets <- function() {
  resp <- unitcm_request("/browse/facets")
  lapply(resp, function(x) {
    if (is.data.frame(x)) {
      tibble::as_tibble(x)
    } else if (is.list(x) && length(x) > 0L) {
      tryCatch(tibble::as_tibble(x), error = function(e) x)
    } else {
      x
    }
  })
}

#' Get TCMomics database statistics
#'
#' @return A named list with fields: `total_datasets`, `total_downloads`,
#'   `omics_types_count`, `unique_organisms`.
#' @export
#' @examples
#' \dontrun{
#' fetch_dataset_stats()
#' }
fetch_dataset_stats <- function() {
  unitcm_request("/browse/stats")
}

#' Export datasets to CSV
#'
#' Download a CSV export of datasets matching the given filters.
#'
#' @inheritParams search_datasets
#' @param file Output file path (default `"datasets_export.csv"`).
#' @return Invisible file path.
#' @export
#' @examples
#' \dontrun{
#' export_datasets(omics = "Transcriptomics", file = "transcriptomics.csv")
#' }
export_datasets <- function(q = NULL, tcm = NULL, omics = NULL,
                            source = NULL, organism = NULL,
                            tissue = NULL, disease = NULL,
                            repo = NULL, year_min = NULL, year_max = NULL,
                            sort = NULL, file = "datasets_export.csv") {
  query <- list(
    q = q, tcm = tcm, omics = omics, source = source,
    organism = organism, tissue = tissue, disease = disease,
    repo = repo, year_min = year_min, year_max = year_max,
    sort = sort
  )
  unitcm_download("/browse/export", query = query, file = file)
}
