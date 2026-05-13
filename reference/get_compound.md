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
# \donttest{
get_compound("UNITCM_I00001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "id"), msg = "Input
#>   should be a valid integer, unable to parse string as an integer")
# }
```
