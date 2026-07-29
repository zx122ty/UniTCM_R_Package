# ============================================================================
# Network Separation Analysis
# ============================================================================
# Implements the network-based separation method (Menche et al., Science 2015)
# to quantify the relationship between drug target sets and disease modules
# within a protein-protein interaction (PPI) network.
#
# Core metric:
#   S_AB = d_AB - (d_AA + d_BB) / 2
#
#   S_AB < 0  →  the two modules are topologically overlapping / colocalized
#   S_AB >= 0 →  the two modules are topologically separated
#
# Enhanced features:
#   - Top-N sweep with elbow detection for optimal gene-set size
#   - Core vs. periphery distance analysis
#   - Multi-group comparison
# ============================================================================


# ============================================================================
# 1. Core distance metrics
# ============================================================================

#' Compute closest distance between two gene sets in a network
#'
#' For each node in set B, finds the shortest-path distance to the nearest
#' node in set A (and vice versa), then returns the mean across all nodes.
#' Only nodes present in the graph are considered.
#'
#' @param graph An `igraph` object (the interactome / PPI network).
#' @param setA Character vector of gene symbols (the first node set).
#' @param setB Character vector of gene symbols (the second node set).
#' @return A single numeric value — the mean closest distance between the
#'   two sets. Returns `NaN` if no valid paths exist.
#' @export
#' @examples
#' \dontrun{
#' g <- build_ppi_network(ppi_df, all_genes)
#' set_distance(g, c("TP53", "BRCA1"), c("EGFR", "VEGFA", "TNF"))
#' }
set_distance <- function(graph, setA, setB) {
  check_pkg("igraph", reason = "to compute network distances")

  A <- intersect(setA, igraph::V(graph)$name)
  B <- intersect(setB, igraph::V(graph)$name)

  if (length(A) == 0L || length(B) == 0L) {
    return(NaN)
  }

  # Compute distances from each node in the smaller set to all nodes in the
  # larger set, then take column-wise minima. This is more efficient than
  # computing the full all-pairs distance matrix.
  if (length(A) <= length(B)) {
    small <- A; big <- B
  } else {
    small <- B; big <- A
  }

  dm <- igraph::distances(graph, v = small, to = big, mode = "all")
  # dm is |small| × |big|; column minima give closest distance for each node
  # in `big` to any node in `small`.
  d_big <- apply(dm, 2L, min)
  d_big <- d_big[is.finite(d_big)]

  # Also compute the reverse direction: min distance from each node in
  # `small` to any node in `big` (this isn't symmetric when node counts differ)
  d_small <- apply(dm, 1L, min)
  d_small <- d_small[is.finite(d_small)]

  if (length(d_big) == 0L && length(d_small) == 0L) {
    return(NaN)
  }

  mean(c(d_big, d_small))
}


#' Compute mean internal distance of a gene set
#'
#' Calculates the mean shortest-path distance between all pairs of nodes
#' within the given gene set.
#'
#' @param graph An `igraph` object.
#' @param gene_set Character vector of gene symbols.
#' @return A single numeric value — the mean pairwise distance within the
#'   set. Returns `0` if the set has fewer than 2 nodes, and `NaN` if no
#'   valid paths exist.
#' @export
#' @examples
#' \dontrun{
#' g <- build_ppi_network(ppi_df, all_genes)
#' self_distance(g, c("TP53", "BRCA1", "EGFR"))
#' }
self_distance <- function(graph, gene_set) {
  check_pkg("igraph", reason = "to compute network distances")

  A <- intersect(gene_set, igraph::V(graph)$name)

  if (length(A) < 2L) {
    return(0.0)
  }

  dm <- igraph::distances(graph, v = A, to = A, mode = "all")
  # Extract strict upper-triangle (i < j) to avoid duplicates and zeros
  # on the diagonal
  vals <- dm[upper.tri(dm)]
  vals <- vals[is.finite(vals)]

  if (length(vals) == 0L) {
    return(NaN)
  }

  mean(vals)
}


