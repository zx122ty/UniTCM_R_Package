# Get children of an ontology entity

Get children of an ontology entity

## Usage

``` r
get_ontology_children(tcm_id)
```

## Arguments

- tcm_id:

  The TCM ontology ID.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns: `tcm_id`, `name`, `name_cn`, `level`, `path`,
`children_count`, `has_children`.

## Examples

``` r
# \donttest{
get_ontology_children("TCM_0001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 404 Not Found.
#> ℹ Resource not found: Not Found
# }
```
