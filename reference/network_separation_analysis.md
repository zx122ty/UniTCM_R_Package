# Network separation analysis

Performs a complete network-based separation analysis between one or
more gene sets (e.g. drug / herb targets) and a reference gene set (e.g.
disease genes) within a PPI network.

## Usage

``` r
network_separation_analysis(
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

  An `igraph` object representing the PPI / interactome network.
  Typically the output of
  [`build_ppi_network()`](https://zx122ty.github.io/UniTCM_R_Package/reference/build_ppi_network.md)
  or a combined network built from multiple sources.

- gene_sets:

  A named list of character vectors. Each element is a set of gene
  symbols (e.g., targets associated with a drug or herb category).
  Example:
  `list(DrugA = c("TP53", "BRCA1"), DrugB = c("EGFR", "VEGFA"))`.

- reference_genes:

  Character vector of gene symbols representing the disease module or
  other reference gene set.

- reference_name:

  Character label for the reference set (used in output column). Default
  `"Reference"`.

- top_n_range:

  Numeric vector of N values over which to sweep. Default
  `seq(10, 100, by = 10)`.

- degree_map:

  Optional named list of degree centrality vectors, one per gene-set
  name, used to rank genes when selecting top-N. If `NULL` (default),
  degree is computed from `graph`.

- core_percentile:

  Numeric in (0, 1) for the core/periphery split of the reference genes.
  Set to `NULL` to skip this classification. Default `0.75` (top 25% by
  degree = core).

- progress:

  Show progress messages. Default `TRUE`.

## Value

A named list with components:

- sweep_df:

  A
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  with full sweep results: `group`, `top_n`, `n_actual`, `S_AB`, `d_AB`,
  `d_AA`, `d_BB`, `d_to_core`, `d_to_periphery`, `d_ratio`,
  `hub_coverage`.

- optimal_n:

  Named integer vector mapping group → optimal N (from elbow detection).

- summary:

  A
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
  with separation metrics at fixed N values (20, 30, 50, 80).

- core_genes:

  Character vector of reference genes classified as core (or `NULL`).

- periphery_genes:

  Character vector of reference genes classified as periphery (or
  `NULL`).

- per_node:

  A named list of named numeric vectors with per-gene distances from
  each gene set to the reference set.

## Details

The core metric is the network separation score \\S\_{AB}\\ (Menche et
al., Science 2015):

\$\$S\_{AB} = d\_{AB} - \frac{d\_{AA} + d\_{BB}}{2}\$\$

- \\S\_{AB} \< 0\\: the two modules overlap topologically (drug targets
  are "close" to the disease module).

- \\S\_{AB} \ge 0\\: the two modules are separated (drug targets are
  topologically distant from the disease module).

The function sweeps across a range of top-N values (ranking genes by
degree centrality), detects the optimal N via elbow analysis, classifies
the reference set into core and periphery (high- vs low-degree nodes),
and returns structured results for downstream visualization.

## References

Menche, J., et al. (2015). Uncovering disease-disease relationships
through the incomplete interactome. *Science*, 347(6224), 1257601.

## Examples

``` r
if (FALSE) { # \dontrun{
# 1. Query STRING and build the network
all_genes <- c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF", "IL6",
               "MYC", "AKT1", "JUN", "MAPK3", "STAT3", "NFKB1",
               "PTEN", "HIF1A", "CCND1", "BCL2", "CASP3")
ppi <- query_string_ppi(all_genes)
g <- build_ppi_network(ppi, all_genes)

# 2. Define drug targets and disease genes
drug_targets <- list(
  DrugA = c("TP53", "BRCA1", "MYC", "EGFR"),
  DrugB = c("TNF", "IL6", "NFKB1", "AKT1")
)
disease_genes <- c("TNF", "IL6", "STAT3", "MAPK3", "PTEN",
                   "CASP3", "HIF1A", "BCL2", "CCND1", "JUN")

# 3. Run the analysis
result <- network_separation_analysis(
  graph = g,
  gene_sets = drug_targets,
  reference_genes = disease_genes,
  reference_name = "Disease"
)

# 4. Inspect results
result$optimal_n         # recommended N per drug
result$summary           # metrics at standard N values
head(result$sweep_df)    # full sweep data
result$per_node[["DrugA"]]  # per-gene distances for Drug A
} # }
```
