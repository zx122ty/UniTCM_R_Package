# Get node detail

Get node detail

## Usage

``` r
get_node_detail(node_id)
```

## Arguments

- node_id:

  Node ID.

## Value

A named list with fields: `id`, `type`, `label`, `label_cn`,
`properties`, `detail_url`.

## Examples

``` r
# \donttest{
get_node_detail("H:UNITCM_H001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 500 Internal Server Error.
#> ℹ UniTCM server error. Please try again later.
# }
```
