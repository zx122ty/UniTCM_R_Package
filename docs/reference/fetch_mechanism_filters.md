# Get mechanism filter options

Fetches all 6 filter option endpoints and returns them as a named list
of tibbles.

## Usage

``` r
fetch_mechanism_filters()
```

## Value

A named list with elements: `categories`, `omics_types`,
`evidence_levels`, `confidence_levels`, `study_types`, `species`. Each
is a [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html)
with columns `value`, `label`, `count`.

## Examples

``` r
# \donttest{
filters <- fetch_mechanism_filters()
filters$categories
#> # A tibble: 9 × 3
#>   value label                      count
#>   <chr> <chr>                      <int>
#> 1 方剂  方剂 (Formula)              4260
#> 2 证型  证型 (Syndrome Pattern)     4107
#> 3 治法  治法 (Treatment Principle)  2909
#> 4 中药  中药 (Herb/Materia Medica)  1712
#> 5 病机  病机 (Pathogenesis)          881
#> 6 其他  其他 (Other)                 700
#> 7 脏腑  脏腑 (Zang-Fu Organ)         312
#> 8 体质  体质 (Constitution)          173
#> 9 经络  经络 (Meridian)              141
# }
```
