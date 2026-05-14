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

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns: `tcm_id`, `name`, `name_cn`, `level`.

## Examples

``` r
if (FALSE) { # \dontrun{
get_ontology_ancestors("TCM_0001")
} # }
```
