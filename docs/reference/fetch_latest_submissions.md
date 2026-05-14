# Get latest submissions

Get latest submissions

## Usage

``` r
fetch_latest_submissions()
```

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
recent submissions with columns: `submission_id`, `project_title`,
`submitted_by`, `updated_at`, `institution`, `total_file_size`.

## Examples

``` r
if (FALSE) { # \dontrun{
fetch_latest_submissions()
} # }
```
