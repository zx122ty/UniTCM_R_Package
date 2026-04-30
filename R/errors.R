#' Extract error message from UniTCM API response
#'
#' Used as the `body` callback in [httr2::req_error()] to provide
#' human-readable error messages from API error responses.
#'
#' @param resp An httr2 response object.
#' @return A single character string describing the error.
#' @noRd
unitcm_error_body <- function(resp) {
  status <- httr2::resp_status(resp)
  body <- tryCatch(
    httr2::resp_body_json(resp),
    error = function(e) list()
  )

  detail <- body[["detail"]] %||% body[["message"]] %||% ""

  switch(as.character(status),
    "400" = glue::glue("Bad request: {detail}"),
    "404" = glue::glue("Resource not found: {detail}"),
    "429" = "Rate limit exceeded. The request will be retried automatically.",
    "500" = "UniTCM server error. Please try again later.",
    glue::glue("HTTP {status}: {detail}")
  )
}
