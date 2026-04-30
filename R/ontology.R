#' Search the TCM Ontology
#'
#' Full-text search across TCM ontology entities.
#'
#' @param q Search query (required).
#' @param limit Maximum results to return (default 20).
#' @param level Filter by ontology level (integer, 1--4).
#' @param category Filter by top-level category.
#' @return A [tibble::tibble()] with columns: `tcm_id`, `name`, `name_cn`,
#'   `level`, `path`, `match_field`, `highlight`.
#' @export
#' @examples
#' \donttest{
#' search_ontology("Qi stagnation")
#' }
search_ontology <- function(q, limit = 20L, level = NULL, category = NULL) {
  resp <- unitcm_request(
    "/tools/tcm-ontology/search",
    query = list(q = q, limit = limit, level = level, category = category)
  )
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get a TCM ontology entity
#'
#' Retrieve full detail for one entity including ancestors, children,
#' external mappings, and relations.
#'
#' @param tcm_id The TCM ontology ID (e.g. `"TCM_0001"`).
#' @return A named list with sub-elements: `ancestors`, `children`,
#'   `external_mappings`, `relations`.
#' @export
#' @examples
#' \donttest{
#' get_ontology_entity("TCM_0001")
#' }
get_ontology_entity <- function(tcm_id) {
  unitcm_request(paste0("/tools/tcm-ontology/entity/", tcm_id))
}

#' Get children of an ontology entity
#'
#' @param tcm_id The TCM ontology ID.
#' @return A [tibble::tibble()] with columns: `tcm_id`, `name`, `name_cn`,
#'   `level`, `path`, `children_count`, `has_children`.
#' @export
#' @examples
#' \donttest{
#' get_ontology_children("TCM_0001")
#' }
get_ontology_children <- function(tcm_id) {
  resp <- unitcm_request(paste0("/tools/tcm-ontology/entity/", tcm_id, "/children"))
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get all descendants of an ontology entity
#'
#' @param tcm_id The TCM ontology ID.
#' @param max_level Maximum depth to descend (integer or `NULL` for all).
#' @return A [tibble::tibble()].
#' @export
#' @examples
#' \donttest{
#' get_ontology_descendants("TCM_0001", max_level = 2)
#' }
get_ontology_descendants <- function(tcm_id, max_level = NULL) {
  resp <- unitcm_request(
    paste0("/tools/tcm-ontology/entity/", tcm_id, "/descendants"),
    query = list(max_level = max_level)
  )
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get ancestors of an ontology entity
#'
#' @param tcm_id The TCM ontology ID.
#' @return A [tibble::tibble()] with columns: `tcm_id`, `name`, `name_cn`,
#'   `level`.
#' @export
#' @examples
#' \donttest{
#' get_ontology_ancestors("TCM_0001")
#' }
get_ontology_ancestors <- function(tcm_id) {
  resp <- unitcm_request(paste0("/tools/tcm-ontology/entity/", tcm_id, "/ancestors"))
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Fetch the TCM ontology tree
#'
#' Returns the full ontology as a recursive nested list.
#'
#' @param depth Tree depth to return (1--10, default 4).
#' @return A recursive nested list: `list(tcm_id, name, name_cn, level,
#'   children = list(...))`.
#' @export
#' @examples
#' \donttest{
#' tree <- fetch_ontology_tree(depth = 2)
#' }
fetch_ontology_tree <- function(depth = 4L) {
  unitcm_request("/tools/tcm-ontology/tree", query = list(depth = depth))
}

#' Fetch ontology statistics
#'
#' @return A named list with fields: `total_entities`, `total_level1`--
#'   `total_level4`, `total_relations`, `total_mappings`, `categories`.
#' @export
#' @examples
#' \donttest{
#' fetch_ontology_stats()
#' }
fetch_ontology_stats <- function() {
  unitcm_request("/tools/tcm-ontology/stats")
}

#' List top-level ontology categories
#'
#' @return A [tibble::tibble()] of level-1 entities.
#' @export
#' @examples
#' \donttest{
#' list_ontology_categories()
#' }
list_ontology_categories <- function() {
  resp <- unitcm_request("/tools/tcm-ontology/categories")
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get ontology entities by level
#'
#' @param level Ontology level (integer, 1--4).
#' @param parent_id Optional parent entity ID to filter by.
#' @return A [tibble::tibble()].
#' @export
#' @examples
#' \donttest{
#' get_ontology_by_level(2)
#' }
get_ontology_by_level <- function(level, parent_id = NULL) {
  resp <- unitcm_request(
    paste0("/tools/tcm-ontology/by-level/", level),
    query = list(parent_id = parent_id)
  )
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Search ontology external mapping
#'
#' Find TCM entities mapped to an external database identifier.
#'
#' @param database External database name. Must be one of: `"UMLS"`,
#'   `"SNOMED_CT"`, `"ICD11_TM"`, `"MeSH"`.
#' @param external_id The external identifier to look up.
#' @return A [tibble::tibble()] of matched TCM entities.
#' @export
#' @examples
#' \donttest{
#' search_ontology_mapping("MeSH", "D008516")
#' }
search_ontology_mapping <- function(database, external_id) {
  database <- rlang::arg_match(database,
    values = c("UMLS", "SNOMED_CT", "ICD11_TM", "MeSH"))
  resp <- unitcm_request(
    "/tools/tcm-ontology/mapping/search",
    query = list(database = database, external_id = external_id)
  )
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Export the TCM ontology
#'
#' Download the full ontology in JSON, OWL/RDF, or CSV format.
#'
#' @param format Export format: `"json"`, `"owl"`, or `"csv"`.
#' @param file Output file path. If `NULL`, auto-named as
#'   `"unitcm_ontology.{ext}"`.
#' @param depth Tree depth for JSON export (default 4).
#' @return Invisible file path.
#' @export
#' @examples
#' \donttest{
#' export_ontology("csv")
#' export_ontology("json", depth = 2, file = "ontology_shallow.json")
#' }
export_ontology <- function(format = c("json", "owl", "csv"),
                            file = NULL, depth = 4L) {
  format <- rlang::arg_match(format)

  ext <- switch(format, json = "json", owl = "owl", csv = "csv")
  file <- file %||% paste0("unitcm_ontology.", ext)

  query <- if (format == "json") list(depth = depth) else list()
  unitcm_download(
    paste0("/tools/tcm-ontology/export/", format),
    query = query, file = file
  )
}
