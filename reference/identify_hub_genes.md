# Identify hub genes by degree centrality

Calculates degree centrality for all nodes in a PPI network and returns
the top-ranked hub genes.

## Usage

``` r
identify_hub_genes(graph, top_n = 10L)
```

## Arguments

- graph:

  An `igraph` object (from
  [`build_ppi_network()`](https://zx122ty.github.io/UniTCM_R_Package/reference/build_ppi_network.md)).

- top_n:

  Number of top hub genes to return. Default `10`.

## Value

A named numeric vector of degree centrality values for the top hub
genes, sorted in descending order.

## Examples

``` r
if (FALSE) { # \dontrun{
ppi <- query_string_ppi(c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF"))
g <- build_ppi_network(ppi, c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF"))
hubs <- identify_hub_genes(g, top_n = 5)
print(hubs)
} # }
```
