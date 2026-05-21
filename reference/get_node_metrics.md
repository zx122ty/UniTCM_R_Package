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
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $node_id
#> [1] "H:1"
#> 
#> $degree
#> [1] 189544
#> 
#> $neighbor_types
#> $neighbor_types$formula
#> [1] 189532
#> 
#> $neighbor_types$compound
#> [1] 12
#> 
#> 
# }
```
