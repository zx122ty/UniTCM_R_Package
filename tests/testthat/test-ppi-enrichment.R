# Tests for ppi-enrichment.R
# PPI network and enrichment analysis functions

# ---------------------------------------------------------------------------
# Helper: build a small PPI edge tibble for igraph-based tests
# ---------------------------------------------------------------------------

make_fake_ppi <- function() {
  tibble::tibble(
    gene1 = c("TP53",  "TP53",  "TP53",  "BRCA1", "EGFR",  "MYC"),
    gene2 = c("BRCA1", "EGFR",  "MYC",   "EGFR",  "VEGFA", "AKT1"),
    score = c(900L,    850L,    700L,    800L,    600L,    750L)
  )
}

# ---------------------------------------------------------------------------
# query_string_ppi
# ---------------------------------------------------------------------------

test_that("query_string_ppi returns a tibble with correct columns", {
  tsv_body <- paste(
    "preferredName_A\tpreferredName_B\tscore",
    "TP53\tBRCA1\t0.900",
    "TP53\tEGFR\t0.850",
    "BRCA1\tEGFR\t0.800",
    sep = "\n"
  )

  local_mocked_bindings(
    req_perform = function(req, ...) {
      structure(list(), class = "httr2_response")
    },
    resp_body_string = function(resp, ...) tsv_body,
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  result <- query_string_ppi(c("TP53", "BRCA1", "EGFR"))
  expect_s3_class(result, "tbl_df")
  expect_true(all(c("gene1", "gene2", "score") %in% names(result)))
  expect_equal(nrow(result), 3L)
  expect_type(result$score, "integer")
})

test_that("query_string_ppi deduplicates input genes", {
  tsv_body <- "preferredName_A\tpreferredName_B\tscore\nTP53\tBRCA1\t0.900"

  local_mocked_bindings(
    req_perform = function(req, ...) {
      structure(list(), class = "httr2_response")
    },
    resp_body_string = function(resp, ...) tsv_body,
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  result <- query_string_ppi(c("TP53", "TP53", "BRCA1"))
  expect_equal(nrow(result), 1L)
})

test_that("query_string_ppi handles empty API response gracefully", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      structure(list(), class = "httr2_response")
    },
    resp_body_string = function(resp, ...) "",
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  result <- query_string_ppi(c("GENE_X", "GENE_Y"))
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0L)
})

test_that("query_string_ppi handles API error with tryCatch", {
  local_mocked_bindings(
    req_perform = function(req, ...) stop("Connection refused"),
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  result <- query_string_ppi(c("TP53"))
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 0L)
})

