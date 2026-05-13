# Get herb filter facets

Returns available filter values and their counts for the Herb Explorer.

## Usage

``` r
fetch_herb_facets()
```

## Value

A named list of tibbles, one per facet field (e.g.
`therapeutic_en_class`, `family`, `toxicity`).

## Examples

``` r
# \donttest{
facets <- fetch_herb_facets()
facets$toxicity
#> # A tibble: 3 × 2
#>   value           count
#>   <chr>           <int>
#> 1 Toxic              47
#> 2 Extremely Toxic    32
#> 3 Slightly Toxic     12
# }
```
