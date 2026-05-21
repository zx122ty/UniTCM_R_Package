# Get ADMET predictions for a compound

Returns ~90 ADMET endpoint predictions as a single-row wide tibble.

## Usage

``` r
get_compound_admet(id)
```

## Arguments

- id:

  The UniTCM ingredient ID.

## Value

A single-row
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with ~90 ADMET columns.

## Examples

``` r
# \donttest{
get_compound_admet("UNITCM_I00001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 1 × 111
#>   log_s log_d log_p    mp    bp pka_acidic pka_basic caco2  mdck  pampa pgp_inh
#>   <dbl> <dbl> <dbl> <dbl> <dbl>      <dbl>     <dbl> <dbl> <dbl>  <dbl>   <dbl>
#> 1 -4.31  3.43  4.37  174.  317.       5.67      4.38 -4.79 -4.84 0.0658   0.237
#> # ℹ 100 more variables: pgp_sub <dbl>, hia <dbl>, f20 <dbl>, f30 <dbl>,
#> #   f50 <dbl>, oatp1b1 <dbl>, oatp1b3 <dbl>, bcrp <dbl>, bsep <dbl>, bbb <dbl>,
#> #   mrp1 <dbl>, ppb <dbl>, log_vdss <dbl>, fu <dbl>, cyp1a2_inh <dbl>,
#> #   cyp1a2_sub <dbl>, cyp2c19_inh <dbl>, cyp2c19_sub <dbl>, cyp2c9_inh <dbl>,
#> #   cyp2c9_sub <dbl>, cyp2d6_inh <dbl>, cyp2d6_sub <dbl>, cyp3a4_inh <dbl>,
#> #   cyp3a4_sub <dbl>, cyp2b6_inh <dbl>, cyp2c8_inh <dbl>, lm_human <dbl>,
#> #   cl_plasma <dbl>, t0_5 <dbl>, bcf <dbl>, igc50 <dbl>, lc50dm <dbl>, …
# }
```
