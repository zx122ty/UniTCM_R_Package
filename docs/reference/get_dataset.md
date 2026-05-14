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
if (FALSE) { # \dontrun{
get_dataset("TMA2025001")
} # }
```