#' Compute the network separation score S_AB
#'
#' Implements the network-based separation metric from Menche et al.
#' (Science 2015):
#'
#' \deqn{S_{AB} = d_{AB} - \frac{d_{AA} + d_{BB}}{2}}
#'
#' - \eqn{S_{AB} < 0}: the modules are topologically overlapping / colocalized.
#' - \eqn{S_{AB} \ge 0}: the modules are topologically separated.
#'
#' @param graph An `igraph` object.
#' @param setA Character vector of gene symbols (e.g. drug targets).
#' @param setB Character vector of gene symbols (e.g. disease genes).
#' @return A named numeric vector with elements:
#'   \describe{
#'     \item{d_AB}{Mean closest distance between set A and set B.}
#'     \item{d_AA}{Mean internal distance of set A.}
#'     \item{d_BB}{Mean internal distance of set B.}
#'     \item{S_AB}{Network separation score.}
#'   }
#' @export
#' @examples
#' \dontrun{
#' g <- build_ppi_network(ppi_df, all_genes)
#' network_separation(g,
#'   setA = c("TP53", "BRCA1", "MYC"),
#'   setB = c("TNF", "IL6", "NFKB1"))
#' }
network_separation <- function(graph, setA, setB) {
  d_ab <- set_distance(graph, setA, setB)
  d_aa <- self_distance(graph, setA)
  d_bb <- self_distance(graph, setB)

  if (is.na(d_ab) || is.nan(d_ab)) {
    s_ab <- NaN
  } else {
    s_ab <- d_ab - (d_aa + d_bb) / 2.0
  }

  c(d_AB = d_ab, d_AA = d_aa, d_BB = d_bb, S_AB = s_ab)
}


#' Compute per-node closest distance to another gene set
#'
#' For each node in setA, finds the shortest-path distance to the nearest
#' node in setB. Useful for identifying which specific genes are close to
#' or far from a disease module.
#'
#' @param graph An `igraph` object.
#' @param setA Character vector of gene symbols (query nodes).
#' @param setB Character vector of gene symbols (target set).
#' @return A named numeric vector where names are genes from `setA` and
#'   values are the closest distance to any gene in `setB`. Genes not
#'   present in the network are omitted. Returns an empty named numeric
#'   vector if no paths exist.
#' @export
#' @examples
#' \dontrun{
#' g <- build_ppi_network(ppi_df, all_genes)
#' per_node_distance(g, c("TP53", "BRCA1"), c("EGFR", "VEGFA"))
#' }
per_node_distance <- function(graph, setA, setB) {
  check_pkg("igraph", reason = "to compute network distances")

  A <- intersect(setA, igraph::V(graph)$name)
  B <- intersect(setB, igraph::V(graph)$name)

  if (length(A) == 0L || length(B) == 0L) {
    return(structure(numeric(0L), names = character(0L)))
  }

  dm <- igraph::distances(graph, v = A, to = B, mode = "all")
  # dm is |A| × |B|; row minima give closest distance from each gene in A
  d_min <- apply(dm, 1L, min)
  d_min <- d_min[is.finite(d_min)]

  if (length(d_min) == 0L) {
    return(structure(numeric(0L), names = character(0L)))
  }

  names(d_min) <- A[seq_along(d_min)]
  d_min
}


# ============================================================================
# 2. Elbow / knee detection
# ============================================================================

