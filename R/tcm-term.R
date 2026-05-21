#' Search TCM bilingual corpus terms
#'
#' Query the TCM Bilingual Corpus with optional text search and filters.
#'
#' @param q Optional search query string.
#' @param sources Data source filter (character vector, comma-collapsed).
#' @param category Category filter (character vector, comma-collapsed).
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20, max 100).
#' @param all_pages If `TRUE`, fetch all pages via auto-pagination.
#' @return A [tibble::tibble()] of terms with attribute `"total"`.
#' @export
#' @examples
#' \dontrun{
#' search_terms(q = "ginseng")
#' }
search_terms <- function(q = NULL, sources = NULL, category = NULL,
                         page = 1L, page_size = 20L, all_pages = FALSE) {
  query <- list(
    q = q,
    sources = collapse_param(sources, ","),
    category = collapse_param(category, ",")
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/tcm-term", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/tcm-term", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Get a single term by ID
#'
#' Retrieve full detail for one term from the TCM Bilingual Corpus.
#'
#' @param term_id The term ID.
#' @return A named list with fields including `chinese_name`, `pinyin`,
#'   `english_name`, `latin_name`, `description_english`, etc.
#' @export
#' @examples
#' \dontrun{
#' get_term("TCM_T001")
#' }
get_term <- function(term_id) {
  unitcm_request(paste0("/tcm-term/", term_id))
}

#' List term sources
#'
#' @return A [tibble::tibble()] with columns `value`, `label`, `count`.
#' @export
#' @examples
#' \dontrun{
#' list_term_sources()
#' }
list_term_sources <- function() {
  resp <- unitcm_request("/tcm-term/sources")
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' List term categories
#'
#' @return A [tibble::tibble()] with columns `value`, `label`, `count`.
#' @export
#' @examples
#' \dontrun{
#' list_term_categories()
#' }
list_term_categories <- function() {
  resp <- unitcm_request("/tcm-term/categories")
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}
