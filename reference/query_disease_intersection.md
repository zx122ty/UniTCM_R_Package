# Find disease intersection (MIDAS)

Find genes shared across multiple diseases.

## Usage

``` r
query_disease_intersection(disease_queries, sources = NULL)
```

## Arguments

- disease_queries:

  Character vector of disease names/IDs.

- sources:

  Character vector of source databases (or `NULL`).

## Value

A named list with elements: `$diseases`, `$per_source`, `$targets`,
`$total_intersection_genes`.

## Examples

``` r
if (FALSE) { # \dontrun{
query_disease_intersection(c("breast cancer", "lung cancer"))
} # }
```
