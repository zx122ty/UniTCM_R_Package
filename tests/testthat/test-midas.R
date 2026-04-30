test_that("query_gene_diseases returns tibble with gene_mapping attr", {
  local_mocked_bindings(
    unitcm_request = function(path, method, body, ...) {
      list(
        items = data.frame(
          gene_symbol = "TP53",
          disease_name = "Breast cancer",
          score = 0.95,
          stringsAsFactors = FALSE
        ),
        total = 1L,
        gene_mapping = list(TP53 = list(entrez_id = "7157"))
      )
    }
  )

  result <- query_gene_diseases(c("TP53"))
  expect_s3_class(result, "tbl_df")
  expect_equal(attr(result, "total"), 1L)
  expect_type(attr(result, "gene_mapping"), "list")
})

test_that("query_disease_genes returns tibble with matched_diseases", {
  local_mocked_bindings(
    unitcm_request = function(path, method, body, ...) {
      list(
        items = data.frame(
          gene_symbol = "BRCA1",
          score = 0.9,
          stringsAsFactors = FALSE
        ),
        total = 1L,
        matched_diseases = list(list(disease_name = "breast cancer"))
      )
    }
  )

  result <- query_disease_genes("breast cancer")
  expect_s3_class(result, "tbl_df")
  expect_type(attr(result, "matched_diseases"), "list")
})

test_that("convert_gene_ids returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, method, body, ...) {
      list(
        results = data.frame(
          input = c("TP53", "7157"),
          matched_id = c("7157", "7157"),
          status = c("matched", "matched"),
          stringsAsFactors = FALSE
        ),
        total = 2L
      )
    }
  )

  result <- convert_gene_ids(c("TP53", "7157"))
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
})

test_that("query_disease_enrichment returns tibble with attrs", {
  local_mocked_bindings(
    unitcm_request = function(path, method, body, ...) {
      list(
        items = data.frame(
          disease_name = "Breast cancer",
          p_value = 0.001,
          stringsAsFactors = FALSE
        ),
        total_significant = 5L,
        total_tested = 100L,
        input_gene_count = 10L
      )
    }
  )

  result <- query_disease_enrichment(c("TP53", "BRCA1"))
  expect_s3_class(result, "tbl_df")
  expect_equal(attr(result, "total_significant"), 5L)
  expect_equal(attr(result, "total_tested"), 100L)
  expect_equal(attr(result, "input_gene_count"), 10L)
})

test_that("autocomplete_disease rejects short queries", {
  expect_error(autocomplete_disease("a"), "at least 2 characters")
})

test_that("autocomplete_disease returns tibble for valid query", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(
        disease_name = "breast cancer",
        disease_id = "D001",
        gene_count = 500L,
        stringsAsFactors = FALSE
      )
    }
  )

  result <- autocomplete_disease("breast")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
})

test_that("query_source_comparison validates mode", {
  expect_error(
    query_source_comparison(c("TP53"), mode = "invalid"),
    "must be one of"
  )
})

test_that("fetch_midas_sources returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(
        key = c("disgenet", "opentargets"),
        label = c("DisGeNET", "OpenTargets"),
        row_count = c(1000000L, 500000L),
        stringsAsFactors = FALSE
      )
    }
  )

  result <- fetch_midas_sources()
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
})

test_that("fetch_midas_stats returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(total_associations = 5000000L, total_genes = 20000L,
           total_diseases = 15000L)
    }
  )

  result <- fetch_midas_stats()
  expect_type(result, "list")
  expect_equal(result$total_associations, 5000000L)
})
