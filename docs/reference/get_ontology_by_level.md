# Get ontology entities by level

Get ontology entities by level

## Usage

``` r
get_ontology_by_level(level, parent_id = NULL)
```

## Arguments

- level:

  Ontology level (integer, 1–4).

- parent_id:

  Optional parent entity ID to filter by.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html).

## Examples

``` r
if (FALSE) { # \dontrun{
get_ontology_by_level(2)
} # }
```
