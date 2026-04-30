test_that("fetch_latest_submissions returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(submission_id = "TMA2025001",
                 project_title = "Test project",
                 stringsAsFactors = FALSE)
    }
  )
  result <- fetch_latest_submissions()
  expect_s3_class(result, "tbl_df")
})

test_that("fetch_home_stats returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(total_datasets = 50L, total_downloads = 1000L)
    }
  )
  result <- fetch_home_stats()
  expect_type(result, "list")
})

test_that("fetch_tcm_classification_stats returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(classification = "Herb", count = 100L, percentage = 0.5,
                 stringsAsFactors = FALSE)
    }
  )
  result <- fetch_tcm_classification_stats()
  expect_s3_class(result, "tbl_df")
})

test_that("fetch_omics_type_stats returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(omics_type = "Transcriptomics", count = 30L, percentage = 0.6,
                 stringsAsFactors = FALSE)
    }
  )
  result <- fetch_omics_type_stats()
  expect_s3_class(result, "tbl_df")
})
