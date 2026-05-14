# Get compound facets and statistics

Returns summary statistics and filter option counts for the Ingredient
Explorer.

## Usage

``` r
fetch_compound_facets()
```

## Value

A named list with fields: `total`, `approved_count`, `lipinski_counts`,
`drug_counts`, `mw_range`, `clogp_range`, `tpsa_range`, `qed_range`.

## Examples

``` r
if (FALSE) { # \dontrun{
fetch_compound_facets()
} # }
```
