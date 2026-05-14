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
if (FALSE) { # \dontrun{
export_compound_module("UNITCM_I00001", "admet")
} # }
```
