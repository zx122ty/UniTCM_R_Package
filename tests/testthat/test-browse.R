test_that("search_datasets returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        items = data.frame(submission_id = "TMA2025001",
                           project_title = "Test",
                           stringsAsFactors = FALSE),
        total = 1L
      )
    }
  )
  result <- search_datasets(q = "ginseng")
  expect_s3_class(result, "tbl_df")
  expect_equal(attr(result, "total"), 1L)
})

test_that("search_datasets uses general_search when search_mode set", {
  captured_path <- NULL
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      captured_path <<- path
      list(items = list(), total = 0L)
    }
  )
  search_datasets(q = "test", search_mode = "exact")
  expect_equal(captured_path, "/browse/general_search")
})

test_that("get_dataset returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(submission_id = "TMA2025001", persons = list(), publications = list())
    }
  )
  result <- get_dataset("TMA2025001")
  expect_type(result, "list")
})

test_that("get_similar_datasets returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(submission_id = "TMA2025002",
                 similarity_score = 0.85,
                 stringsAsFactors = FALSE)
    }
  )
  result <- get_similar_datasets("TMA2025001")
  expect_s3_class(result, "tbl_df")
})

test_that("fetch_dataset_stats returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(total_datasets = 50L, total_downloads = 1000L)
    }
  )
  result <- fetch_dataset_stats()
  expect_type(result, "list")
})
