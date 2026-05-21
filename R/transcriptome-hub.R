#' Search transcriptome datasets
#'
#' Query the TCM Transcriptome Hub. This endpoint uses Style-B pagination
#' (`count`/`results` instead of `total`/`items`).
#'
#' @param search Optional text search query.
#' @param tcm_classification TCM classification filter.
#' @param organism Organism filter.
#' @param model_type Model type filter.
#' @param experiment_type Experiment type filter.
#' @param disease_classification Disease classification filter.
#' @param cell_line Cell line filter.
#' @param comparison_type Comparison type filter.
#' @param confidence Confidence filter.
#' @param sequence_type Sequence type filter.
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20).
#' @param all_pages If `TRUE`, fetch all pages via auto-pagination.
#' @return A [tibble::tibble()] of datasets with attribute `"total"`.
#' @export
#' @examples
#' \donttest{
#' search_transcriptomes(search = "ginseng")
#' }
search_transcriptomes <- function(search = NULL, tcm_classification = NULL,
                                  organism = NULL, model_type = NULL,
                                  experiment_type = NULL,
                                  disease_classification = NULL,
                                  cell_line = NULL, comparison_type = NULL,
                                  confidence = NULL, sequence_type = NULL,
                                  page = 1L, page_size = 20L,
                                  all_pages = FALSE) {
  query <- list(
    search = search,
    tcm_classification = tcm_classification,
    organism = organism,
    model_type = model_type,
    experiment_type = experiment_type,
    disease_classification = disease_classification,
    cell_line = cell_line,
    comparison_type = comparison_type,
    confidence = confidence,
    sequence_type = sequence_type
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/transcriptome-hub/", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/transcriptome-hub/", query = query)

  items <- resp[["results"]] %||% resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["count"]] %||% resp[["total"]] %||% 0L
  result
}

#' Get a single transcriptome dataset
#'
#' @param dataset_id The dataset ID (e.g. `"TCMtrans00001"`).
#' @return A named list with 35+ fields.
#' @export
#' @examples
#' \donttest{
#' get_transcriptome("TCMtrans00001")
#' }
get_transcriptome <- function(dataset_id) {
  unitcm_request(paste0("/transcriptome-hub/", dataset_id, "/"))
}

#' Get transcriptome filter options
#'
#' @return A named list of character vectors for each filter field.
#' @export
#' @examples
#' \donttest{
#' filters <- fetch_transcriptome_filters()
#' filters$organism
#' }
fetch_transcriptome_filters <- function() {
  unitcm_request("/transcriptome-hub/filter-options/")
}

#' Get Transcriptome Hub statistics
#'
#' @return A named list with fields: `total_datasets`, `total_organisms`,
#'   `total_tcm_entities`, `total_analysis_modules`, plus distribution data.
#' @export
#' @examples
#' \donttest{
#' fetch_transcriptome_stats()
#' }
fetch_transcriptome_stats <- function() {
  unitcm_request("/transcriptome-hub/statistics/")
}

#' List available analysis modules for a dataset
#'
#' @param dataset_id The dataset ID.
#' @return A character vector of available module names.
#' @export
#' @examples
#' \donttest{
#' get_analysis_modules("TCMtrans00001")
#' }
get_analysis_modules <- function(dataset_id) {
  resp <- unitcm_request(paste0("/transcriptome-hub/", dataset_id, "/analysis/"))
  resp[["available_modules"]] %||% character(0L)
}

#' Get analysis data for a transcriptome dataset
#'
#' Retrieve data for a specific analysis module. Return type varies by
#' module.
#'
#' @param dataset_id The dataset ID.
#' @param module Analysis module name. One of: `"meta"`, `"expression"`,
#'   `"deg"`, `"go"`, `"kegg"`, `"gsea"`, `"ppi"`, `"immune"`, `"tf"`,
#'   `"pca"`, `"qc"`.
#' @param gene Optional gene filter (for expression module only).
#' @return A [tibble::tibble()] for tabular modules (deg, go, kegg, gsea,
#'   immune, tf), or a named list for structured modules (meta, expression,
#'   ppi, pca, qc).
#' @export
#' @examples
#' \donttest{
#' get_analysis_data("TCMtrans00001", "deg")
#' get_analysis_data("TCMtrans00001", "expression", gene = "TP53")
#' }
get_analysis_data <- function(dataset_id, module, gene = NULL) {
  valid_modules <- c("meta", "expression", "deg", "go", "kegg", "gsea",
                     "ppi", "immune", "tf", "pca", "qc")
  module <- rlang::arg_match(module, values = valid_modules)

  query <- list(gene = gene)
  resp <- unitcm_request(
    paste0("/transcriptome-hub/", dataset_id, "/analysis/", module, "/"),
    query = query
  )

  tabular_modules <- c("deg", "go", "kegg", "gsea", "immune", "tf")
  if (module %in% tabular_modules) {
    if (is.data.frame(resp)) return(tibble::as_tibble(resp))
    if (is.list(resp) && length(resp) > 0L) {
      return(tryCatch(tibble::as_tibble(resp), error = function(e) resp))
    }
    return(tibble::tibble())
  }

  resp
}
