# Get NetVis network statistics

Get NetVis network statistics

## Usage

``` r
fetch_netvis_stats()
```

## Value

A named list with node counts (`formula`, `herb`, `compound`, `target`,
`disease`) and `edges` sub-list.

## Examples

``` r
# \donttest{
fetch_netvis_stats()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $formula
#> [1] 259484
#> 
#> $herb
#> [1] 28728
#> 
#> $compound
#> [1] 87040
#> 
#> $target
#> [1] 38172
#> 
#> $disease
#> [1] 54010
#> 
#> $edges
#> $edges$formula_herb
#> [1] 1528442
#> 
#> $edges$formula_disease
#> [1] 259484
#> 
#> $edges$herb_compound
#> [1] 400385
#> 
#> $edges$compound_target_drugclip
#> [1] 3077600
#> 
#> $edges$compound_target_chembl
#> [1] 767744
#> 
#> $edges$target_disease
#> [1] 5718197
#> 
#> 
# }
```
