# Get subgraph for a set of nodes

Get subgraph for a set of nodes

## Usage

``` r
get_subgraph(node_ids, limit = 200L)
```

## Arguments

- node_ids:

  Character vector of node IDs (max 50).

- limit:

  Maximum edges (default 200).

## Value

A named list with `$nodes`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)),
`$edges`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)),
and `$has_more`.

## Examples

``` r
if (FALSE) { # \dontrun{
get_subgraph(c("H:UNITCM_H001", "C:UNITCM_I00001"))
} # }
```
