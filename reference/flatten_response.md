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
# \donttest{
herb <- get_herb("UNITCM_H001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "herb_id"), msg =
#>   "Input should be a valid integer, unable to parse string as an integer")
flatten_response(herb)
#> Error: object 'herb' not found
# }
```
