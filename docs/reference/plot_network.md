# Plot a network graph

Visualize an `igraph` or `tbl_graph` object using `ggraph`.

## Usage

``` r
plot_network(
  graph,
  layout = "fr",
  color_by = "type",
  node_size = 3,
  edge_alpha = 0.3,
  show_labels = NULL
)
```

## Arguments

- graph:

  An `igraph` or
  [`tidygraph::tbl_graph`](https://rdrr.io/pkg/tidygraph/man/tbl_graph.html)
  object.

- layout:

  Layout algorithm (default `"fr"` for Fruchterman-Reingold). See
  [`ggraph::create_layout()`](https://rdrr.io/pkg/ggraph/man/ggraph.html)
  for options.

- color_by:

  Vertex attribute name to map to node color (default `"type"`).

- node_size:

  Base node size (default 3).

- edge_alpha:

  Edge transparency (default 0.3).

- show_labels:

  Whether to label nodes (default `TRUE` for nodes with degree \>= 3, or
  all if graph has \<= 50 nodes).

## Value

A `ggplot` object.

## Examples

``` r
if (FALSE) { # \dontrun{
g <- build_hct_network("UNITCM_H001")
plot_network(g)
} # }
```
