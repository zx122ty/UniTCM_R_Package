# Get compound facets and statistics

Returns summary statistics and filter option counts for the Ingredient
Explorer.

## Usage

``` r
fetch_compound_facets()
```

## Value

A named list with fields: `total`, `approved_count`, `lipinski_counts`,
`drug_counts`, `mw_range`, `clogp_range`, `tpsa_range`, `qed_range`.

## Examples

``` r
# \donttest{
fetch_compound_facets()
#> $total
#> [1] 87040
#> 
#> $approved_count
#> [1] 0
#> 
#> $lipinski_counts
#>   value count
#> 1     0 25158
#> 2     1  6487
#> 3     2  3433
#> 4     3  4175
#> 5     4    83
#> 6    NA 47704
#> 
#> $drug_counts
#>   is_drug count
#> 1   FALSE 87040
#> 
#> $mw_range
#> $mw_range$min
#> [1] 0
#> 
#> $mw_range$max
#> [1] 7080.008
#> 
#> 
#> $clogp_range
#> $clogp_range$min
#> [1] -43.2478
#> 
#> $clogp_range$max
#> [1] 31.6415
#> 
#> 
#> $tpsa_range
#> $tpsa_range$min
#> [1] 0
#> 
#> $tpsa_range$max
#> [1] 2848.26
#> 
#> 
#> $qed_range
#> $qed_range$min
#> [1] 0.0063
#> 
#> $qed_range$max
#> [1] 0.9439
#> 
#> 
# }
```
