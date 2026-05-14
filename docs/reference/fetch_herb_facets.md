# Get herb filter facets

Returns available filter values and their counts for the Herb Explorer.

## Usage

``` r
fetch_herb_facets()
```

## Value

A named list of tibbles, one per facet field (e.g.
`therapeutic_en_class`, `family`, `toxicity`).

## Examples

``` r
if (FALSE) { # \dontrun{
facets <- fetch_herb_facets()
facets$toxicity
} # }
```
