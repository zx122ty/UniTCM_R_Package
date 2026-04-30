test_that("search_herbs returns tibble with total attr", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        items = data.frame(
          unitcm_herb_id = c("H001", "H002"),
          herb_english_name = c("Ginseng", "Astragalus"),
          stringsAsFactors = FALSE
        ),
        total = 100L
      )
    }
  )

  result <- search_herbs(q = "ginseng")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
  expect_equal(attr(result, "total"), 100L)
})

test_that("search_herbs collapses multi-value params with semicolons", {
  captured_query <- NULL
  local_mocked_bindings(
    unitcm_request = function(path, query = list(), ...) {
      captured_query <<- query
      list(items = list(), total = 0L)
    }
  )

  search_herbs(flavors = c("sweet", "bitter"), properties = c("warm"))
  expect_equal(captured_query$flavors, "sweet;bitter")
  expect_equal(captured_query$properties, "warm")
})

test_that("search_herbs handles empty results", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) list(items = list(), total = 0L)
  )

  result <- search_herbs(q = "nonexistent")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0L)
})

test_that("get_herb returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(unitcm_herb_id = "H001", herb_english_name = "Ginseng",
           flavors = "sweet;slightly bitter")
    }
  )

  result <- get_herb("H001")
  expect_type(result, "list")
  expect_equal(result$unitcm_herb_id, "H001")
})

test_that("fetch_herb_facets returns named list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        toxicity = data.frame(value = c("non-toxic", "toxic"),
                              count = c(100L, 10L),
                              stringsAsFactors = FALSE),
        family = data.frame(value = "Fabaceae", count = 50L,
                            stringsAsFactors = FALSE)
      )
    }
  )

  result <- fetch_herb_facets()
  expect_type(result, "list")
  expect_s3_class(result$toxicity, "tbl_df")
})

test_that("get_herb_compounds returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        items = data.frame(
          unitcm_ingredient_id = "I001",
          component_name = "Ginsenoside",
          stringsAsFactors = FALSE
        ),
        total = 1L
      )
    }
  )

  result <- get_herb_compounds("H001")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
})
