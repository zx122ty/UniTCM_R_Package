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
if (FALSE) { # \dontrun{
get_compound_admet("UNITCM_I00001")
} # }
```
