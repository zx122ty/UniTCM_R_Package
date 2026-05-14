# Autocomplete disease names (MIDAS)

Search for disease names with autocomplete. Query must be at least 2
characters.

## Usage

``` r
autocomplete_disease(q)
```

## Arguments

- q:

  Search query (minimum 2 characters).

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns: `disease_name`, `disease_id`, `gene_count`.

## Examples

``` r
if (FALSE) { # \dontrun{
autocomplete_disease("breast")
} # }
```
