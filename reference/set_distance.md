# Compute closest distance between two gene sets in a network

For each node in set B, finds the shortest-path distance to the nearest
node in set A (and vice versa), then returns the mean across all nodes.
Only nodes present in the graph are considered.

## Usage

``` r
set_distance(graph, setA, setB)
```

## Arguments

- graph:

  An `igraph` object (the interactome / PPI network).

- setA:

  Character vector of gene symbols (the first node set).

- setB:

  Character vector of gene symbols (the second node set).

## Value

A single numeric value — the mean closest distance between the two sets.
Returns `NaN` if no valid paths exist.

## Examples

``` r
if (FALSE) { # \dontrun{
g <- build_ppi_network(ppi_df, all_genes)
set_distance(g, c("TP53", "BRCA1"), c("EGFR", "VEGFA", "TNF"))
} # }
```
