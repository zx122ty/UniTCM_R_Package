#' Make a request to the UniTCM API
#'
#' Low-level function that builds and performs an HTTP request to the
#' UniTCM API. All higher-level functions in this package use this
#' internally.
#'
#' @param path API path appended to the base URL, e.g. `"/herbs"`.
#' @param method HTTP method, either `"GET"` or `"POST"`.
#' @param query Named list of query parameters. `NULL` values are removed.
#' @param body A list to send as JSON body (POST requests only).
#' @param base_url Override the base URL for this request.
#' @return Parsed JSON response as an R list (vectors simplified).
#' @noRd
unitcm_request <- function(path, method = "GET", query = list(),
                           body = NULL, base_url = NULL) {
  base <- base_url %||% get_base_url()

  req <- httr2::request(base) |>
    httr2::req_url_path_append(path) |>
    httr2::req_user_agent("unitcm R package (https://github.com/zx122ty/UniTCM_R_Package)") |>
    httr2::req_retry(max_tries = 3L, is_transient = is_transient_status) |>
    httr2::req_throttle(rate = 80 / 60) |>
    httr2::req_error(body = unitcm_error_body)

  api_key <- get_api_key()
  if (!is.null(api_key)) {
    req <- req |> httr2::req_headers(`X-API-Key` = api_key)
  } else {
    token <- get_unitcm_token()
    if (!is.null(token)) {
      req <- req |> httr2::req_auth_bearer_token(token)
    }
  }

  query <- Filter(Negate(is.null), query)
  if (length(query) > 0L) {
    req <- do.call(httr2::req_url_query, c(list(req), query))
  }

  if (method == "POST") {
    req <- req |> httr2::req_method("POST")
    if (!is.null(body)) {
      req <- req |> httr2::req_body_json(body)
    }
  }

  resp <- httr2::req_perform(req)

  remaining <- httr2::resp_header(resp, "X-RateLimit-Remaining")
  if (!is.null(remaining) && as.integer(remaining) < 5000) {
    warning(sprintf("[UniTCM] API quota remaining: %s. Visit your profile to refresh the key.", remaining),
            call. = FALSE)
  }

  httr2::resp_body_json(resp, simplifyVector = TRUE)
}

#' Download raw bytes from the API (for CSV/file exports)
#'
#' @inheritParams unitcm_request
#' @param file Path to write the downloaded file.
#' @return Invisible file path.
#' @noRd
unitcm_download <- function(path, query = list(), file, base_url = NULL) {
  base <- base_url %||% get_base_url()

  req <- httr2::request(base) |>
    httr2::req_url_path_append(path) |>
    httr2::req_user_agent("unitcm R package (https://github.com/zx122ty/UniTCM_R_Package)") |>
    httr2::req_retry(max_tries = 3L, is_transient = is_transient_status) |>
    httr2::req_error(body = unitcm_error_body)

  api_key <- get_api_key()
  if (!is.null(api_key)) {
    req <- req |> httr2::req_headers(`X-API-Key` = api_key)
  } else {
    token <- get_unitcm_token()
    if (!is.null(token)) {
      req <- req |> httr2::req_auth_bearer_token(token)
    }
  }

  query <- Filter(Negate(is.null), query)
  if (length(query) > 0L) {
    req <- do.call(httr2::req_url_query, c(list(req), query))
  }

  httr2::req_perform(req, path = file)
  invisible(file)
}

#' Check if an HTTP status is transient (for retry logic)
#' @noRd
is_transient_status <- function(resp) {
  httr2::resp_status(resp) %in% c(429L, 503L)
}
