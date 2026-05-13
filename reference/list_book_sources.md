# List book sources

List book sources

## Usage

``` r
list_book_sources()
```

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns `value`, `label`, `count`.

## Examples

``` r
# \donttest{
list_book_sources()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 34 × 3
#>    value                  label                  count
#>    <chr>                  <chr>                  <int>
#>  1 Other                  Other                  81218
#>  2 ETCM2                  ETCM2                  48440
#>  3 中华租传秘方大全       中华租传秘方大全       12447
#>  4 中医方剂大辞典(第10册) 中医方剂大辞典(第10册) 12131
#>  5 中医方剂大辞典(第3册)  中医方剂大辞典(第3册)   9952
#>  6 中医方剂大辞典(第7册)  中医方剂大辞典(第7册)   9408
#>  7 中医方剂大辞典(第1册)  中医方剂大辞典(第1册)   8180
#>  8 中医方剂大辞典(第5册)  中医方剂大辞典(第5册)   8115
#>  9 中医方剂大辞典(第2册)  中医方剂大辞典(第2册)   7994
#> 10 肿瘤方剂大辞典         肿瘤方剂大辞典          7359
#> # ℹ 24 more rows
# }
```
