test_that("%||% returns non-NULL value", {
  expect_equal(1 %||% 2, 1)
  expect_equal(NULL %||% 2, 2)
  expect_equal(NULL %||% NULL, NULL)
})

test_that("flatten_response converts named list to tibble", {
  x <- list(id = "H001", name = "Ginseng", score = 0.95)
  result <- flatten_response(x)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
  expect_equal(result$id, "H001")
  expect_equal(result$name, "Ginseng")
})

test_that("flatten_response handles nested lists as list-columns", {
  x <- list(id = "H001", aliases = c("a", "b", "c"))
  result <- flatten_response(x)
  expect_s3_class(result, "tbl_df")
  expect_true(is.list(result$aliases))
})

test_that("flatten_response handles NULL values as NA", {
  x <- list(id = "H001", missing = NULL)
  result <- flatten_response(x)
  expect_true(is.na(result$missing))
})

test_that("flatten_response rejects non-named lists", {
  expect_error(flatten_response(list(1, 2, 3)), "named list")
  expect_error(flatten_response("string"), "named list")
})

test_that("collapse_param works correctly", {
  expect_null(collapse_param(NULL))
  expect_equal(collapse_param(c("a", "b"), ","), "a,b")
  expect_equal(collapse_param(c("x", "y"), ";"), "x;y")
  expect_equal(collapse_param("single", ","), "single")
})

test_that("unitcm_cache_clear runs without error", {
  expect_message(unitcm_cache_clear(), "Cache cleared")
})
