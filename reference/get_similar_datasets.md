# Get similar datasets

Find datasets similar to a given submission based on content similarity.

## Usage

``` r
get_similar_datasets(submission_id)
```

## Arguments

- submission_id:

  The submission ID.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns: `submission_id`, `project_title`, `TCM_classification`,
`similarity_score`.

## Examples

``` r
if (FALSE) { # \dontrun{
get_similar_datasets("TMA2025001")
} # }
```
