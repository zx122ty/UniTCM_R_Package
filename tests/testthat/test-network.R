test_that("as_igraph converts graph response", {
  skip_if_not_installed("igraph")
  resp <- list(
    nodes = tibble::tibble(id = c("A", "B", "C"), type = c("herb", "compound", "target")),
    edges = tibble::tibble(source = c("A", "B"), target = c("B", "C"))
  )
  g <- as_igraph(resp)
  expect_true(igraph::is.igraph(g))
  expect_equal(igraph::vcount(g), 3L)
  expect_equal(igraph::ecount(g), 2L)
})

test_that("as_igraph handles empty graph", {
  skip_if_not_installed("igraph")
  resp <- list(nodes = tibble::tibble(), edges = tibble::tibble())
  g <- as_igraph(resp)
  expect_true(igraph::is.igraph(g))
  expect_equal(igraph::vcount(g), 0L)
})

test_that("as_tidygraph converts graph response", {
  skip_if_not_installed("igraph")
  skip_if_not_installed("tidygraph")
  resp <- list(
    nodes = tibble::tibble(id = c("A", "B"), type = c("herb", "compound")),
    edges = tibble::tibble(source = "A", target = "B")
  )
  tg <- as_tidygraph(resp)
  expect_s3_class(tg, "tbl_graph")
})

test_that("build_formula_herb_network creates igraph", {
  skip_if_not_installed("igraph")
  local_mocked_bindings(
    get_formula = function(id) list(formula_name = "Test Formula"),
    get_formula_doses = function(id) {
      tibble::tibble(herb_name = c("Ren Shen", "Huang Qi"),
                     original_dose = c("10g", "15g"))
    }
  )
  g <- build_formula_herb_network(1)
  expect_true(igraph::is.igraph(g))
  expect_equal(igraph::vcount(g), 3L)
})

test_that("parse_graph_response handles extra fields", {
  resp <- list(
    nodes = data.frame(id = "A", stringsAsFactors = FALSE),
    edges = data.frame(source = character(), target = character(),
                       stringsAsFactors = FALSE),
    has_more = list(compound = TRUE)
  )
  result <- unitcm:::parse_graph_response(resp)
  expect_true("has_more" %in% names(result))
})
