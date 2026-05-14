#' Get latest submissions
#'
#' @return A [tibble::tibble()] of recent submissions with columns:
#'   `submission_id`, `project_title`, `submitted_by`, `updated_at`,
#'   `institution`, `total_file_size`.
#' @export
#' @examples
#' \dontrun{
#' fetch_latest_submissions()
#' }
fetch_latest_submissions <- function() {
  resp <- unitcm_request("/home/latest-submissions")
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }

  tibble::tibble()
}

#' Get homepage statistics
#'
#' @return A named list with fields: `total_datasets`, `total_downloads`,
#'   `total_file_size`, `recent_submissions_count`.
#' @export
#' @examples
#' \dontrun{
#' fetch_home_stats()
#' }
fetch_home_stats <- function() {
  unitcm_request("/home/stats")
}

#' Get TCM classification statistics
#'
#' @return A [tibble::tibble()] with columns: `classification`, `count`,
#'   `percentage`.
#' @export
#' @examples
#' \dontrun{
#' fetch_tcm_classification_stats()
#' }
fetch_tcm_classification_stats <- function() {
  resp <- unitcm_request("/home/tcm-classification-stats")
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get omics type statistics
#'
#' @return A [tibble::tibble()] with columns: `omics_type`, `count`,
#'   `percentage`.
#' @export
#' @examples
#' \dontrun{
#' fetch_omics_type_stats()
#' }
fetch_omics_type_stats <- function() {
  resp <- unitcm_request("/home/omics-type-stats")
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}
