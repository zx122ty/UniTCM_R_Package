# Get subgraph for a set of nodes

Get subgraph for a set of nodes

## Usage

``` r
get_subgraph(node_ids, limit = 200L)
```

## Arguments

- node_ids:

  Character vector of node IDs (max 50).

- limit:

  Maximum edges (default 200).

## Value

A named list with `$nodes`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)),
`$edges`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)),
and `$has_more`.

## Examples

``` r
# \donttest{
get_subgraph(c("H:UNITCM_H001", "C:UNITCM_I00001"))
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $nodes
#> # A tibble: 2 × 6
#>   id    type     label                  label_cn       degree properties
#>   <chr> <chr>    <chr>                  <chr>           <int> <df[,0]>  
#> 1 H:1   herb     Delphinium stapeliosum 斯塔佩尔翠雀花      0           
#> 2 C:1   compound Abietic acid           NA                  0           
#> 
#> $edges
#> # A tibble: 0 × 0
#> 
#> $has_more
#> named list()
#> 
# }
```
