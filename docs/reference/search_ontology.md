# Search the TCM Ontology

Full-text search across TCM ontology entities.

## Usage

``` r
search_ontology(q, limit = 20L, level = NULL, category = NULL)
```

## Arguments

- q:

  Search query (required).

- limit:

  Maximum results to return (default 20).

- level:

  Filter by ontology level (integer, 1–4).

- category:

  Filter by top-level category.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns: `tcm_id`, `name`, `name_cn`, `level`, `path`, `match_field`,
`highlight`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_ontology("Qi stagnation")
} # }
```
