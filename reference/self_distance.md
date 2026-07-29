# Compute mean internal distance of a gene set

Calculates the mean shortest-path distance between all pairs of nodes
within the given gene set.

## Usage

``` r
self_distance(graph, gene_set)
```

## Arguments

- graph:

  An `igraph` object.

- gene_set:

  Character vector of gene symbols.

## Value

A single numeric value — the mean pairwise distance within the set.
Returns `0` if the set has fewer than 2 nodes, and `NaN` if no valid
paths exist.

## Examples

``` r
if (FALSE) { # \dontrun{
g <- build_ppi_network(ppi_df, all_genes)
self_distance(g, c("TP53", "BRCA1", "EGFR"))
} # }
```
