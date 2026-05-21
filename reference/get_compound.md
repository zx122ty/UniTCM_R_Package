# Get a single compound by ID

Retrieve full detail for one compound including cross-references.

## Usage

``` r
get_compound(id)
```

## Arguments

- id:

  The UniTCM ingredient ID (e.g. `"UNITCM_I00001"`).

## Value

A named list with 26+ fields including an `xref` sub-list.

## Examples

``` r
if (FALSE) { # \dontrun{
get_compound("UNITCM_I00001")
} # }
```