#' Find the elbow (knee) point in a curve
#'
#' Implements a simplified Kneedle algorithm to detect the point of maximum
#' curvature in a 2-D curve. Useful for choosing the optimal number of
#' top-ranked genes (top-N) in a separation-sweep: the elbow is where
#' adding more genes yields diminishing returns.
#'
#' @param x Numeric vector of x-values (e.g. N, the number of top genes).
#' @param y Numeric vector of y-values (e.g. S_AB scores).
#' @return An integer index into `x` and `y` where the elbow is detected.
#'   Returns `1L` if the inputs are too short (< 3 points).
#' @export
#' @examples
#' x <- seq(10, 100, by = 10)
#' y <- c(0.5, 0.3, 0.15, 0.08, 0.05, 0.03, 0.02, 0.018, 0.015, 0.014)
#' idx <- find_elbow(x, y)
#' x[idx]  # optimal N
find_elbow <- function(x, y) {
  n <- length(x)
  if (n < 3L) {
    return(1L)
  }

  # Normalize to [0, 1]
  x_range <- max(x) - min(x)
  y_range <- max(y) - min(y)

  if (x_range > 0) {
    x_norm <- (x - min(x)) / x_range
  } else {
    x_norm <- rep(0, n)
  }
  if (y_range > 0) {
    y_norm <- (y - min(y)) / y_range
  } else {
    y_norm <- rep(0, n)
  }

  # Difference from the diagonal line (0,0) → (1,1)
  differences <- y_norm - x_norm
  # Elbow = point of maximum absolute difference from the diagonal
  which.max(abs(differences))
}


#' Find the saturation point in a curve
#'
#' Detects where adding more genes yields less than a threshold improvement
#' in the metric of interest (e.g. S_AB). Uses a smoothed first difference.
#'
#' @param x Numeric vector of x-values (e.g. N).
#' @param y Numeric vector of y-values (e.g. S_AB).
#' @param threshold Minimum absolute change required to continue adding
#'   genes. Default `0.01`.
#' @return An integer index into `x` where saturation is reached.
#' @export
#' @examples
#' x <- seq(10, 100, by = 10)
#' y <- c(0.5, 0.3, 0.15, 0.08, 0.051, 0.049, 0.048, 0.047, 0.046, 0.046)
#' idx <- find_saturation_point(x, y, threshold = 0.01)
#' x[idx]
find_saturation_point <- function(x, y, threshold = 0.01) {
  n <- length(y)
  if (n < 3L) {
    return(1L)
  }

  dy <- abs(diff(y))

  # 3-point moving average for smoothing
  if (length(dy) >= 4L) {
    dy_smooth <- stats::filter(dy, rep(1/3, 3), sides = 1)
    dy_smooth <- as.numeric(dy_smooth)
    dy_smooth <- dy_smooth[!is.na(dy_smooth)]
  } else {
    dy_smooth <- dy
  }

  # First index where improvement drops below threshold
  for (i in seq_along(dy_smooth)) {
    if (dy_smooth[i] < threshold) {
      return(min(i + 1L, n))
    }
  }
  n
}


# ============================================================================
# 3. Sweep and analysis
# ============================================================================

