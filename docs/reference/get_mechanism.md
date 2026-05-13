# Get a single mechanism term by ID

Retrieve full detail for one term including nested arrays of biomarkers,
pathways, gene targets, metabolites, etc.

## Usage

``` r
get_mechanism(term_id)
```

## Arguments

- term_id:

  The mechanism term ID.

## Value

A named list with ~50 fields. Nested arrays (e.g. `biomarkers`,
`signaling_pathways`, `gene_targets`) are returned as-is (lists).

## Examples

``` r
# \donttest{
get_mechanism("TMM001")
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "term_id"), msg =
#>   "Input should be a valid integer, unable to parse string as an integer")
# }
```
