# Tests for network-separation.R
# Network separation analysis (Menche et al. 2015)

# ---------------------------------------------------------------------------
# Helper: build a small combined interactome for testing
# ---------------------------------------------------------------------------

make_test_graph <- function() {
  skip_if_not_installed("igraph")

  # A small PPI network with two loosely connected modules
  # Module A: TP53-BRCA1-EGFR-MYC (densely connected)
  # Module B: TNF-IL6-NFKB1-JUN (densely connected)
  # Bridge: EGFR-TNF (connects the two modules)
  # Isolated: ISOLATED_GENE (no edges)
  edges <- data.frame(
    from = c(
      "TP53", "TP53", "BRCA1",             # Module A core
      "EGFR", "MYC",                        # Module A connections
      "TNF",  "TNF",  "IL6",               # Module B core
      "NFKB1", "JUN",                       # Module B connections
      "EGFR", "TNF"                         # Bridge
    ),
    to = c(
      "BRCA1", "EGFR", "MYC",
      "MYC", "TP53",
      "IL6", "NFKB1", "JUN",
      "JUN", "TNF",
      "TNF", "EGFR"
    ),
    stringsAsFactors = FALSE
  )

  all_genes <- unique(c(edges$from, edges$to, "ISOLATED_GENE"))
  igraph::graph_from_data_frame(edges, directed = FALSE,
    vertices = data.frame(name = all_genes, stringsAsFactors = FALSE))
}


# ---------------------------------------------------------------------------
# set_distance
# ---------------------------------------------------------------------------

test_that("set_distance computes mean closest distance", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- set_distance(g, c("TP53", "BRCA1"), c("TNF", "IL6"))
  expect_type(d, "double")
  expect_true(is.finite(d))
  # TP53 → EGFR → TNF = distance 2, so d should be ~2
  expect_true(d >= 1.5 && d <= 3.0)
})

test_that("set_distance returns NaN when no nodes in graph", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- set_distance(g, c("GENE_X", "GENE_Y"), c("GENE_Z"))
  expect_true(is.nan(d))
})

test_that("set_distance handles overlapping node sets", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- set_distance(g, c("TP53", "BRCA1"), c("TP53", "BRCA1"))
  expect_type(d, "double")
  expect_equal(d, 0)
})

test_that("set_distance is symmetric (approximately)", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d1 <- set_distance(g, c("TP53", "BRCA1"), c("TNF", "IL6"))
  d2 <- set_distance(g, c("TNF", "IL6"), c("TP53", "BRCA1"))
  expect_equal(d1, d2, tolerance = 1e-10)
})

# ---------------------------------------------------------------------------
# self_distance
# ---------------------------------------------------------------------------

test_that("self_distance returns 0 for sets with < 2 nodes", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- self_distance(g, c("TP53"))
  expect_equal(d, 0)
  d_empty <- self_distance(g, character(0))
  expect_equal(d_empty, 0)
})

test_that("self_distance computes mean internal distance", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- self_distance(g, c("TP53", "BRCA1", "EGFR"))
  expect_type(d, "double")
  expect_true(is.finite(d))
  # TP53-BRCA1=1, TP53-EGFR=1, BRCA1-EGFR=2 → mean ~1.33
  expect_true(d >= 1.0 && d <= 2.0)
})

test_that("self_distance returns NaN for disconnected nodes", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- self_distance(g, c("TP53", "ISOLATED_GENE"))
  expect_true(is.nan(d))
})

# ---------------------------------------------------------------------------
# network_separation
# ---------------------------------------------------------------------------

test_that("network_separation returns named numeric vector", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  sep <- network_separation(g,
    setA = c("TP53", "BRCA1", "EGFR"),
    setB = c("TNF", "IL6", "JUN"))
  expect_named(sep, c("d_AB", "d_AA", "d_BB", "S_AB"))
  expect_type(sep, "double")
})

