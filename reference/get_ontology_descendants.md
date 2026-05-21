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
if (FALSE) { # \dontrun{
get_ontology_descendants("TCM_0001", max_level = 2)
} # }
```
