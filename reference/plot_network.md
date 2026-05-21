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
  [`tidygraph::tbl_graph`](https://tidygraph.data-imaginist.com/reference/tbl_graph.html)
  object.

- layout:

  Layout algorithm (default `"fr"` for Fruchterman-Reingold). See
  [`ggraph::create_layout()`](https://ggraph.data-imaginist.com/reference/ggraph.html)
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
# \donttest{
g <- build_hct_network("UNITCM_H001")
#> Fetching compounds for "UNITCM_H001"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-deacetyl-14-isobutyrylajadine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-deacetyl-14-isobutyrylnudicauline"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-deacetylajadine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-deacetylnudicauline"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-demethyltuguaconitine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Ajacine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Delbonine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Delcosine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Deltatsine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Methyllycaconitine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Nudicauline"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "ajadine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in igraph::graph_from_data_frame(edge_df, directed = FALSE, vertices = node_df): Some vertex names in `d` are not listed in `vertices`
plot_network(g)
#> Error: object 'g' not found
# }
```
