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
