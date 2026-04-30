test_that("search_formulas returns tibble with total", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        items = data.frame(
          order = 1L,
          formula_name = "Liu Wei Di Huang Wan",
          disease_name = "Insomnia",
          stringsAsFactors = FALSE
        ),
        total = 200L
      )
    }
  )

  result <- search_formulas(q = "insomnia")
  expect_s3_class(result, "tbl_df")
  expect_equal(attr(result, "total"), 200L)
})

test_that("search_formulas collapses comma-sep params", {
  captured_query <- NULL
  local_mocked_bindings(
    unitcm_request = function(path, query = list(), ...) {
      captured_query <<- query
      list(items = list(), total = 0L)
    }
  )

  search_formulas(book_sources = c("A", "B"), mapping_confidence = c("high", "medium"))
  expect_equal(captured_query$book_sources, "A,B")
  expect_equal(captured_query$mapping_confidence, "high,medium")
})

test_that("get_formula returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(order = 1L, formula_name = "Test Formula", efficacy = "Tonify Qi")
    }
  )

  result <- get_formula(1)
  expect_type(result, "list")
  expect_equal(result$formula_name, "Test Formula")
})

test_that("get_formula_doses returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(
        herb_name = c("Ren Shen", "Huang Qi"),
        original_dose = c("10g", "15g"),
        stringsAsFactors = FALSE
      )
    }
  )

  result <- get_formula_doses(1)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
})

test_that("fetch_disease_tree returns nested list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        list(label = "Neoplasms", count = 100L, children = list(
          list(label = "Breast cancer", count = 20L, children = list())
        ))
      )
    }
  )

  result <- fetch_disease_tree()
  expect_type(result, "list")
  expect_equal(result[[1]]$label, "Neoplasms")
})

test_that("list_book_sources returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(value = "Ben Cao", label = "Ben Cao", count = 50L,
                 stringsAsFactors = FALSE)
    }
  )

  result <- list_book_sources()
  expect_s3_class(result, "tbl_df")
})
