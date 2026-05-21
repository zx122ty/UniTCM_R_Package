# Get neighbors of a node

Get neighbors of a node

## Usage

``` r
get_neighbors(node_id, depth = 1L, limit = 50L, node_types = NULL)
```

## Arguments

- node_id:

  Node ID (e.g. `"H:UNITCM_H001"`).

- depth:

  Neighbor depth (1–3, default 1).

- limit:

  Maximum neighbors (max 200, default 50).

- node_types:

  Comma-separated node types to include.

## Value

A named list with `$nodes`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)),
`$edges`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)),
and `$has_more`.

## Examples

``` r
if (FALSE) { # \dontrun{
get_neighbors("H:UNITCM_H001", depth = 1)
} # }
```
