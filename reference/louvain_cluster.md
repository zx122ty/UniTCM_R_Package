# Detect communities in a PPI network using the Louvain algorithm

Applies the Louvain community detection algorithm to partition the PPI
network into modules of densely connected genes.

## Usage

``` r
louvain_cluster(graph, resolution = 1)
```

## Arguments

- graph:

  An `igraph` object (from
  [`build_ppi_network()`](https://zx122ty.github.io/UniTCM_R_Package/reference/build_ppi_network.md)).

- resolution:

  Resolution parameter for the Louvain algorithm. Larger values produce
  more, smaller communities. Default `1.0`.

## Value

A named list where each element is a character vector of gene symbols
belonging to one community. Community IDs are used as names.

## Examples

``` r
if (FALSE) { # \dontrun{
ppi <- query_string_ppi(c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF",
                           "MYC", "AKT1", "IL6", "JUN", "MAPK3"))
g <- build_ppi_network(ppi, unique(c(ppi$gene1, ppi$gene2)))
clusters <- louvain_cluster(g)
lengths(clusters)
} # }
```
