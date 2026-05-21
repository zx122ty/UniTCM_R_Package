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

A
[`tidygraph::tbl_graph`](https://tidygraph.data-imaginist.com/reference/tbl_graph.html)
object.

## Examples

``` r
# \donttest{
resp <- get_neighbors("H:UNITCM_H001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
tg <- as_tidygraph(resp)
# }
```