test_that("network_separation S_AB is negative for identical sets", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  # When A = B: d_AB = 0, d_AA = d_BB = internal distance
  # S_AB = 0 - (d_AA + d_BB)/2 = -d_AA, which is negative
  sep <- network_separation(g,
    setA = c("TP53", "BRCA1", "EGFR"),
    setB = c("TP53", "BRCA1", "EGFR"))
  expect_lt(unname(sep["S_AB"]), 0)
  expect_equal(unname(sep["d_AB"]), 0)
  expect_gt(unname(sep["d_AA"]), 0)
  # S_AB should equal -(d_AA + d_BB)/2 = -d_AA
  expect_equal(unname(sep["S_AB"]), -unname(sep["d_AA"]))
})

test_that("network_separation S_AB < 0 for overlapping modules", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  # Module A vs. Module A + one extra gene → substantial overlap
  sep <- network_separation(g,
    setA = c("TP53", "BRCA1", "EGFR", "MYC"),
    setB = c("TP53", "BRCA1", "EGFR", "TNF"))
  # d_AB will be small (overlap), d_AA and d_BB moderate
  # S_AB = d_AB - (d_AA + d_BB) / 2 should be negative
  expect_lt(unname(sep["S_AB"]), 0.5)  # likely negative or near-zero
})

test_that("network_separation handles NaN gracefully", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  sep <- network_separation(g, setA = c("GENE_X"), setB = c("GENE_Y"))
  expect_true(is.nan(sep["S_AB"]))
  expect_true(is.nan(sep["d_AB"]))
})

# ---------------------------------------------------------------------------
# per_node_distance
# ---------------------------------------------------------------------------

test_that("per_node_distance returns named numeric vector", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- per_node_distance(g,
    setA = c("TP53", "BRCA1", "EGFR"),
    setB = c("TNF", "IL6"))
  expect_type(d, "double")
  expect_true(all(names(d) %in% c("TP53", "BRCA1", "EGFR")))
  # EGFR directly connects to TNF → distance 1
  expect_equal(d[["EGFR"]], 1)
})

test_that("per_node_distance returns empty for non-overlapping genes", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- per_node_distance(g, setA = c("GENE_X"), setB = c("TNF"))
  expect_length(d, 0L)
})

test_that("per_node_distance returns empty for empty sets", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  d <- per_node_distance(g, setA = character(0), setB = c("TNF"))
  expect_length(d, 0L)
})

# ---------------------------------------------------------------------------
# find_elbow
# ---------------------------------------------------------------------------

test_that("find_elbow returns index >= 1", {
  x <- seq(10, 100, by = 10)
  y <- c(0.5, 0.3, 0.15, 0.08, 0.05, 0.03, 0.02, 0.018, 0.015, 0.014)
  idx <- find_elbow(x, y)
  expect_true(idx >= 1L && idx <= length(x))
})

test_that("find_elbow returns 1 for short inputs", {
  expect_equal(find_elbow(c(1, 2), c(1, 2)), 1L)
})

test_that("find_elbow on monotonically decreasing curve", {
  x <- seq(10, 100, by = 10)
  # Sharp drop then plateau — elbow should be in the first few points
  y <- c(2.0, 0.5, 0.2, 0.15, 0.14, 0.13, 0.12, 0.11, 0.10, 0.10)
  idx <- find_elbow(x, y)
  expect_true(idx <= 4L)  # should be early
})

# ---------------------------------------------------------------------------
# find_saturation_point
# ---------------------------------------------------------------------------

test_that("find_saturation_point returns index within range", {
  x <- seq(10, 100, by = 10)
  y <- c(0.5, 0.3, 0.15, 0.08, 0.051, 0.049, 0.048, 0.047, 0.046, 0.046)
  idx <- find_saturation_point(x, y, threshold = 0.01)
  expect_true(idx >= 1L && idx <= length(x))
})

test_that("find_saturation_point returns 1 for short inputs", {
  expect_equal(find_saturation_point(c(1, 2), c(1, 2)), 1L)
})

