test_that("search_compounds returns tibble with total", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        items = data.frame(
          unitcm_ingredient_id = "I001",
          component_name = "Quercetin",
          mw = 302.24,
          stringsAsFactors = FALSE
        ),
        total = 50L
      )
    }
  )

  result <- search_compounds(q = "quercetin")
  expect_s3_class(result, "tbl_df")
  expect_equal(attr(result, "total"), 50L)
})

test_that("get_compound returns a list with xref", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        unitcm_ingredient_id = "I001",
        component_name = "Quercetin",
        xref = list(pubchem_cid = "5280343", cas_number = "117-39-5")
      )
    }
  )

  result <- get_compound("I001")
  expect_type(result, "list")
  expect_equal(result$xref$pubchem_cid, "5280343")
})

test_that("get_compound_admet returns single-row tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        caco2_permeability = -5.2,
        hia = "positive",
        bbb_penetration = "negative"
      )
    }
  )

  result <- get_compound_admet("I001")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1L)
})

test_that("get_compound_targets method=drugclip returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(
        rank = 1:2,
        gene_symbol = c("EGFR", "VEGFA"),
        score = c(0.95, 0.88),
        stringsAsFactors = FALSE
      )
    }
  )

  result <- get_compound_targets("I001", method = "drugclip")
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2L)
})

test_that("get_compound_targets method=both adds source column", {
  call_count <- 0L
  local_mocked_bindings(
    unitcm_request = function(path, query = list(), ...) {
      call_count <<- call_count + 1L
      if (grepl("chembl", path)) {
        list(
          items = data.frame(gene_symbol = "TP53", stringsAsFactors = FALSE),
          total = 1L
        )
      } else {
        data.frame(gene_symbol = "EGFR", stringsAsFactors = FALSE)
      }
    }
  )

  result <- get_compound_targets("I001", method = "both")
  expect_true("source" %in% names(result))
  expect_setequal(result$source, c("drugclip", "chembl"))
})

test_that("get_compound_herbs returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        items = data.frame(
          unitcm_herb_id = "H001",
          herb_english_name = "Ginseng",
          stringsAsFactors = FALSE
        ),
        total = 1L
      )
    }
  )

  result <- get_compound_herbs("I001")
  expect_s3_class(result, "tbl_df")
})

test_that("fetch_compound_facets returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(total = 5000L, approved_count = 200L, mw_range = list(0, 1000))
    }
  )

  result <- fetch_compound_facets()
  expect_type(result, "list")
  expect_equal(result$total, 5000L)
})

test_that("export_compound_module validates module arg", {
  expect_error(
    export_compound_module("I001", "invalid_module"),
    "must be one of"
  )
})
