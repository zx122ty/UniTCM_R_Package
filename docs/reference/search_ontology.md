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
# \donttest{
search_ontology("Qi stagnation")
#> # A tibble: 2 × 7
#>   tcm_id      name                     name_cn level path  match_field highlight
#>   <chr>       <chr>                    <chr>   <int> <chr> <chr>       <chr>    
#> 1 TCM:0405008 Qi Stagnation Constitut… 气郁质      3 Trad… name        Qi Stagn…
#> 2 TCM:0602008 Qi Stagnation Patterns   气滞证      3 Trad… name        Qi Stagn…
# }
```
