# List dosage forms

Returns the top 50 dosage forms by frequency.

## Usage

``` r
list_dosage_forms()
```

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns `value`, `label`, `count`.

## Examples

``` r
# \donttest{
list_dosage_forms()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 50 × 3
#>    value                     label                     count
#>    <chr>                     <chr>                     <int>
#>  1 汤剂 (Decoction)          汤剂 (Decoction)          75088
#>  2 散剂 (Powder preparation) 散剂 (Powder preparation) 72456
#>  3 丸剂 (Pill)               丸剂 (Pill)               54798
#>  4 其他剂型 (Others)         其他剂型 (Others)         20318
#>  5 膏剂 (Paste preparation)  膏剂 (Paste preparation)  12292
#>  6 丹剂 (Pellet)             丹剂 (Pellet)              9188
#>  7 酒剂 (Medicated wine)     酒剂 (Medicated wine)      2963
#>  8 煎膏剂 (Electuary)        煎膏剂 (Electuary)         2639
#>  9 片剂 (Tablet)             片剂 (Tablet)              1431
#> 10 粥剂 (Medicated porridge) 粥剂 (Medicated porridge)  1078
#> # ℹ 40 more rows
# }
```
