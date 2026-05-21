# Get all descendants of an ontology entity

Get all descendants of an ontology entity

## Usage

``` r
get_ontology_descendants(tcm_id, max_level = NULL)
```

## Arguments

- tcm_id:

  The TCM ontology ID.

- max_level:

  Maximum depth to descend (integer or `NULL` for all).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html).

## Examples

``` r
# \donttest{
get_ontology_descendants("TCM_0001", max_level = 2)
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 404 Not Found.
#> ℹ Resource not found: Not Found
# }
```
