test_that("search_transcriptomes handles Style B pagination", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        results = data.frame(id = "TCMtrans00001",
                             stringsAsFactors = FALSE),
        count = 1L
      )
    }
  )
  result <- search_transcriptomes(search = "ginseng")
  expect_s3_class(result, "tbl_df")
  expect_equal(attr(result, "total"), 1L)
})

test_that("get_transcriptome returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(id = "TCMtrans00001", organism = "Homo sapiens")
    }
  )
  result <- get_transcriptome("TCMtrans00001")
  expect_type(result, "list")
})

test_that("get_analysis_modules returns character vector", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(available_modules = c("deg", "go", "kegg"), total = 3L)
    }
  )
  result <- get_analysis_modules("TCMtrans00001")
  expect_type(result, "character")
  expect_equal(length(result), 3L)
})

test_that("get_analysis_data validates module arg", {
  expect_error(get_analysis_data("TCMtrans00001", "invalid"), "must be one of")
})

test_that("get_analysis_data returns tibble for tabular modules", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(gene = "TP53", log2FC = 2.5, padj = 0.01,
                 stringsAsFactors = FALSE)
    }
  )
  result <- get_analysis_data("TCMtrans00001", "deg")
  expect_s3_class(result, "tbl_df")
})

test_that("fetch_transcriptome_stats returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(total_datasets = 100L, total_organisms = 5L)
    }
  )
  result <- fetch_transcriptome_stats()
  expect_type(result, "list")
})
