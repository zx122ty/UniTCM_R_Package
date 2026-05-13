# Get a single dataset by submission ID

Retrieve full detail including nested persons, publications, grants, and
data files.

## Usage

``` r
get_dataset(submission_id)
```

## Arguments

- submission_id:

  The submission ID (e.g. `"TMA2025001"`).

## Value

A named list with nested sub-lists for `persons`, `publications`,
`grants`, and `data_files`.

## Examples

``` r
# \donttest{
get_dataset("TMA2025001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 404 Not Found.
#> ℹ Resource not found: Not Found
# }
```