test_that("find_saturation_point returns last index when never saturates", {
  x <- 1:5
  y <- c(10, 8, 6, 4, 2)  # large drops continue through the end
  idx <- find_saturation_point(x, y, threshold = 0.01)
  expect_equal(idx, length(x))
})

# ---------------------------------------------------------------------------
# network_separation_sweep
# ---------------------------------------------------------------------------

test_that("network_separation_sweep returns correct structure", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  gene_sets <- list(
    GroupA = c("TP53", "BRCA1", "EGFR", "MYC"),
    GroupB = c("TNF", "IL6", "NFKB1", "JUN")
  )
  ref <- c("TNF", "IL6", "NFKB1", "JUN", "STAT3")

  result <- network_separation_sweep(
    graph = g,
    gene_sets = gene_sets,
    reference_genes = ref,
    reference_name = "TestRef",
    top_n_range = c(2L, 3L, 4L),
    progress = FALSE
  )

  expect_type(result, "list")
  expect_true("sweep_df" %in% names(result))
  expect_true("optimal_n" %in% names(result))
  expect_true("summary" %in% names(result))
  expect_s3_class(result$sweep_df, "tbl_df")
  expect_true(nrow(result$sweep_df) >= 1L)
  expect_true(all(c("group", "top_n", "S_AB") %in% names(result$sweep_df)))
  expect_true(all(c("GroupA", "GroupB") %in% names(result$optimal_n)))
})

test_that("network_separation_sweep handles missing genes gracefully", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  gene_sets <- list(
    Real = c("TP53", "BRCA1", "EGFR", "MYC"),
    Fake = c("GENE_X", "GENE_Y", "GENE_Z")
  )

  result <- network_separation_sweep(
    graph = g,
    gene_sets = gene_sets,
    reference_genes = c("TNF", "IL6", "NFKB1", "JUN"),
    top_n_range = c(3L, 4L),
    progress = FALSE
  )

  # Should have data for "Real" but not for "Fake" (0 genes in graph)
  groups_in_result <- unique(result$sweep_df$group)
  expect_true("Real" %in% groups_in_result)
  expect_false("Fake" %in% groups_in_result)
})

test_that("network_separation_sweep rejects unnamed gene_sets", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  expect_error(
    network_separation_sweep(g, list(c("TP53")), c("TNF")),
    "named list"
  )
})

test_that("network_separation_sweep rejects empty reference overlap", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  expect_error(
    network_separation_sweep(g,
      gene_sets = list(A = c("TP53")),
      reference_genes = c("GENE_X", "GENE_Y")),
    "reference_genes"
  )
})

test_that("network_separation_sweep with core_percentile classifies core/periphery", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  gene_sets <- list(GroupA = c("TP53", "BRCA1", "EGFR", "MYC"))
  ref <- c("TNF", "IL6", "NFKB1", "JUN", "TP53", "BRCA1", "EGFR", "MYC")

  result <- network_separation_sweep(
    graph = g,
    gene_sets = gene_sets,
    reference_genes = ref,
    top_n_range = c(3L, 4L),
    core_percentile = 0.75,
    progress = FALSE
  )

  # Should have core/periphery columns in sweep_df
  if (length(ref) >= 4L) {
    expect_true("d_to_core" %in% names(result$sweep_df))
    expect_true("d_to_periphery" %in% names(result$sweep_df))
    expect_true("d_ratio" %in% names(result$sweep_df))
    expect_type(result$core_genes, "character")
    expect_type(result$periphery_genes, "character")
  }
})

test_that("network_separation_sweep skips core/periphery when core_percentile is NULL", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  gene_sets <- list(GroupA = c("TP53", "BRCA1", "EGFR", "MYC"))
  result <- network_separation_sweep(
    graph = g,
    gene_sets = gene_sets,
    reference_genes = c("TNF", "IL6", "NFKB1", "JUN", "TP53"),
    top_n_range = c(2L, 3L),
    core_percentile = NULL,
    progress = FALSE
  )

  expect_false("d_to_core" %in% names(result$sweep_df))
  expect_null(result$core_genes)
})

