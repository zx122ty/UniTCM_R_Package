# Get a single herb by ID

Retrieve full detail for one herb from the Herb Explorer.

## Usage

``` r
get_herb(herb_id)
```

## Arguments

- herb_id:

  The UniTCM herb ID (e.g. `"UNITCM_H001"`).

## Value

A named list with 31 fields including cross-reference IDs.

## Examples

``` r
# \donttest{
get_herb("UNITCM_H001")
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "herb_id"), msg =
#>   "Input should be a valid integer, unable to parse string as an integer")
# }
```
