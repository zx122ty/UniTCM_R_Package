# Get mechanism filter options

Fetches all 6 filter option endpoints and returns them as a named list
of tibbles.

## Usage

``` r
fetch_mechanism_filters()
```

## Value

A named list with elements: `categories`, `omics_types`,
`evidence_levels`, `confidence_levels`, `study_types`, `species`. Each
is a
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns `value`, `label`, `count`.

## Examples

``` r
if (FALSE) { # \dontrun{
filters <- fetch_mechanism_filters()
filters$categories
} # }
```
