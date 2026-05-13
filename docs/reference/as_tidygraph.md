# Convert a NetVis graph response to tidygraph

Convert a NetVis graph response to tidygraph

## Usage

``` r
as_tidygraph(graph_response)
```

## Arguments

- graph_response:

  A list with `$nodes` and `$edges` tibbles, as returned by
  [`get_neighbors()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_neighbors.md),
  [`get_subgraph()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_subgraph.md),
  or
  [`find_path()`](https://zx122ty.github.io/UniTCM_R_Package/reference/find_path.md).

## Value

A `tidygraph::tbl_graph` object.

## Examples

``` r
# \donttest{
resp <- get_neighbors("H:UNITCM_H001")
#> Error in httr2::req_perform(req): HTTP 500 Internal Server Error.
#> ℹ UniTCM server error. Please try again later.
tg <- as_tidygraph(resp)
#> Error in check_pkg("tidygraph", reason = "to convert to tbl_graph"): The package "tidygraph" is required to convert to tbl_graph
# }
```
