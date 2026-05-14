# Flatten a nested API response to a tibble

Recursively flattens a nested list into a single-row tibble. Nested
lists that cannot be further flattened are kept as list-columns.

## Usage

``` r
flatten_response(x)
```

## Arguments

- x:

  A named list from an API response.

## Value

A single-row
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html).

## Examples

``` r
if (FALSE) { # \dontrun{
herb <- get_herb("UNITCM_H001")
flatten_response(herb)
} # }
```