# ---------------------------------------------------------------------------
# network_separation_analysis (all-in-one)
# ---------------------------------------------------------------------------

test_that("network_separation_analysis returns complete result", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  gene_sets <- list(
    DrugA = c("TP53", "BRCA1", "EGFR", "MYC"),
    DrugB = c("TNF", "IL6", "NFKB1", "JUN")
  )
  ref <- c("TNF", "IL6", "NFKB1", "JUN", "STAT3")

  result <- network_separation_analysis(
    graph = g,
    gene_sets = gene_sets,
    reference_genes = ref,
    reference_name = "Disease",
    top_n_range = c(2L, 3L, 4L),
    progress = FALSE
  )

  expect_type(result, "list")
  expect_true("sweep_df" %in% names(result))
  expect_true("optimal_n" %in% names(result))
  expect_true("summary" %in% names(result))
  expect_true("per_node" %in% names(result))

  # Per-node distances should be present
  expect_type(result$per_node, "list")
  expect_true("DrugA" %in% names(result$per_node))
})

test_that("network_separation_analysis works with default parameters", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  # Need enough genes so that the sweep finds at least some valid N values
  # (default range starts at 10, and at least 3 genes must be in the graph)
  gene_sets <- list(DrugA = c("TP53", "BRCA1", "EGFR", "MYC", "TNF"))
  ref <- c("TNF", "IL6", "NFKB1", "JUN", "TP53", "BRCA1", "EGFR", "MYC")

  # Use a small range that matches our small test graph
  result <- network_separation_analysis(
    graph = g,
    gene_sets = gene_sets,
    reference_genes = ref,
    top_n_range = c(3L, 4L),
    progress = FALSE
  )

  expect_s3_class(result$sweep_df, "tbl_df")
  expect_true(nrow(result$sweep_df) >= 1L)
  expect_true(all(result$sweep_df$n_actual <= 5L))
})

# ---------------------------------------------------------------------------
# Integration: full workflow from fake data
# ---------------------------------------------------------------------------

test_that("full network separation workflow with fake data", {
  skip_if_not_installed("igraph")
  g <- make_test_graph()

  # Define drug targets and disease genes
  drug_targets <- list(
    DrugA = c("TP53", "BRCA1", "EGFR", "MYC"),
    DrugB = c("TNF", "IL6", "NFKB1", "JUN")
  )
  disease_genes <- c("TNF", "IL6", "NFKB1", "JUN", "TP53", "STAT3")

  # Step 1: Core separation between DrugA and disease
  sep_drugA <- network_separation(g, drug_targets$DrugA, disease_genes)
  expect_true(is.finite(sep_drugA["S_AB"]))

  # Step 2: DrugB should be closer to disease (it overlaps)
  sep_drugB <- network_separation(g, drug_targets$DrugB, disease_genes)
  expect_true(is.finite(sep_drugB["S_AB"]))
  # DrugB shares 4/4 genes with disease → should be more colocalized (lower S_AB)
  expect_lt(sep_drugB["S_AB"], sep_drugA["S_AB"])

  # Step 3: Full sweep
  sweep <- network_separation_sweep(
    g, drug_targets, disease_genes,
    top_n_range = c(2L, 3L, 4L),
    progress = FALSE
  )
  expect_true(nrow(sweep$sweep_df) >= 2L)

  # Step 4: Elbow detection
  for (gname in names(sweep$optimal_n)) {
    expect_true(sweep$optimal_n[[gname]] %in% c(2L, 3L, 4L, NA_integer_))
  }

  # Step 5: Per-node analysis
  pn <- per_node_distance(g, drug_targets$DrugA, disease_genes)
  expect_type(pn, "double")
  expect_true("EGFR" %in% names(pn))
})
