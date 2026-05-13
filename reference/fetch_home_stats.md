# Get homepage statistics

Get homepage statistics

## Usage

``` r
fetch_home_stats()
```

## Value

A named list with fields: `total_datasets`, `total_downloads`,
`total_file_size`, `recent_submissions_count`.

## Examples

``` r
# \donttest{
fetch_home_stats()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $total_datasets
#> [1] 1821
#> 
#> $total_downloads
#> [1] 104937
#> 
#> $total_file_size
#> [1] "0 B"
#> 
#> $recent_submissions_count
#> [1] 0
#> 
# }
```
