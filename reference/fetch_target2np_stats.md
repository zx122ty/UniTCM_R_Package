# Fetch Target2NP database statistics

Returns counts and distributions across source databases, evidence
levels, target organisms, and activity types.

## Usage

``` r
fetch_target2np_stats()
```

## Value

A named list with `total_records` and four distribution lists.

## Examples

``` r
if (FALSE) { # \dontrun{
stats <- fetch_target2np_stats()
stats$total_records
} # }
```
