# Sweep network separation across top-N gene selection

For one or more gene sets, ranks genes by degree (or a user-supplied
ranking), then computes network separation from a reference set at each
value of N in a range. Also computes distance to reference core and
periphery when `core_percentile` is set.

## Usage

``` r
network_separation_sweep(
  graph,
  gene_sets,
  reference_genes,
  reference_name = "Reference",
  top_n_range = seq(10L, 100L, by = 10L),
  degree_map = NULL,
  core_percentile = 0.75,
  progress = TRUE
)
```

## Arguments

- graph:

  An `igraph` object (the interactome network).

- gene_sets:

  A named list of character vectors. Each element represents a group of
  genes (e.g. drug targets per herb category).

- reference_genes:

  Character vector of reference genes (e.g. disease genes).

- reference_name:

  Character label for the reference set (used in output). Default
  `"Reference"`.

- top_n_range:

  Numeric vector of N values to test (default `seq(10, 100, by = 10)`).
  The actual N is capped at the size of each gene set.

- degree_map:

  A named list of named numeric vectors providing the degree centrality
  for each gene set (e.g.
  `list(GroupA = c(TP53 = 45, BRCA1 = 30), GroupB = c(...))`). If `NULL`
  (the default), degree is computed from `graph` on the fly.

- core_percentile:

  Numeric in (0, 1). Reference genes with degree at or above this
  percentile are classified as "core"; the rest as "periphery". Set to
  `NULL` to skip core/periphery classification. Default `0.75`.

- progress:

  Show progress messages. Default `TRUE`.

## Value

A named list with components:

- sweep_df:

  A
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  with one row per (group, N) combination. Columns: `group`, `top_n`,
  `n_actual`, `n_total`, `d_AB`, `d_AA`, `d_BB`, `S_AB`, `d_to_core`,
  `d_to_periphery`, `d_ratio`, `hub_coverage`.

- optimal_n:

  A named list mapping group name → recommended N (from elbow
  detection).

- summary:

  A
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  with separation metrics at standard N values (20, 30, 50, 80).

- core_genes:

  Character vector of reference genes classified as core (or `NULL`).

- periphery_genes:

  Character vector of reference genes classified as periphery (or
  `NULL`).

- degree_maps:

  A named list of degree-centrality vectors used for ranking.

## Examples

``` r
if (FALSE) { # \dontrun{
# Build a combined interactome
g <- build_ppi_network(ppi_df, all_genes)

# Define gene sets and reference
gene_sets <- list(
  DrugA = c("TP53", "BRCA1", "MYC", "EGFR", "VEGFA"),
  DrugB = c("TNF", "IL6", "NFKB1", "JUN", "AKT1")
)
disease_genes <- c("TNF", "IL6", "STAT3", "MAPK3", "PTEN", ...)

# Run analysis
result <- network_separation_sweep(g, gene_sets, disease_genes)
result$optimal_n
head(result$sweep_df)

# Find optimal N for DrugA
result$optimal_n[["DrugA"]]
} # }
```
