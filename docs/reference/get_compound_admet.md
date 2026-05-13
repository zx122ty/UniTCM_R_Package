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
[`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
~90 ADMET columns.

## Examples

``` r
# \donttest{
get_compound_admet("UNITCM_I00001")
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "id"), msg = "Input
#>   should be a valid integer, unable to parse string as an integer")
# }
```
