# Get MIDAS data sources

List all available gene-disease association databases.

## Usage

``` r
fetch_midas_sources()
```

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns: `key`, `label`, `has_score`, `weight`, `row_count`.

## Examples

``` r
if (FALSE) { # \dontrun{
fetch_midas_sources()
} # }
```
