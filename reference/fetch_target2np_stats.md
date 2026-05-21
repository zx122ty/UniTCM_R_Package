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
# \donttest{
stats <- fetch_target2np_stats()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
stats$total_records
#> [1] 911912
# }
```
