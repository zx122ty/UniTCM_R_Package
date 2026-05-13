# List origin sources

Returns the top 50 formula origin sources by frequency.

## Usage

``` r
list_origin_sources()
```

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns `value`, `label`, `count`.

## Examples

``` r
# \donttest{
list_origin_sources()
#> # A tibble: 50 × 3
#>    value        label        count
#>    <chr>        <chr>        <int>
#>  1 Other        Other        35789
#>  2 《圣济总录》 《圣济总录》 30371
#>  3 《圣惠》     《圣惠》     27424
#>  4 《普济方》   《普济方》   14180
#>  5 《外台》     《外台》      4398
#>  6 《千金》     《千金》      4055
#>  7 《医方类聚》 《医方类聚》  3877
#>  8 《辨证录》   《辨证录》    3487
#>  9 《幼幼新书》 《幼幼新书》  3292
#> 10 《鸡峰》     《鸡峰》      3168
#> # ℹ 40 more rows
# }
```
