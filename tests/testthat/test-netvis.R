test_that("search_netvis returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      data.frame(id = "H:UNITCM_H001", type = "herb",
                 label = "Ginseng", degree = 50L,
                 stringsAsFactors = FALSE)
    }
  )
  result <- search_netvis("ginseng")
  expect_s3_class(result, "tbl_df")
})

test_that("get_neighbors returns graph structure", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(
        nodes = data.frame(id = c("H:1", "C:1"), type = c("herb", "compound"),
                           stringsAsFactors = FALSE),
        edges = data.frame(source = "H:1", target = "C:1",
                           stringsAsFactors = FALSE),
        has_more = list(compound = FALSE)
      )
    }
  )
  result <- get_neighbors("H:1")
  expect_s3_class(result$nodes, "tbl_df")
  expect_s3_class(result$edges, "tbl_df")
  expect_equal(nrow(result$nodes), 2L)
})

test_that("detect_communities returns tibble", {
  local_mocked_bindings(
    unitcm_request = function(path, method, body, ...) {
      list(communities = list(A = 1L, B = 1L, C = 2L), num_communities = 2L)
    }
  )
  result <- detect_communities(
    c("A", "B", "C"),
    data.frame(source = c("A", "B"), target = c("B", "C"))
  )
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 3L)
  expect_true("community_id" %in% names(result))
})

test_that("get_node_detail returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(id = "H:1", type = "herb", label = "Ginseng")
    }
  )
  result <- get_node_detail("H:1")
  expect_type(result, "list")
})

test_that("fetch_netvis_stats returns a list", {
  local_mocked_bindings(
    unitcm_request = function(path, ...) {
      list(formula = 100L, herb = 500L, compound = 5000L)
    }
  )
  result <- fetch_netvis_stats()
  expect_type(result, "list")
})
