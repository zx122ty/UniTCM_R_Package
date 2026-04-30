test_that("search_mechanisms returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        items = data.frame(tcm_term_id = "TMM001",
                           tcm_term_en = "Qi deficiency",
                           stringsAsFactors = FALSE),
        total = 1L
      )
    }
  )
  result <- search_mechanisms(search = "Qi")
  expect_s3_class(result, "tbl_df")
})

test_that("get_mechanism returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(tcm_term_id = "TMM001", biomarkers = list("IL-6", "TNF-alpha"))
    }
  )
  result <- get_mechanism("TMM001")
  expect_type(result, "list")
  expect_type(result$biomarkers, "list")
})

test_that("fetch_mechanism_filters returns named list of tibbles", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(value = "cat1", label = "Category 1", count = 5L,
                 stringsAsFactors = FALSE)
    }
  )
  result <- fetch_mechanism_filters()
  expect_type(result, "list")
  expect_true(all(c("categories", "omics_types", "species") %in% names(result)))
})
