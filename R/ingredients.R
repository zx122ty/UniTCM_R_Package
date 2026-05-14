#' Search compounds in the Ingredient Explorer
#'
#' Query the UniTCM Ingredient Explorer with optional text search and
#' physicochemical property filters.
#'
#' @param q Search query (name, SMILES, formula, or CAS number).
#' @param mw_min,mw_max Molecular weight range.
#' @param clogp_min,clogp_max CLogP range.
#' @param tpsa_min,tpsa_max Topological polar surface area range.
#' @param qed_min,qed_max QED score range.
#' @param ring_count_min,ring_count_max Ring count range.
#' @param lipinski Lipinski rule filter (character vector, comma-collapsed).
#' @param is_drug Approved drug filter (logical or `NULL`).
#' @param sort Sort field (e.g. `"mw"`, `"-mw"`).
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20, max 200).
#' @param all_pages If `TRUE`, fetch all pages.
#' @return A [tibble::tibble()] of compounds with attribute `"total"`.
#' @export
#' @examples
#' \dontrun{
#' search_compounds(q = "quercetin")
#' search_compounds(mw_min = 200, mw_max = 500, lipinski = "pass")
#' }
search_compounds <- function(q = NULL, mw_min = NULL, mw_max = NULL,
                             clogp_min = NULL, clogp_max = NULL,
                             tpsa_min = NULL, tpsa_max = NULL,
                             qed_min = NULL, qed_max = NULL,
                             ring_count_min = NULL, ring_count_max = NULL,
                             lipinski = NULL, is_drug = NULL,
                             sort = NULL, page = 1L, page_size = 20L,
                             all_pages = FALSE) {
  query <- list(
    q = q,
    mw_min = mw_min, mw_max = mw_max,
    clogp_min = clogp_min, clogp_max = clogp_max,
    tpsa_min = tpsa_min, tpsa_max = tpsa_max,
    qed_min = qed_min, qed_max = qed_max,
    ring_count_min = ring_count_min, ring_count_max = ring_count_max,
    lipinski = collapse_param(lipinski, ","),
    is_drug = is_drug,
    sort = sort
  )

  if (isTRUE(all_pages)) {
    return(unitcm_paginate("/ingredient-explorer", query = query))
  }

  query[["page"]] <- page
  query[["page_size"]] <- page_size
  resp <- unitcm_request("/ingredient-explorer", query = query)

  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Get a single compound by ID
#'
#' Retrieve full detail for one compound including cross-references.
#'
#' @param id The UniTCM ingredient ID (e.g. `"UNITCM_I00001"`).
#' @return A named list with 26+ fields including an `xref` sub-list.
#' @export
#' @examples
#' \dontrun{
#' get_compound("UNITCM_I00001")
#' }
get_compound <- function(id) {

  unitcm_request(paste0("/ingredient-explorer/", normalize_id(id)))
}

#' Get ADMET predictions for a compound
#'
#' Returns ~90 ADMET endpoint predictions as a single-row wide tibble.
#'
#' @param id The UniTCM ingredient ID.
#' @return A single-row [tibble::tibble()] with ~90 ADMET columns.
#' @export
#' @examples
#' \dontrun{
#' get_compound_admet("UNITCM_I00001")
#' }
get_compound_admet <- function(id) {
  resp <- unitcm_request(paste0("/ingredient-explorer/", normalize_id(id), "/admet"))
  flatten_response(resp)
}

#' Get predicted targets for a compound
#'
#' Retrieve target predictions from DrugCLIP, ChEMBL similarity search,
#' or both.
#'
#' @param id The UniTCM ingredient ID.
#' @param method One of `"drugclip"`, `"chembl"`, or `"both"` (default
#'   `"drugclip"`).
#' @param page Page number (for ChEMBL targets, default 1).
#' @param page_size Results per page (for ChEMBL targets, default 20).
#' @return A [tibble::tibble()] of targets. When `method = "both"`, a
#'   `source` column is added to distinguish results.
#' @export
#' @examples
#' \dontrun{
#' get_compound_targets("UNITCM_I00001")
#' get_compound_targets("UNITCM_I00001", method = "both")
#' }
get_compound_targets <- function(id, method = c("drugclip", "chembl", "both"),
                                 page = 1L, page_size = 20L) {
  method <- rlang::arg_match(method)
  base_path <- paste0("/ingredient-explorer/", normalize_id(id))

  if (method == "drugclip") {
    resp <- unitcm_request(paste0(base_path, "/targets"))
    if (is.data.frame(resp)) return(tibble::as_tibble(resp))
    if (is.list(resp) && length(resp) > 0L) {
      return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
    }
    return(tibble::tibble())
  }

  if (method == "chembl") {
    resp <- unitcm_request(
      paste0(base_path, "/chembl-targets"),
      query = list(page = page, page_size = page_size)
    )
    items <- resp[["items"]] %||% list()
    result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
    attr(result, "total") <- resp[["total"]] %||% 0L
    return(result)
  }

  # method == "both"
  dc <- get_compound_targets(id, method = "drugclip")
  ch <- get_compound_targets(id, method = "chembl", page = page,
                             page_size = page_size)
  if (nrow(dc) > 0L) dc[["source"]] <- "drugclip"
  if (nrow(ch) > 0L) ch[["source"]] <- "chembl"
  dplyr::bind_rows(dc, ch)
}

#' Get herbs containing a compound
#'
#' List herbs that contain a specific compound.
#'
#' @param id The UniTCM ingredient ID.
#' @param page Page number (default 1).
#' @param page_size Results per page (default 20).
#' @param all_pages If `TRUE`, fetch all pages.
#' @return A [tibble::tibble()] of herbs with attribute `"total"`.
#' @export
#' @examples
#' \dontrun{
#' get_compound_herbs("UNITCM_I00001")
#' }
get_compound_herbs <- function(id, page = 1L, page_size = 20L,
                               all_pages = FALSE) {
  path <- paste0("/ingredient-explorer/", normalize_id(id), "/herbs")

  if (isTRUE(all_pages)) {
    return(unitcm_paginate(path))
  }

  resp <- unitcm_request(path, query = list(page = page, page_size = page_size))
  items <- resp[["items"]] %||% list()
  result <- if (length(items) > 0L) tibble::as_tibble(items) else tibble::tibble()
  attr(result, "total") <- resp[["total"]] %||% 0L
  result
}

#' Get compound facets and statistics
#'
#' Returns summary statistics and filter option counts for the Ingredient
#' Explorer.
#'
#' @return A named list with fields: `total`, `approved_count`,
#'   `lipinski_counts`, `drug_counts`, `mw_range`, `clogp_range`,
#'   `tpsa_range`, `qed_range`.
#' @export
#' @examples
#' \dontrun{
#' fetch_compound_facets()
#' }
fetch_compound_facets <- function() {
  unitcm_request("/ingredient-explorer/facets")
}

#' Export compounds to CSV
#'
#' Download a CSV export of compounds matching the given filters
#' (max 10,000 rows).
#'
#' @inheritParams search_compounds
#' @param file Output file path (default `"compounds_export.csv"`).
#' @return Invisible file path.
#' @export
#' @examples
#' \dontrun{
#' export_compounds(mw_min = 200, file = "filtered_compounds.csv")
#' }
export_compounds <- function(q = NULL, mw_min = NULL, mw_max = NULL,
                             clogp_min = NULL, clogp_max = NULL,
                             tpsa_min = NULL, tpsa_max = NULL,
                             qed_min = NULL, qed_max = NULL,
                             ring_count_min = NULL, ring_count_max = NULL,
                             lipinski = NULL, is_drug = NULL,
                             sort = NULL, file = "compounds_export.csv") {
  query <- list(
    q = q,
    mw_min = mw_min, mw_max = mw_max,
    clogp_min = clogp_min, clogp_max = clogp_max,
    tpsa_min = tpsa_min, tpsa_max = tpsa_max,
    qed_min = qed_min, qed_max = qed_max,
    ring_count_min = ring_count_min, ring_count_max = ring_count_max,
    lipinski = collapse_param(lipinski, ","),
    is_drug = is_drug,
    sort = sort
  )
  unitcm_download("/ingredient-explorer/export", query = query, file = file)
}

#' Export compound data by module
#'
#' Download a CSV of a specific data module for one compound.
#'
#' @param id The UniTCM ingredient ID.
#' @param module One of `"overview"`, `"physicochemical"`, `"admet"`,
#'   or `"targets"`.
#' @param file Output file path (auto-generated if `NULL`).
#' @return Invisible file path.
#' @export
#' @examples
#' \dontrun{
#' export_compound_module("UNITCM_I00001", "admet")
#' }
export_compound_module <- function(id,
                                   module = c("overview", "physicochemical",
                                              "admet", "targets"),
                                   file = NULL) {
  module <- rlang::arg_match(module)
  file <- file %||% paste0(id, "_", module, ".csv")
  unitcm_download(
    paste0("/ingredient-explorer/", normalize_id(id), "/export/", module),
    file = file
  )
}
