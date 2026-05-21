# Build a Formula-Herb network

Given a formula order ID, fetches its herb doses and constructs a
star-topology network.

## Usage

``` r
build_formula_herb_network(formula_id)
```

## Arguments

- formula_id:

  The formula order ID (integer or character).

## Value

An `igraph` graph object with vertex attributes `name`, `type`
(`"formula"`, `"herb"`), `label`, and `dose` (for herbs).

## Examples

``` r
# \donttest{
g <- build_formula_herb_network(1)
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
igraph::V(g)$label
#>  [1] "增效调经丸" "地黄"       "当归"       "党参"       "炒白术"    
#>  [6] "陈皮"       "菟丝子"     "川续断"     "制香附"     "月季花"    
# }
```
