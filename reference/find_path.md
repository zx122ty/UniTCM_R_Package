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
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html))
and `$edges`
([`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)).

## Examples

``` r
# \donttest{
find_path("H:UNITCM_H001", "T:TP53")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 504 Gateway Timeout.
#> ℹ HTTP 504:
# }
```
