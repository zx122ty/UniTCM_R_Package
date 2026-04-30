test_that("search_ontology returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(
        tcm_id = "TCM_0001",
        name = "Qi stagnation",
        name_cn = "\u6c14\u6ede",
        level = 2L,
        stringsAsFactors = FALSE
      )
    }
  )

  result <- search_ontology("Qi stagnation")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
})

test_that("get_ontology_entity returns a list with sub-elements", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        tcm_id = "TCM_0001",
        name = "Qi stagnation",
        ancestors = list(),
        children = list(),
        external_mappings = list(),
        relations = list()
      )
    }
  )

  result <- get_ontology_entity("TCM_0001")
  expect_type(result, "list")
  expect_true("ancestors" %in% names(result))
  expect_true("external_mappings" %in% names(result))
})

test_that("search_ontology_mapping validates database argument", {
  expect_error(
    search_ontology_mapping("InvalidDB", "123"),
    "must be one of"
  )
})

test_that("search_ontology_mapping returns tibble for valid database", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(
        tcm_id = "TCM_0001",
        name = "Qi stagnation",
        stringsAsFactors = FALSE
      )
    }
  )

  result <- search_ontology_mapping("MeSH", "D008516")
  expect_s3_class(result, "tbl_df")
})

test_that("export_ontology validates format argument", {
  expect_error(
    export_ontology("invalid_format"),
    "must be one of"
  )
})

test_that("fetch_ontology_stats returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(total_entities = 5000L, total_relations = 10000L)
    }
  )

  result <- fetch_ontology_stats()
  expect_type(result, "list")
  expect_equal(result$total_entities, 5000L)
})

test_that("get_ontology_children returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(
        tcm_id = c("TCM_0002", "TCM_0003"),
        name = c("Child1", "Child2"),
        has_children = c(TRUE, FALSE),
        stringsAsFactors = FALSE
      )
    }
  )

  result <- get_ontology_children("TCM_0001")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
})
