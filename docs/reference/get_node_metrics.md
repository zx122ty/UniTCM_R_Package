# Get node metrics

Get node metrics

## Usage

``` r
get_node_metrics(node_id)
```

## Arguments

- node_id:

  Node ID.

## Value

A named list with fields: `node_id`, `degree`, `neighbor_types`.

## Examples

``` r
# \donttest{
get_node_metrics("H:UNITCM_H001")
#> Error in httr2::req_perform(req): HTTP 500 Internal Server Error.
#> ℹ UniTCM server error. Please try again later.
# }
```
