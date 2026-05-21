# Package-level environment for session state
.unitcm_env <- new.env(parent = emptyenv())
.unitcm_env$base_url <- NULL
.unitcm_env$token <- NULL
.unitcm_env$api_key <- NULL

#' Set the UniTCM API base URL
#'
#' @param url A character string. The base URL for the UniTCM API,
#'   e.g. `"https://unitcm.qfxulab.com/api/v1"`.
#' @return Invisible previous URL value.
#' @export
#' @examples
#' \donttest{
#' set_base_url("https://unitcm.qfxulab.com/api/v1")
#' }
set_base_url <- function(url) {
  old <- .unitcm_env$base_url
  .unitcm_env$base_url <- url
  cli::cli_inform("UniTCM base URL set to {.url {url}}")
  invisible(old)
}

#' Get the UniTCM API base URL
#'
#' Checks in order: (1) session value set via [set_base_url()],
#' (2) option `unitcm.base_url`, (3) environment variable `UNITCM_BASE_URL`,
#' (4) hardcoded default.
#'
#' @return A character string.
#' @export
#' @examples
#' \donttest{
#' get_base_url()
#' }
get_base_url <- function() {
  url <- .unitcm_env$base_url
  if (!is.null(url) && nzchar(url)) return(url)

  url <- getOption("unitcm.base_url")
  if (!is.null(url) && nzchar(url)) return(url)

  url <- Sys.getenv("UNITCM_BASE_URL", unset = "")
  if (nzchar(url)) return(url)

  "https://unitcm.qfxulab.com/api/v1"
}

#' Set a UniTCM API token
#'
#' Stores the token in session memory. Optionally also stores it in the
#' system keyring (requires the \pkg{keyring} package).
#'
#' @param token A character string. The bearer token.
#' @param keyring Logical. If `TRUE`, also store in system keyring.
#' @return Invisible `NULL`.
#' @export
#' @examples
#' \donttest{
#' set_unitcm_token("my-secret-token")
#' }
set_unitcm_token <- function(token, keyring = FALSE) {
  .unitcm_env$token <- token
  if (isTRUE(keyring)) {
    check_pkg("keyring", reason = "to store token in system keyring")
    keyring::key_set_with_value("unitcm", username = "token", password = token)
    cli::cli_inform("Token stored in session and system keyring.")
  } else {
    cli::cli_inform("Token stored in session.")
  }
  invisible(NULL)
}

#' Get the UniTCM API token
#'
#' Checks in order: (1) session value set via [set_unitcm_token()],
#' (2) environment variable `UNITCM_TOKEN`, (3) system keyring.
#'
#' @return A character string, or `NULL` if no token is found.
#' @export
#' @examples
#' \donttest{
#' get_unitcm_token()
#' }
get_unitcm_token <- function() {
  token <- .unitcm_env$token
  if (!is.null(token) && nzchar(token)) return(token)

  env_token <- Sys.getenv("UNITCM_TOKEN", unset = "")
  if (nzchar(env_token)) return(env_token)

  if (requireNamespace("keyring", quietly = TRUE)) {
    kr_token <- tryCatch(
      keyring::key_get("unitcm", username = "token"),
      error = function(e) NULL
    )
    if (!is.null(kr_token) && nzchar(kr_token)) return(kr_token)
  }

  NULL
}

#' Clear the UniTCM API token
#'
#' Removes the token from session memory and optionally from the system
#' keyring.
#'
#' @param keyring Logical. If `TRUE`, also remove from system keyring.
#' @return Invisible `NULL`.
#' @export
#' @examples
#' \donttest{
#' clear_unitcm_token()
#' }
clear_unitcm_token <- function(keyring = FALSE) {
  .unitcm_env$token <- NULL
  if (isTRUE(keyring) && requireNamespace("keyring", quietly = TRUE)) {
    tryCatch(
      keyring::key_delete("unitcm", username = "token"),
      error = function(e) NULL
    )
    cli::cli_inform("Token cleared from session and system keyring.")
  } else {
    cli::cli_inform("Token cleared from session.")
  }
  invisible(NULL)
}


#' Set a UniTCM API Key
#'
#' Stores the API key in session memory. Optionally also stores it in the
#' system keyring (requires the \pkg{keyring} package).
#'
#' @param api_key A character string. The API key (starts with `unitcm_`).
#' @param keyring Logical. If `TRUE`, also store in system keyring.
#' @return Invisible `NULL`.
#' @export
#' @examples
#' \donttest{
#' set_api_key("unitcm_your_key_here")
#' }
set_api_key <- function(api_key, keyring = FALSE) {
  .unitcm_env$api_key <- api_key
  if (isTRUE(keyring)) {
    check_pkg("keyring", reason = "to store API key in system keyring")
    keyring::key_set_with_value("unitcm", username = "api_key", password = api_key)
    cli::cli_inform("API key stored in session and system keyring.")
  } else {
    cli::cli_inform("API key stored in session.")
  }
  invisible(NULL)
}

#' Get the UniTCM API Key
#'
#' Checks in order: (1) session value set via [set_api_key()],
#' (2) environment variable `UNITCM_API_KEY`, (3) system keyring.
#'
#' @return A character string, or `NULL` if no API key is found.
#' @export
#' @examples
#' \donttest{
#' get_api_key()
#' }
get_api_key <- function() {
  key <- .unitcm_env$api_key
  if (!is.null(key) && nzchar(key)) return(key)

  env_key <- Sys.getenv("UNITCM_API_KEY", unset = "")
  if (nzchar(env_key)) return(env_key)

  if (requireNamespace("keyring", quietly = TRUE)) {
    kr_key <- tryCatch(
      keyring::key_get("unitcm", username = "api_key"),
      error = function(e) NULL
    )
    if (!is.null(kr_key) && nzchar(kr_key)) return(kr_key)
  }

  NULL
}

#' Clear the UniTCM API Key
#'
#' Removes the API key from session memory and optionally from the system
#' keyring.
#'
#' @param keyring Logical. If `TRUE`, also remove from system keyring.
#' @return Invisible `NULL`.
#' @export
#' @examples
#' \donttest{
#' clear_api_key()
#' }
clear_api_key <- function(keyring = FALSE) {
  .unitcm_env$api_key <- NULL
  if (isTRUE(keyring) && requireNamespace("keyring", quietly = TRUE)) {
    tryCatch(
      keyring::key_delete("unitcm", username = "api_key"),
      error = function(e) NULL
    )
    cli::cli_inform("API key cleared from session and system keyring.")
  } else {
    cli::cli_inform("API key cleared from session.")
  }
  invisible(NULL)
}
