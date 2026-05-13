# Get TCM classification statistics

Get TCM classification statistics

## Usage

``` r
fetch_tcm_classification_stats()
```

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns: `classification`, `count`, `percentage`.

## Examples

``` r
# \donttest{
fetch_tcm_classification_stats()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 11 × 3
#>    classification                  count percentage
#>    <chr>                           <int>      <dbl>
#>  1 Tcm Active Ingredient             893       49  
#>  2 Herb/Herbal Medicine              383       21  
#>  3 Modern Formula                    140        7.7
#>  4 Classic Formula                   111        6.1
#>  5 Chinese Patent Medicine           102        5.6
#>  6 Acupuncture & Moxibustion          87        4.8
#>  7 Other                              63        3.5
#>  8 Tcm Theory & Methodology           17        0.9
#>  9 Tcm Diagnostics                    10        0.5
#> 10 Chinese Herbal Pieces              10        0.5
#> 11 Integrated Tcm-Western Medicine     5        0.3
# }
```
