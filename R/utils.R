#' Flatten a nested API response to a tibble
#'
#' Recursively flattens a nested list into a single-row tibble. Nested lists
#' that cannot be further flattened are kept as list-columns.
#'
#' @param x A named list from an API response.
#' @return A single-row [tibble::tibble()].
#' @export
#' @examples
#' \donttest{
#' herb <- get_herb("UNITCM_H001")
#' flatten_response(herb)
#' }
flatten_response <- function(x) {
  if (!is.list(x) || is.null(names(x))) {
    rlang::abort("`x` must be a named list.")
  }

  flat <- list()
  for (nm in names(x)) {
    val <- x[[nm]]
    if (is.null(val)) {
      flat[[nm]] <- NA
    } else if (is.atomic(val) && length(val) == 1L) {
      flat[[nm]] <- val
    } else {
      flat[[nm]] <- list(val)
    }
  }
  tibble::as_tibble(flat)
}

#' Clear unitcm cache
#'
#' Clears any memoized API results. Currently a no-op placeholder for
#' future caching support.
#'
#' @return Invisible `NULL`.
#' @export
unitcm_cache_clear <- function() {
  cli::cli_inform("Cache cleared (no active cache in current version).")
  invisible(NULL)
}

#' Check that a suggested package is installed
#'
#' @param pkg Package name as a string.
#' @param reason Why the package is needed.
#' @return Invisible `TRUE` if installed.
#' @noRd
check_pkg <- function(pkg, reason = NULL) {
  rlang::check_installed(pkg, reason = reason)
}

#' Normalize a UniTCM entity ID to its numeric form
#'
#' The UniTCM API expects numeric IDs (e.g. `1`), while users typically
#' refer to entities by their prefixed display form (e.g. `"UNITCM_H001"`,
#' `"UNITCM_I00001"`). This helper extracts the first integer it finds in
#' the input and returns it as a zero-stripped string. Pure integers and
#' integer-like strings pass through unchanged.
#'
#' @param x A character or numeric ID. Accepts forms like `"UNITCM_H001"`,
#'   `"UNITCM_I00001"`, `"1"`, or `1L`.
#' @return A character string of digits (no leading zeros).
#' @noRd
normalize_id <- function(x) {
  if (is.null(x) || length(x) == 0L || (length(x) == 1L && is.na(x))) {
    rlang::abort("ID cannot be NULL, NA, or empty.")
  }
  if (length(x) > 1L) {
    return(vapply(x, normalize_id, character(1L), USE.NAMES = FALSE))
  }
  if (is.numeric(x)) {
    return(as.character(as.integer(x)))
  }
  s <- as.character(x)
  m <- regmatches(s, regexpr("\\d+", s))
  if (length(m) == 0L || !nzchar(m)) {
    rlang::abort(sprintf("No numeric ID found in '%s'.", s))
  }
  as.character(as.integer(m))
}

#' Normalize a NetVis typed node ID
#'
#' NetVis node IDs are composite: a single-letter type prefix (`H` herb,
#' `C` compound/ingredient, `T` target, `F` formula, `D` disease) plus a
#' colon plus the entity ID. This helper accepts either the display form
#' (`"H:UNITCM_H001"`) or the numeric form (`"H:1"`) and always returns
#' the numeric form expected by the API. Targets and other non-prefixed
#' entities (e.g. `"T:TP53"`) pass through unchanged.
#'
#' @param x A character node ID, e.g. `"H:UNITCM_H001"` or `"H:1"`.
#' @return A character node ID with numeric suffix where applicable.
#' @noRd
normalize_node_id <- function(x) {
  if (is.null(x) || length(x) == 0L || (length(x) == 1L && is.na(x))) {
    rlang::abort("Node ID cannot be NULL, NA, or empty.")
  }
  if (length(x) > 1L) {
    return(vapply(x, normalize_node_id, character(1L), USE.NAMES = FALSE))
  }
  s <- as.character(x)
  parts <- strsplit(s, ":", fixed = TRUE)[[1L]]
  if (length(parts) != 2L) return(s)
  type <- parts[[1L]]
  suffix <- parts[[2L]]
  if (grepl("^UNITCM_", suffix, ignore.case = TRUE)) {
    suffix <- normalize_id(suffix)
  }
  paste0(type, ":", suffix)
}

#' Collapse a character vector for query parameters
#'
#' @param x A character vector or `NULL`.
#' @param sep Separator string (default `","`).
#' @return A single string, or `NULL` if input is `NULL`.
#' @noRd
collapse_param <- function(x, sep = ",") {
  if (is.null(x)) return(NULL)
  paste(x, collapse = sep)
}
