# Get ancestors of an ontology entity

Get ancestors of an ontology entity

## Usage

``` r
get_ontology_ancestors(tcm_id)
```

## Arguments

- tcm_id:

  The TCM ontology ID.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns: `tcm_id`, `name`, `name_cn`, `level`.

## Examples

``` r
# \donttest{
get_ontology_ancestors("TCM_0001")
#> Error in httr2::req_perform(req): HTTP 404 Not Found.
#> ℹ Resource not found: Not Found
# }
```
