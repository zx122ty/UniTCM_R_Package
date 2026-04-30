#' Auto-paginate a UniTCM API endpoint
#'
#' Fetches all pages from a paginated endpoint and combines the results
#' into a single tibble. Handles both pagination styles used by the API.
#'
#' @param path API path.
#' @param query Named list of query parameters (excluding `page`/`page_size`).
#' @param max_pages Maximum number of pages to fetch (default 50).
#' @param page_size Number of records per page (default 100).
#' @param progress Show a CLI progress bar (default `TRUE`).
#' @return A [tibble::tibble()] with attribute `"total"` set to the
#'   server-reported total count.
#' @noRd
unitcm_paginate <- function(path, query = list(), max_pages = 50L,
                            page_size = 100L, progress = TRUE) {
  all_items <- list()
  page <- 1L

  if (progress) {
    cli::cli_progress_bar("Fetching pages", clear = FALSE)
  }

  repeat {
    query[["page"]] <- page
    query[["page_size"]] <- page_size
    resp <- unitcm_request(path, query = query)

    items <- resp[["items"]] %||% resp[["results"]] %||% list()
    total <- resp[["total"]] %||% resp[["count"]] %||% 0L

    if (length(items) == 0L) break

    if (is.data.frame(items)) {
      all_items <- c(all_items, list(tibble::as_tibble(items)))
    } else if (is.list(items)) {
      all_items <- c(all_items, list(
        tryCatch(
          tibble::as_tibble(do.call(rbind, lapply(items, as.data.frame,
            stringsAsFactors = FALSE))),
          error = function(e) tibble::as_tibble(items)
        )
      ))
    }

    if (progress) cli::cli_progress_update()

    fetched <- page * page_size
    if (fetched >= total || page >= max_pages) break
    page <- page + 1L
  }

  if (progress) cli::cli_progress_done()

  if (length(all_items) == 0L) {
    result <- tibble::tibble()
    attr(result, "total") <- 0L
    return(result)
  }

  result <- dplyr::bind_rows(all_items)
  attr(result, "total") <- as.integer(total)
  result
}
