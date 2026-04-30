test_that("unitcm_paginate handles Style A (items + total)", {
  page_count <- 0L
  local_mocked_bindings(
    unitcm_request = function(path, method = "GET", query = list(), ...) {
      page_count <<- page_count + 1L
      if (query$page == 1L) {
        list(items = data.frame(id = c("a", "b"), name = c("A", "B"),
                                stringsAsFactors = FALSE), total = 3L)
      } else {
        list(items = data.frame(id = "c", name = "C",
                                stringsAsFactors = FALSE), total = 3L)
      }
    }
  )

  result <- unitcm_paginate("/herbs", page_size = 2L, progress = FALSE)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 3L)
  expect_equal(attr(result, "total"), 3L)
})

test_that("unitcm_paginate handles Style B (results + count)", {
  local_mocked_bindings(
    unitcm_request = function(path, method = "GET", query = list(), ...) {
      list(results = data.frame(id = "x", stringsAsFactors = FALSE), count = 1L)
    }
  )

  result <- unitcm_paginate("/transcriptome-hub", page_size = 10L,
                            progress = FALSE)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
  expect_equal(attr(result, "total"), 1L)
})

test_that("unitcm_paginate returns empty tibble for no results", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) list(items = list(), total = 0L)
  )

  result <- unitcm_paginate("/herbs", progress = FALSE)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0L)
  expect_equal(attr(result, "total"), 0L)
})

test_that("unitcm_paginate respects max_pages", {
  pages_fetched <- 0L
  local_mocked_bindings(
    unitcm_request = function(path, method = "GET", query = list(), ...) {
      pages_fetched <<- pages_fetched + 1L
      list(items = data.frame(id = paste0("item_", pages_fetched),
                              stringsAsFactors = FALSE), total = 1000L)
    }
  )

  result <- unitcm_paginate("/herbs", max_pages = 3L, page_size = 10L,
                            progress = FALSE)
  expect_equal(pages_fetched, 3L)
})
