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
if (FALSE) { # \dontrun{
export_herb_compounds("UNITCM_H001")
} # }
```
