# Get neighbors of a node

Get neighbors of a node

## Usage

``` r
get_neighbors(node_id, depth = 1L, limit = 50L, node_types = NULL)
```

## Arguments

- node_id:

  Node ID (e.g. `"H:UNITCM_H001"`).

- depth:

  Neighbor depth (1–3, default 1).

- limit:

  Maximum neighbors (max 200, default 50).

- node_types:

  Comma-separated node types to include.

## Value

A named list with `$nodes`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)),
`$edges`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)),
and `$has_more`.

## Examples

``` r
# \donttest{
get_neighbors("H:UNITCM_H001", depth = 1)
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $nodes
#> # A tibble: 63 × 6
#>    id    type    label                  label_cn       degree properties
#>    <chr> <chr>   <chr>                  <chr>           <int> <df[,0]>  
#>  1 H:1   herb    Delphinium stapeliosum 斯塔佩尔翠雀花     62           
#>  2 F:1   formula 增效调经丸             NA                  1           
#>  3 F:2   formula 调经养血汤             NA                  1           
#>  4 F:3   formula 加味四物汤             NA                  1           
#>  5 F:4   formula 柴芍调经汤             NA                  1           
#>  6 F:5   formula 参芪调经汤             NA                  1           
#>  7 F:6   formula 益黄八珍散             NA                  1           
#>  8 F:7   formula 桑寄生汤               NA                  1           
#>  9 F:8   formula 七制香附丸             NA                  1           
#> 10 F:9   formula 自创育坤散             NA                  1           
#> # ℹ 53 more rows
#> 
#> $edges
#> # A tibble: 62 × 5
#>    source target type         weight properties$source
#>    <chr>  <chr>  <chr>        <lgl>  <chr>            
#>  1 F:1    H:1    formula_herb NA     NA               
#>  2 F:2    H:1    formula_herb NA     NA               
#>  3 F:3    H:1    formula_herb NA     NA               
#>  4 F:4    H:1    formula_herb NA     NA               
#>  5 F:5    H:1    formula_herb NA     NA               
#>  6 F:6    H:1    formula_herb NA     NA               
#>  7 F:7    H:1    formula_herb NA     NA               
#>  8 F:8    H:1    formula_herb NA     NA               
#>  9 F:9    H:1    formula_herb NA     NA               
#> 10 F:10   H:1    formula_herb NA     NA               
#> # ℹ 52 more rows
#> 
#> $has_more
#> $has_more$formula
#> [1] 1
#> 
#> 
# }
```