#' Sweep network separation across top-N gene selection
#'
#' For one or more gene sets, ranks genes by degree (or a user-supplied
#' ranking), then computes network separation from a reference set at
#' each value of N in a range. Also computes distance to reference core
#' and periphery when `core_percentile` is set.
#'
#' @param graph An `igraph` object (the interactome network).
#' @param gene_sets A named list of character vectors. Each element
#'   represents a group of genes (e.g. drug targets per herb category).
#' @param reference_genes Character vector of reference genes (e.g. disease
#'   genes).
#' @param reference_name Character label for the reference set (used in
#'   output). Default `"Reference"`.
#' @param top_n_range Numeric vector of N values to test (default
#'   `seq(10, 100, by = 10)`). The actual N is capped at the size of each
#'   gene set.
#' @param degree_map A named list of named numeric vectors providing the
#'   degree centrality for each gene set (e.g.
#'   `list(GroupA = c(TP53 = 45, BRCA1 = 30), GroupB = c(...))`).
#'   If `NULL` (the default), degree is computed from `graph` on the fly.
#' @param core_percentile Numeric in (0, 1). Reference genes with degree
#'   at or above this percentile are classified as "core"; the rest as
#'   "periphery". Set to `NULL` to skip core/periphery classification.
#'   Default `0.75`.
#' @param progress Show progress messages. Default `TRUE`.
#' @return A named list with components:
#'   \describe{
#'     \item{sweep_df}{A [tibble::tibble()] with one row per (group, N)
#'       combination. Columns: `group`, `top_n`, `n_actual`, `n_total`,
#'       `d_AB`, `d_AA`, `d_BB`, `S_AB`,
#'       `d_to_core`, `d_to_periphery`, `d_ratio`, `hub_coverage`.}
#'     \item{optimal_n}{A named list mapping group name → recommended N
#'       (from elbow detection).}
#'     \item{summary}{A [tibble::tibble()] with separation metrics at
#'       standard N values (20, 30, 50, 80).}
#'     \item{core_genes}{Character vector of reference genes classified
#'       as core (or `NULL`).}
#'     \item{periphery_genes}{Character vector of reference genes
#'       classified as periphery (or `NULL`).}
#'     \item{degree_maps}{A named list of degree-centrality vectors used
#'       for ranking.}
#'   }
#' @export
#' @examples
#' \dontrun{
#' # Build a combined interactome
#' g <- build_ppi_network(ppi_df, all_genes)
#'
#' # Define gene sets and reference
#' gene_sets <- list(
#'   DrugA = c("TP53", "BRCA1", "MYC", "EGFR", "VEGFA"),
#'   DrugB = c("TNF", "IL6", "NFKB1", "JUN", "AKT1")
#' )
#' disease_genes <- c("TNF", "IL6", "STAT3", "MAPK3", "PTEN", ...)
#'
#' # Run analysis
#' result <- network_separation_sweep(g, gene_sets, disease_genes)
#' result$optimal_n
#' head(result$sweep_df)
#'
#' # Find optimal N for DrugA
#' result$optimal_n[["DrugA"]]
#' }
network_separation_sweep <- function(graph,
                                      gene_sets,
                                      reference_genes,
                                      reference_name = "Reference",
                                      top_n_range = seq(10L, 100L, by = 10L),
                                      degree_map = NULL,
                                      core_percentile = 0.75,
                                      progress = TRUE) {
  check_pkg("igraph", reason = "to compute network separation")

  # --- Validate inputs ---
  if (!is.list(gene_sets) || is.null(names(gene_sets))) {
    rlang::abort("`gene_sets` must be a named list of character vectors.")
  }

  ref_in_graph <- intersect(reference_genes, igraph::V(graph)$name)
  if (length(ref_in_graph) == 0L) {
    rlang::abort("None of `reference_genes` are present in the graph.")
  }
  if (progress) {
    cli::cli_inform("[Separation] Reference: {length(ref_in_graph)}/{length(reference_genes)} genes in network.")
  }

  # --- Build / validate degree maps ---
  if (is.null(degree_map)) {
    degree_map <- list()
    for (gname in names(gene_sets)) {
      genes_in_g <- intersect(gene_sets[[gname]], igraph::V(graph)$name)
      if (length(genes_in_g) > 0L) {
        deg <- igraph::degree(graph, v = genes_in_g)
        degree_map[[gname]] <- deg
      } else {
        degree_map[[gname]] <- structure(integer(0L), names = character(0L))
      }
    }
  }

  # --- Core / periphery classification ---
  core_genes <- NULL
  periphery_genes <- NULL

  if (!is.null(core_percentile) && length(ref_in_graph) >= 4L) {
    ref_degrees <- igraph::degree(graph, v = ref_in_graph)
    deg_threshold <- stats::quantile(ref_degrees, probs = core_percentile,
                                     names = FALSE)
    core_genes <- names(ref_degrees)[ref_degrees >= deg_threshold]
    periphery_genes <- names(ref_degrees)[ref_degrees < deg_threshold]

    if (progress) {
      cli::cli_inform("[Separation] Core (top {100*(1 - core_percentile):.0f}% degree): {length(core_genes)} genes.")
      cli::cli_inform("[Separation] Periphery (bottom {100*core_percentile:.0f}%): {length(periphery_genes)} genes.")
    }
  }

  # --- Sweep ---
  rows <- list()
  group_names <- names(gene_sets)

  for (gname in group_names) {
    genes_all <- intersect(gene_sets[[gname]], igraph::V(graph)$name)
    deg_map <- degree_map[[gname]]
    max_n <- length(genes_all)

    if (max_n == 0L) {
      if (progress) cli::cli_inform("[Separation] {.val {gname}}: 0 genes in network, skipping.")
      next
    }

    # Rank by degree (descending)
    if (length(deg_map) > 0L && all(genes_all %in% names(deg_map))) {
      genes_sorted <- names(sort(deg_map[genes_all], decreasing = TRUE))
    } else {
      deg_fallback <- igraph::degree(graph, v = genes_all)
      genes_sorted <- names(sort(deg_fallback, decreasing = TRUE))
    }

    if (progress) {
      cli::cli_inform("[Separation] {.val {gname}}: {max_n} genes, sweeping {min(top_n_range)}–{min(max(top_n_range), max_n)}...")
    }

    for (n_val in top_n_range) {
      if (n_val > max_n) break

      top_genes <- utils::head(genes_sorted, n_val)
      top_in_graph <- intersect(top_genes, igraph::V(graph)$name)

      if (length(top_in_graph) < 3L) next

      # Overall separation
      sep <- network_separation(graph, top_in_graph, ref_in_graph)

      row_entry <- list(
        group         = gname,
        reference     = reference_name,
        top_n         = n_val,
        n_actual      = length(top_in_graph),
        n_total       = max_n,
        d_AB          = as.numeric(sep["d_AB"]),
        d_AA          = as.numeric(sep["d_AA"]),
        d_BB          = as.numeric(sep["d_BB"]),
        S_AB          = as.numeric(sep["S_AB"])
      )

      # Core / periphery distances
      if (!is.null(core_genes) && !is.null(periphery_genes)) {
        d_core <- set_distance(graph, top_in_graph, core_genes)
        d_peri <- set_distance(graph, top_in_graph, periphery_genes)

        row_entry$d_to_core       <- as.numeric(d_core)
        row_entry$d_to_periphery  <- as.numeric(d_peri)
        row_entry$d_ratio         <- if (is.finite(d_peri) && d_peri > 0) {
          as.numeric(d_core) / as.numeric(d_peri)
        } else {
          NA_real_
        }

        # Hub coverage: fraction of core genes that have at least one
        # edge to the gene set
        core_set <- intersect(core_genes, igraph::V(graph)$name)
        herb_set <- setdiff(unique(top_in_graph), core_set)
        if (length(core_set) > 0L && length(herb_set) > 0L) {
          covered <- 0L
          for (h in core_set) {
            neighbors <- igraph::neighbors(graph, h)$name
            if (length(base::intersect(neighbors, herb_set)) > 0L) {
              covered <- covered + 1L
            }
          }
          row_entry$hub_coverage <- covered / length(core_set)
        } else {
          row_entry$hub_coverage <- NA_real_
        }
      }

      rows[[length(rows) + 1L]] <- row_entry
    }
  }

  # --- Build sweep data frame ---
  if (length(rows) == 0L) {
    rlang::abort("No sweep results generated. Check that your gene sets overlap with the graph.")
  }

  sweep_df <- do.call(rbind, lapply(rows, as.data.frame, stringsAsFactors = FALSE))
  sweep_df <- tibble::as_tibble(sweep_df)

  # --- Optimal N via elbow detection ---
  optimal_n <- list()
  for (gname in group_names) {
    hdf <- sweep_df[sweep_df$group == gname & !is.na(sweep_df$S_AB) &
                    is.finite(sweep_df$S_AB), ]
    if (nrow(hdf) >= 3L) {
      x <- hdf$top_n
      y <- hdf$S_AB
      elbow_idx <- find_elbow(x, y)
      optimal_n[[gname]] <- as.integer(x[elbow_idx])
    } else {
      optimal_n[[gname]] <- NA_integer_
    }
  }

  if (progress) {
    for (gname in names(optimal_n)) {
      n_opt <- optimal_n[[gname]]
      if (!is.na(n_opt)) {
        cli::cli_inform("[Separation] {.val {gname}}: optimal N={n_opt} (elbow method).")
      }
    }
  }

  # --- Summary at standard N values ---
  summary_rows <- list()
  default_ns <- c(20L, 30L, 50L, 80L)
  for (fixed_n in default_ns) {
    for (gname in group_names) {
      hdf <- sweep_df[sweep_df$group == gname & !is.na(sweep_df$S_AB) &
                      is.finite(sweep_df$S_AB), ]
      if (nrow(hdf) == 0L) next

      # Find closest row
      idx <- which.min(abs(hdf$top_n - fixed_n))
      row <- hdf[idx, ]
      row$fixed_N <- fixed_n
      summary_rows[[length(summary_rows) + 1L]] <- row
    }
  }

  summary_df <- NULL
  if (length(summary_rows) > 0L) {
    summary_df <- do.call(rbind, lapply(summary_rows, as.data.frame,
                                        stringsAsFactors = FALSE))
    summary_df <- tibble::as_tibble(summary_df)
  }

  list(
    sweep_df        = sweep_df,
    optimal_n       = optimal_n,
    summary         = summary_df,
    core_genes      = core_genes,
    periphery_genes = periphery_genes,
    degree_maps     = degree_map
  )
}


