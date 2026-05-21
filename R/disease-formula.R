#' Search formulas in the Disease-Formula Atlas
#'
#' Query the Disease-Formula Atlas with optional text search and ICD-11
#' disease classification filters. Multi-value parameters accept character
#' vectors and are collapsed to comma-separated strings internally.
#'
#' @param q Optional search query string.
#' @param level1,level2,level3,level4 ICD-11 disease classification levels.
#' @param book_sources Book source filter (character vector).
#' @param origin_sources Origin source filter (character vector).
#' @param dosage_forms Dosage form filter (character vector).
#' @param mapping_confidence Mapping confidence filter (character vector).
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20, max 100).
#' @param all_pages If `TRUE`, fetch all pages via auto-pagination.
#' @return A [tibble::tibble()] of formulas with attribute `"total"`.
#' @export
#' @examples
#' \dontrun{
#' search_formulas(q = "insomnia")
#' search_formulas(level1 = "Neoplasms", mapping_confidence = "high")
#' }
search_formulas <- function(q = NULL, level1 = NULL, level2 = NULL,
                            level3 = NULL, level4 = NULL,
                            book_sources = NULL, origin_sources = NULL,
                            dosage_forms = NULL, mapping_confidence = NULL,
                            page = 1L, page_size = 20L,
                            all_pages = FALSE) {
  query <- list(
    q = q,
    level1 = level1,
    level2 = level2,
    level3 = level3,
    level4 = level4,
    book_sources = collapse_param(book_sources, ","),
    origin_sources = collapse_param(origin_sources, ","),
    dosage_forms = collapse_param(dosage_forms, ","),
    mapping_confidence = collapse_param(mapping_confidence, ",")
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/disease-formula", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/disease-formula", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Get a single formula by order ID
#'
#' Retrieve full detail for one formula from the Disease-Formula Atlas.
#'
#' @param order_id The formula order ID (integer or character).
#' @return A named list with 30+ fields.
#' @export
#' @examples
#' \dontrun{
#' get_formula(1)
#' }
get_formula <- function(order_id) {
  unitcm_request(paste0("/disease-formula/", order_id))
}

#' Get herb doses for a formula
#'
#' Retrieve the composition and dosage information for a specific formula.
#'
#' @param order_id The formula order ID.
#' @return A [tibble::tibble()] with columns: `id`, `herb_name`,
#'   `original_dose`, `composition_ratio`, `modern_dose_g`,
#'   `clinical_ref_dose_g`, `dynasty`, `notes`, `herb_ids`.
#' @export
#' @examples
#' \dontrun{
#' get_formula_doses(1)
#' }
get_formula_doses <- function(order_id) {
  resp <- unitcm_request(paste0("/disease-formula/", order_id, "/doses"))
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get the ICD-11 disease classification tree
#'
#' Returns the full 4-level ICD-11 disease classification tree used by the
#' Disease-Formula Atlas.
#'
#' @return A recursive nested list with structure
#'   `list(label, count, children = list(...))`.
#' @export
#' @examples
#' \dontrun{
#' tree <- fetch_disease_tree()
#' names(tree[[1]])
#' }
fetch_disease_tree <- function() {
  unitcm_request("/disease-formula/disease-tree")
}

#' List book sources
#'
#' @return A [tibble::tibble()] with columns `value`, `label`, `count`.
#' @export
#' @examples
#' \dontrun{
#' list_book_sources()
#' }
list_book_sources <- function() {
  resp <- unitcm_request("/disease-formula/book-sources")
  tibble::as_tibble(resp)
}

#' List origin sources
#'
#' Returns the top 50 formula origin sources by frequency.
#'
#' @return A [tibble::tibble()] with columns `value`, `label`, `count`.
#' @export
#' @examples
#' \dontrun{
#' list_origin_sources()
#' }
list_origin_sources <- function() {
  resp <- unitcm_request("/disease-formula/origin-sources")
  tibble::as_tibble(resp)
}

#' List dosage forms
#'
#' Returns the top 50 dosage forms by frequency.
#'
#' @return A [tibble::tibble()] with columns `value`, `label`, `count`.
#' @export
#' @examples
#' \dontrun{
#' list_dosage_forms()
#' }
list_dosage_forms <- function() {
  resp <- unitcm_request("/disease-formula/dosage-forms")
  tibble::as_tibble(resp)
}