test_that("query_string_ppi respects batch_size", {
  call_count <- 0L
  tsv_body <- "preferredName_A\tpreferredName_B\tscore\nG1\tG2\t0.500"

  local_mocked_bindings(
    req_perform = function(req, ...) {
      call_count <<- call_count + 1L
      structure(list(), class = "httr2_response")
    },
    resp_body_string = function(resp, ...) tsv_body,
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  # 10 genes, batch_size = 3 → expect 4 batches
  genes <- paste0("GENE", 1:10)
  query_string_ppi(genes, batch_size = 3L)
  expect_equal(call_count, 4L)
})

# ---------------------------------------------------------------------------
# build_ppi_network
# ---------------------------------------------------------------------------

test_that("build_ppi_network creates an igraph object", {
  skip_if_not_installed("igraph")

  ppi <- make_fake_ppi()
  genes <- unique(c(ppi$gene1, ppi$gene2))
  g <- build_ppi_network(ppi, genes)

  expect_true(igraph::is_igraph(g))
  expect_false(igraph::is_directed(g))
})

test_that("build_ppi_network includes all nodes even isolated ones", {
  skip_if_not_installed("igraph")

  ppi <- make_fake_ppi()
  genes <- c(unique(c(ppi$gene1, ppi$gene2)), "ISOLATED")
  g <- build_ppi_network(ppi, genes)

  expect_equal(igraph::vcount(g), length(genes))
  expect_true("ISOLATED" %in% igraph::V(g)$name)
})

test_that("build_ppi_network sets edge weights correctly", {
  skip_if_not_installed("igraph")

  ppi <- make_fake_ppi()
  genes <- unique(c(ppi$gene1, ppi$gene2))
  g <- build_ppi_network(ppi, genes)

  expect_equal(igraph::ecount(g), nrow(ppi))
  # First edge score 900 → weight 0.9
  expect_equal(igraph::E(g)$weight[1], 0.9)
})

test_that("build_ppi_network handles empty ppi_df", {
  skip_if_not_installed("igraph")

  ppi <- tibble::tibble(gene1 = character(), gene2 = character(), score = integer())
  genes <- c("A", "B", "C")
  g <- build_ppi_network(ppi, genes)

  expect_equal(igraph::vcount(g), 3L)
  expect_equal(igraph::ecount(g), 0L)
})

# ---------------------------------------------------------------------------
# identify_hub_genes
# ---------------------------------------------------------------------------

test_that("identify_hub_genes returns named numeric vector", {
  skip_if_not_installed("igraph")

  ppi <- make_fake_ppi()
  genes <- unique(c(ppi$gene1, ppi$gene2))
  g <- build_ppi_network(ppi, genes)

  hubs <- identify_hub_genes(g, top_n = 3L)
  expect_type(hubs, "double")
  expect_true(length(hubs) <= 3L)
  expect_true(all(nzchar(names(hubs))))
})

test_that("identify_hub_genes sorts by degree descending", {
  skip_if_not_installed("igraph")

  ppi <- make_fake_ppi()
  genes <- unique(c(ppi$gene1, ppi$gene2))
  g <- build_ppi_network(ppi, genes)

  hubs <- identify_hub_genes(g, top_n = 10L)
  expect_equal(hubs, sort(hubs, decreasing = TRUE))
  # TP53 appears in 3 edges → should be top hub
  expect_equal(names(hubs)[1L], "TP53")
})

test_that("identify_hub_genes respects top_n", {
  skip_if_not_installed("igraph")

  ppi <- make_fake_ppi()
  genes <- unique(c(ppi$gene1, ppi$gene2))
  g <- build_ppi_network(ppi, genes)

  hubs <- identify_hub_genes(g, top_n = 2L)
  expect_equal(length(hubs), 2L)
})

# ---------------------------------------------------------------------------
# louvain_cluster
# ---------------------------------------------------------------------------

test_that("louvain_cluster returns a named list of character vectors", {
  skip_if_not_installed("igraph")

  ppi <- make_fake_ppi()
  genes <- unique(c(ppi$gene1, ppi$gene2))
  g <- build_ppi_network(ppi, genes)

  clusters <- louvain_cluster(g)
  expect_type(clusters, "list")
  expect_true(length(clusters) >= 1L)
  expect_type(clusters[[1]], "character")

  # Sum of all members should equal total nodes
  expect_equal(sum(lengths(clusters)), igraph::vcount(g))
})

test_that("louvain_cluster covers all nodes exactly once", {
  skip_if_not_installed("igraph")

  ppi <- make_fake_ppi()
  genes <- unique(c(ppi$gene1, ppi$gene2))
  g <- build_ppi_network(ppi, genes)

  clusters <- louvain_cluster(g)
  all_members <- unlist(clusters, use.names = FALSE)
  expect_setequal(all_members, igraph::V(g)$name)
  expect_equal(length(all_members), length(unique(all_members)))
})

# ---------------------------------------------------------------------------
# enrichr_enrichment
# ---------------------------------------------------------------------------

test_that("enrichr_enrichment returns named list of tibbles", {
  call_seq <- 0L
  current_lib <- NULL

  local_mocked_bindings(
    req_perform = function(req, ...) {
      call_seq <<- call_seq + 1L
      resp <- structure(list(), class = "httr2_response")
      attr(resp, "call_seq") <- call_seq
      # Extract backgroundType from the request URL for enrichment calls
      if (call_seq > 1L && !is.null(req$url)) {
        m <- regmatches(req$url, regexpr("(?<=backgroundType=)[^&]+",
                                          req$url, perl = TRUE))
        if (length(m) > 0L) attr(resp, "lib") <- m
      }
      resp
    },
    resp_body_json = function(resp, ...) {
      cs <- attr(resp, "call_seq") %||% 1L
      if (cs == 1L) {
        # Submit response
        return(list(userListId = "fake_user_list_123"))
      }
      # Enrichment response — keyed by library name
      lib_name <- attr(resp, "lib") %||% "KEGG_2021_Human"
      entries <- list(list(
        1L,                                # rank
        "Pathways in cancer",              # term
        0.000123,                          # pvalue
        2.5,                               # zscore
        15.3,                              # combined_score
        c("TP53", "BRCA1", "EGFR"),        # overlapping_genes
        0.045                              # adjusted_pvalue
      ))
      setNames(list(entries), lib_name)
    },
    resp_status = function(resp) 200L,
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  result <- enrichr_enrichment(
    c("TP53", "BRCA1", "EGFR"),
    gene_set_libraries = c("KEGG_2021_Human"),
    top_n = 5L
  )

  expect_type(result, "list")
  expect_true("KEGG_2021_Human" %in% names(result))
  expect_s3_class(result[["KEGG_2021_Human"]], "tbl_df")

  df <- result[["KEGG_2021_Human"]]
  expect_true(all(c("Term", "Overlap", "P_value", "Adjusted_P",
                    "Z_Score", "Combined_Score", "Genes") %in% names(df)))
})

test_that("enrichr_enrichment uses default libraries when gene_set_libraries is NULL", {
  call_seq <- 0L

  local_mocked_bindings(
    req_perform = function(req, ...) {
      call_seq <<- call_seq + 1L
      resp <- structure(list(), class = "httr2_response")
      attr(resp, "call_seq") <- call_seq
      if (call_seq > 1L && !is.null(req$url)) {
        m <- regmatches(req$url, regexpr("(?<=backgroundType=)[^&]+",
                                          req$url, perl = TRUE))
        if (length(m) > 0L) attr(resp, "lib") <- m
      }
      resp
    },
    resp_body_json = function(resp, ...) {
      cs <- attr(resp, "call_seq") %||% 1L
      if (cs == 1L) {
        return(list(userListId = "fake_user_list_123"))
      }
      lib_name <- attr(resp, "lib") %||% "Unknown"
      entries <- list(list(
        1L, "Fake term", 0.01, 1.5, 5.0, c("GENE1"), 0.05
      ))
      setNames(list(entries), lib_name)
    },
    resp_status = function(resp) 200L,
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  result <- enrichr_enrichment(c("TP53"))
  expect_type(result, "list")
  # Default is 5 libraries
  expect_equal(length(result), 5L)
})

test_that("enrichr_enrichment handles submit failure", {
  local_mocked_bindings(
    req_perform = function(req, ...) stop("Network error"),
    .package = "httr2"
  )

  result <- enrichr_enrichment(c("TP53"))
  expect_equal(length(result), 0L)
})

test_that("enrichr_enrichment handles HTTP error on submit", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      structure(list(), class = "httr2_response")
    },
    resp_body_json = function(resp, ...) list(),
    resp_status = function(resp) 500L,
    .package = "httr2"
  )

  result <- enrichr_enrichment(c("TP53"))
  expect_equal(length(result), 0L)
})

