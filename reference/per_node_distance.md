# Compute per-node closest distance to another gene set

For each node in setA, finds the shortest-path distance to the nearest
node in setB. Useful for identifying which specific genes are close to
or far from a disease module.

## Usage

``` r
per_node_distance(graph, setA, setB)
```

## Arguments

- graph:

  An `igraph` object.

- setA:

  Character vector of gene symbols (query nodes).

- setB:

  Character vector of gene symbols (target set).

## Value

A named numeric vector where names are genes from `setA` and values are
the closest distance to any gene in `setB`. Genes not present in the
network are omitted. Returns an empty named numeric vector if no paths
exist.

## Examples

``` r
if (FALSE) { # \dontrun{
g <- build_ppi_network(ppi_df, all_genes)
per_node_distance(g, c("TP53", "BRCA1"), c("EGFR", "VEGFA"))
} # }
```
