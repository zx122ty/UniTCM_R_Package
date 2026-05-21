#' Search herbs in the Herb Explorer
#'
#' Query the UniTCM Herb Explorer with optional text search and faceted
#' filters. Multi-value filter parameters accept character vectors and are
#' collapsed to semicolon-separated strings internally.
#'
#' @param q Optional search query string.
#' @param therapeutic_en English therapeutic classification filter (character
#'   vector).
#' @param therapeutic_cn Chinese therapeutic classification filter (character
#'   vector).
#' @param family Botanical family filter (character vector).
#' @param toxicity Toxicity level filter (character vector).
#' @param source Data source filter (character vector).
#' @param flavors Flavor filter (character vector).
#' @param properties Property filter (character vector).
#' @param meridians Meridian tropism filter (character vector).
#' @param medicinal_part Medicinal part filter (character vector).
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20, max 200).
#' @param all_pages If `TRUE`, fetch all pages via auto-pagination.
#' @return A [tibble::tibble()] of herbs with attribute `"total"`.
#' @export
#' @examples
#' \donttest{
#' search_herbs(q = "ginseng")
#' search_herbs(flavors = c("sweet", "bitter"), page_size = 50)
#' }
search_herbs <- function(q = NULL, therapeutic_en = NULL,
                         therapeutic_cn = NULL, family = NULL,
                         toxicity = NULL, source = NULL,
                         flavors = NULL, properties = NULL,
                         meridians = NULL, medicinal_part = NULL,
                         page = 1L, page_size = 20L,
                         all_pages = FALSE) {
  query <- list(
    q = q,
    therapeutic_en = collapse_param(therapeutic_en, ";"),
    therapeutic_cn = collapse_param(therapeutic_cn, ";"),
    family = collapse_param(family, ";"),
    toxicity = collapse_param(toxicity, ";"),
    source = collapse_param(source, ";"),
    flavors = collapse_param(flavors, ";"),
    properties = collapse_param(properties, ";"),
    meridians = collapse_param(meridians, ";"),
    medicinal_part = collapse_param(medicinal_part, ";")
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/herbs", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/herbs", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Get a single herb by ID
#'
#' Retrieve full detail for one herb from the Herb Explorer.
#'
#' @param herb_id The UniTCM herb ID (e.g. `"UNITCM_H001"`).
#' @return A named list with 31 fields including cross-reference IDs.
#' @export
#' @examples
#' \donttest{
#' get_herb("UNITCM_H001")
#' }
get_herb <- function(herb_id) {
  unitcm_request(paste0("/herbs/", normalize_id(herb_id)))
}

#' Get herb filter facets
#'
#' Returns available filter values and their counts for the Herb Explorer.
#'
#' @return A named list of tibbles, one per facet field
#'   (e.g. `therapeutic_en_class`, `family`, `toxicity`).
#' @export
#' @examples
#' \donttest{
#' facets <- fetch_herb_facets()
#' facets$toxicity
#' }
fetch_herb_facets <- function() {
  resp <- unitcm_request("/herbs/facets")
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

#' Get compounds for a herb
#'
#' List chemical compounds (ingredients) associated with a specific herb.
#'
#' @param herb_id The UniTCM herb ID.
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20).
#' @param all_pages If `TRUE`, fetch all pages.
#' @return A [tibble::tibble()] of compounds with attribute `"total"`.
#' @export
#' @examples
#' \donttest{
#' get_herb_compounds("UNITCM_H001")
#' }
get_herb_compounds <- function(herb_id, page = 1L, page_size = 20L,
                               all_pages = FALSE) {
  path <- paste0("/herbs/", normalize_id(herb_id), "/compounds")

  if (isTRUE(all_pages)) {
    return(unitcm_paginate(path))
  }

  resp <- unitcm_request(path, query = list(page = page, page_size = page_size))
  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Export herbs to CSV
#'
#' Download a CSV export of herbs matching the given filters.
#'
#' @inheritParams search_herbs
#' @param file Output file path (default `"herbs_export.csv"`).
#' @return Invisible file path.
#' @export
#' @examples
#' \donttest{
#' export_herbs(q = "ginseng", file = "ginseng_herbs.csv")
#' }
export_herbs <- function(q = NULL, therapeutic_en = NULL,
                         therapeutic_cn = NULL, family = NULL,
                         toxicity = NULL, source = NULL,
                         flavors = NULL, properties = NULL,
                         meridians = NULL, medicinal_part = NULL,
                         file = "herbs_export.csv") {
  query <- list(
    q = q,
    therapeutic_en = collapse_param(therapeutic_en, ";"),
    therapeutic_cn = collapse_param(therapeutic_cn, ";"),
    family = collapse_param(family, ";"),
    toxicity = collapse_param(toxicity, ";"),
    source = collapse_param(source, ";"),
    flavors = collapse_param(flavors, ";"),
    properties = collapse_param(properties, ";"),
    meridians = collapse_param(meridians, ";"),
    medicinal_part = collapse_param(medicinal_part, ";")
  )

  unitcm_download("/herbs/export", query = query, file = file)
}

#' Export herb compounds to CSV
#'
#' Download a CSV export of all compounds for a specific herb.
#'
#' @param herb_id The UniTCM herb ID.
#' @param file Output file path (default `"herb_compounds_export.csv"`).
#' @return Invisible file path.
#' @export
#' @examples
#' \donttest{
#' export_herb_compounds("UNITCM_H001")
#' }
export_herb_compounds <- function(herb_id,
                                  file = "herb_compounds_export.csv") {
  unitcm_download(
    paste0("/herbs/", normalize_id(herb_id), "/compounds/export"),
    file = file
  )
}