test_that("enrichr_enrichment handles missing userListId", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      structure(list(), class = "httr2_response")
    },
    resp_body_json = function(resp, ...) list(),
    resp_status = function(resp) 200L,
    .package = "httr2"
  )

  result <- enrichr_enrichment(c("TP53"))
  expect_equal(length(result), 0L)
})

test_that("enrichr_enrichment handles empty library results", {
  call_seq <- 0L
  local_mocked_bindings(
    req_perform = function(req, ...) {
      call_seq <<- call_seq + 1L
      resp <- structure(list(), class = "httr2_response")
      attr(resp, "call_seq") <- call_seq
      if (call_seq > 1L && !is.null(req$url)) {
        m <- regmatches(req$url, regexpr("(?<=backgroundType=)[^&]+",
                                          req$url, perl = TRUE))
        if (length(m) > 0L) attr(resp, "lib") <- m
      }
      resp
    },
    resp_body_json = function(resp, ...) {
      cs <- attr(resp, "call_seq") %||% 1L
      if (cs == 1L) return(list(userListId = "fake_123"))
      # Return empty results for the library — keyed empty list
      lib_name <- attr(resp, "lib") %||% "KEGG_2021_Human"
      setNames(list(list()), lib_name)
    },
    resp_status = function(resp) 200L,
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  result <- enrichr_enrichment(
    c("TP53"),
    gene_set_libraries = c("KEGG_2021_Human")
  )
  expect_type(result, "list")
  expect_equal(length(result), 0L)
})

test_that("enrichr_enrichment handles library query error", {
  call_seq <- 0L
  local_mocked_bindings(
    req_perform = function(req, ...) {
      call_seq <<- call_seq + 1L
      if (call_seq > 1L) stop("Library query failed")
      resp <- structure(list(), class = "httr2_response")
      attr(resp, "call_seq") <- call_seq
      resp
    },
    resp_body_json = function(resp, ...) {
      list(userListId = "fake_123")
    },
    resp_status = function(resp) 200L,
    .package = "httr2"
  )
  local_mocked_bindings(
    `Sys.sleep` = function(time) invisible(),
    .package = "base"
  )

  result <- enrichr_enrichment(
    c("TP53"),
    gene_set_libraries = c("KEGG_2021_Human")
  )
  expect_type(result, "list")
  expect_equal(length(result), 0L)
})

# ---------------------------------------------------------------------------
# Integration-style tests (igraph pipeline without HTTP)
# ---------------------------------------------------------------------------

test_that("full PPI pipeline works with fake data (no HTTP)", {
  skip_if_not_installed("igraph")

  # Simulate what query_string_ppi would return
  ppi <- make_fake_ppi()
  genes <- unique(c(ppi$gene1, ppi$gene2))

  # Step 2: Build network
  g <- build_ppi_network(ppi, genes)
  expect_true(igraph::is_igraph(g))
  expect_gt(igraph::vcount(g), 0L)
  expect_gt(igraph::ecount(g), 0L)

  # Step 3: Hub genes
  hubs <- identify_hub_genes(g, top_n = 3L)
  expect_true(length(hubs) >= 1L)
  expect_true("TP53" %in% names(hubs))

  # Step 4: Communities
  clusters <- louvain_cluster(g)
  expect_true(length(clusters) >= 1L)
  expect_equal(sum(lengths(clusters)), igraph::vcount(g))
})
