# Export compound data by module

Download a CSV of a specific data module for one compound.

## Usage

``` r
export_compound_module(
  id,
  module = c("overview", "physicochemical", "admet", "targets"),
  file = NULL
)
```

## Arguments

- id:

  The UniTCM ingredient ID.

- module:

  One of `"overview"`, `"physicochemical"`, `"admet"`, or `"targets"`.

- file:

  Output file path (auto-generated if `NULL`).

## Value

Invisible file path.

## Examples

``` r
# \donttest{
export_compound_module("UNITCM_I00001", "admet")
#> Error in httr2::req_perform(req, path = file): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "id"), msg = "Input
#>   should be a valid integer, unable to parse string as an integer")
# }
```