# ============================================================================
# 4. All-in-one convenience function
# ============================================================================

#' Network separation analysis
#'
#' Performs a complete network-based separation analysis between one or more
#' gene sets (e.g. drug / herb targets) and a reference gene set (e.g.
#' disease genes) within a PPI network.
#'
#' The core metric is the network separation score \eqn{S_{AB}} (Menche et
#' al., Science 2015):
#'
#' \deqn{S_{AB} = d_{AB} - \frac{d_{AA} + d_{BB}}{2}}
#'
#' - \eqn{S_{AB} < 0}: the two modules overlap topologically
#'   (drug targets are "close" to the disease module).
#' - \eqn{S_{AB} \ge 0}: the two modules are separated
#'   (drug targets are topologically distant from the disease module).
#'
#' The function sweeps across a range of top-N values (ranking genes by
#' degree centrality), detects the optimal N via elbow analysis, classifies
#' the reference set into core and periphery (high- vs low-degree nodes),
#' and returns structured results for downstream visualization.
#'
#' @param graph An `igraph` object representing the PPI / interactome
#'   network. Typically the output of [build_ppi_network()] or a combined
#'   network built from multiple sources.
#' @param gene_sets A named list of character vectors. Each element is a
#'   set of gene symbols (e.g., targets associated with a drug or herb
#'   category). Example:
#'   `list(DrugA = c("TP53", "BRCA1"), DrugB = c("EGFR", "VEGFA"))`.
#' @param reference_genes Character vector of gene symbols representing
#'   the disease module or other reference gene set.
#' @param reference_name Character label for the reference set (used in
#'   output column). Default `"Reference"`.
#' @param top_n_range Numeric vector of N values over which to sweep.
#'   Default `seq(10, 100, by = 10)`.
#' @param degree_map Optional named list of degree centrality vectors, one
#'   per gene-set name, used to rank genes when selecting top-N. If `NULL`
#'   (default), degree is computed from `graph`.
#' @param core_percentile Numeric in (0, 1) for the core/periphery split
#'   of the reference genes. Set to `NULL` to skip this classification.
#'   Default `0.75` (top 25% by degree = core).
#' @param progress Show progress messages. Default `TRUE`.
#' @return A named list with components:
#'   \describe{
#'     \item{sweep_df}{A [tibble::tibble()] with full sweep results:
#'       `group`, `top_n`, `n_actual`, `S_AB`, `d_AB`, `d_AA`, `d_BB`,
#'       `d_to_core`, `d_to_periphery`, `d_ratio`, `hub_coverage`.}
#'     \item{optimal_n}{Named integer vector mapping group → optimal N
#'       (from elbow detection).}
#'     \item{summary}{A [tibble::tibble()] with separation metrics at
#'       fixed N values (20, 30, 50, 80).}
#'     \item{core_genes}{Character vector of reference genes classified
#'       as core (or `NULL`).}
#'     \item{periphery_genes}{Character vector of reference genes
#'       classified as periphery (or `NULL`).}
#'     \item{per_node}{A named list of named numeric vectors with
#'       per-gene distances from each gene set to the reference set.}
#'   }
#' @references
#' Menche, J., et al. (2015). Uncovering disease-disease relationships
#' through the incomplete interactome. *Science*, 347(6224), 1257601.
#' @export
#' @examples
#' \dontrun{
#' # 1. Query STRING and build the network
#' all_genes <- c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF", "IL6",
#'                "MYC", "AKT1", "JUN", "MAPK3", "STAT3", "NFKB1",
#'                "PTEN", "HIF1A", "CCND1", "BCL2", "CASP3")
#' ppi <- query_string_ppi(all_genes)
#' g <- build_ppi_network(ppi, all_genes)
#'
#' # 2. Define drug targets and disease genes
#' drug_targets <- list(
#'   DrugA = c("TP53", "BRCA1", "MYC", "EGFR"),
#'   DrugB = c("TNF", "IL6", "NFKB1", "AKT1")
#' )
#' disease_genes <- c("TNF", "IL6", "STAT3", "MAPK3", "PTEN",
#'                    "CASP3", "HIF1A", "BCL2", "CCND1", "JUN")
#'
#' # 3. Run the analysis
#' result <- network_separation_analysis(
#'   graph = g,
#'   gene_sets = drug_targets,
#'   reference_genes = disease_genes,
#'   reference_name = "Disease"
#' )
#'
#' # 4. Inspect results
#' result$optimal_n         # recommended N per drug
#' result$summary           # metrics at standard N values
#' head(result$sweep_df)    # full sweep data
#' result$per_node[["DrugA"]]  # per-gene distances for Drug A
#' }
network_separation_analysis <- function(graph,
                                        gene_sets,
                                        reference_genes,
                                        reference_name = "Reference",
                                        top_n_range = seq(10L, 100L, by = 10L),
                                        degree_map = NULL,
                                        core_percentile = 0.75,
                                        progress = TRUE) {
  # Run the sweep
  result <- network_separation_sweep(
    graph          = graph,
    gene_sets      = gene_sets,
    reference_genes = reference_genes,
    reference_name = reference_name,
    top_n_range    = top_n_range,
    degree_map     = degree_map,
    core_percentile = core_percentile,
    progress       = progress
  )

  # Add per-node distances (at optimal N or fallback)
  per_node <- list()
  for (gname in names(gene_sets)) {
    genes_all <- intersect(gene_sets[[gname]], igraph::V(graph)$name)
    if (length(genes_all) == 0L) next

    deg <- degree_map[[gname]]
    if (is.null(deg) || !all(genes_all %in% names(deg))) {
      deg <- igraph::degree(graph, v = genes_all)
    }
    genes_sorted <- names(sort(deg, decreasing = TRUE))

    # Use optimal N if available, otherwise min(50, total)
    opt_n <- result$optimal_n[[gname]]
    if (is.na(opt_n) || is.null(opt_n)) {
      opt_n <- min(50L, length(genes_sorted))
    }
    opt_n <- min(opt_n, length(genes_sorted))

    top_genes <- utils::head(genes_sorted, opt_n)
    ref_in_graph <- intersect(reference_genes, igraph::V(graph)$name)

    pn <- per_node_distance(graph, top_genes, ref_in_graph)
    if (length(pn) > 0L) {
      per_node[[gname]] <- pn
    }
  }

  result$per_node <- per_node
  result
}
