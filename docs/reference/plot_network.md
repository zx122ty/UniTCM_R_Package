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

  An `igraph` or `tidygraph::tbl_graph` object.

- layout:

  Layout algorithm (default `"fr"` for Fruchterman-Reingold). See
  `ggraph::create_layout()` for options.

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
# \donttest{
g <- build_hct_network("UNITCM_H001")
#> Fetching compounds for "UNITCM_H001"...
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "herb_id"), msg =
#>   "Input should be a valid integer, unable to parse string as an integer")
plot_network(g)
#> Error in check_pkg("ggraph", reason = "to plot networks"): The package "ggraph" is required to plot networks
# }
```
