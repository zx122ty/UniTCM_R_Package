# Get dataset facets

Returns available filter values and their counts for the TCMomics
database.

## Usage

``` r
fetch_dataset_facets()
```

## Value

A named list of tibbles for each facet field.

## Examples

``` r
if (FALSE) { # \dontrun{
facets <- fetch_dataset_facets()
facets$omics_type
} # }
```
