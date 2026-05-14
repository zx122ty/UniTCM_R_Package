# Find shortest path between two nodes

Find shortest path between two nodes

## Usage

``` r
find_path(source, target, max_depth = 4L)
```

## Arguments

- source:

  Source node ID.

- target:

  Target node ID.

- max_depth:

  Maximum path depth (max 8, default 4).

## Value

A named list with `$nodes`
([`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html)) and
`$edges`
([`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html)).

## Examples

``` r
if (FALSE) { # \dontrun{
find_path("H:UNITCM_H001", "T:TP53")
} # }
```
