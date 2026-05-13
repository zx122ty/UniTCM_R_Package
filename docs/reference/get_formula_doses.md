# Get herb doses for a formula

Retrieve the composition and dosage information for a specific formula.

## Usage

``` r
get_formula_doses(order_id)
```

## Arguments

- order_id:

  The formula order ID.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns: `id`, `herb_name`, `original_dose`, `composition_ratio`,
`modern_dose_g`, `clinical_ref_dose_g`, `dynasty`, `notes`, `herb_ids`.

## Examples

``` r
# \donttest{
get_formula_doses(1)
#> # A tibble: 9 × 9
#>        id herb_name original_dose composition_ratio modern_dose_g
#>     <int> <chr>     <chr>                     <dbl>         <dbl>
#> 1 1049198 地黄      10g                        3.33            10
#> 2 1049199 当归      6g                         2                6
#> 3 1049200 党参      10g                        3.33            10
#> 4 1049201 炒白术    10g                        3.33            10
#> 5 1049202 陈皮      10g                        3.33            10
#> 6 1049203 菟丝子    10g                        3.33            10
#> 7 1049204 川续断    10g                        3.33            10
#> 8 1049205 制香附    10g                        3.33            10
#> 9 1049206 月季花    3g                         1                3
#> # ℹ 4 more variables: clinical_ref_dose_g <dbl>, dynasty <chr>, notes <chr>,
#> #   herb_ids <list>
# }
```
