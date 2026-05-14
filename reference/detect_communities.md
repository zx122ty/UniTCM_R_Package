# Detect communities in a graph

POST a graph (nodes + edges) to the server for community detection.

## Usage

``` r
detect_communities(nodes, edges)
```

## Arguments

- nodes:

  Character vector of node IDs.

- edges:

  A data frame or list of edges, each with `source` and `target` fields.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns `node_id` and `community_id`.

## Examples

``` r
if (FALSE) { # \dontrun{
detect_communities(
  nodes = c("A", "B", "C"),
  edges = data.frame(source = c("A", "B"), target = c("B", "C"))
)
} # }
```
