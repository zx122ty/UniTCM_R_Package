# Build a PPI network as an igraph object

Creates an
[`igraph::graph()`](https://r.igraph.org/reference/graph.html) from
STRING PPI edges. All genes in the input list are included as nodes
(even those without interactions, as singletons). Edge weights are set
to the STRING combined score divided by 1000 (i.e. in \[0, 1\]).

## Usage

``` r
build_ppi_network(ppi_df, gene_list)
```

## Arguments

- ppi_df:

  A data frame from
  [`query_string_ppi()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_string_ppi.md)
  with columns `gene1`, `gene2`, `score`.

- gene_list:

  Character vector of all gene symbols (used to ensure isolated nodes
  are included).

## Value

An undirected `igraph` object with edge attribute `weight`.

## Examples

``` r
if (FALSE) { # \dontrun{
ppi <- query_string_ppi(c("TP53", "BRCA1", "EGFR"))
g <- build_ppi_network(ppi, c("TP53", "BRCA1", "EGFR"))
igraph::vcount(g)
igraph::ecount(g)
} # }
```
