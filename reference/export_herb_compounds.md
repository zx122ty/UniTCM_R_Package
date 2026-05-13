# Export herb compounds to CSV

Download a CSV export of all compounds for a specific herb.

## Usage

``` r
export_herb_compounds(herb_id, file = "herb_compounds_export.csv")
```

## Arguments

- herb_id:

  The UniTCM herb ID.

- file:

  Output file path (default `"herb_compounds_export.csv"`).

## Value

Invisible file path.

## Examples

``` r
# \donttest{
export_herb_compounds("UNITCM_H001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req, path = file): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "herb_id"), msg =
#>   "Input should be a valid integer, unable to parse string as an integer")
# }
```
