# List term categories

List term categories

## Usage

``` r
list_term_categories()
```

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns `value`, `label`, `count`.

## Examples

``` r
# \donttest{
list_term_categories()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 45 × 3
#>    value                                           label                   count
#>    <chr>                                           <chr>                   <int>
#>  1 Therapeutic Principles and Methods              Therapeutic Principles…   770
#>  2 Chinese Materia Medica                          Chinese Materia Medica    674
#>  3 Formula                                         Formula                   631
#>  4 Diagnostic Method                               Diagnostic Method         529
#>  5 Acupuncture and Moxibustion                     Acupuncture and Moxibu…   524
#>  6 Mechanism of Disease                            Mechanism of Disease      522
#>  7 Syndrome Differentiation/Pattern Identification Syndrome Differentiati…   436
#>  8 Heat-Clearing Herbs                             Heat-Clearing Herbs       335
#>  9 Internal Disease                                Internal Disease          322
#> 10 Visceral Manifestation                          Visceral Manifestation    201
#> # ℹ 35 more rows
# }
```
