test_that("search_terms returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        items = data.frame(id = "T1", chinese_name = "\u4eba\u53c2",
                           english_name = "Ginseng",
                           stringsAsFactors = FALSE),
        total = 1L
      )
    }
  )

  result <- search_terms(q = "ginseng")
  expect_s3_class(result, "tbl_df")
  expect_equal(attr(result, "total"), 1L)
})

test_that("get_term returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(id = "T1", chinese_name = "\u4eba\u53c2", english_name = "Ginseng")
    }
  )
  result <- get_term("T1")
  expect_type(result, "list")
})

test_that("list_term_sources returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(value = "src1", label = "Source 1", count = 10L,
                 stringsAsFactors = FALSE)
    }
  )
  result <- list_term_sources()
  expect_s3_class(result, "tbl_df")
})

test_that("list_term_categories returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(value = "cat1", label = "Category 1", count = 5L,
                 stringsAsFactors = FALSE)
    }
  )
  result <- list_term_categories()
  expect_s3_class(result, "tbl_df")
})
