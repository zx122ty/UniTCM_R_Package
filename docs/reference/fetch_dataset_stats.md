# Get TCMomics database statistics

Get TCMomics database statistics

## Usage

``` r
fetch_dataset_stats()
```

## Value

A named list with fields: `total_datasets`, `total_downloads`,
`omics_types_count`, `unique_organisms`.

## Examples

``` r
# \donttest{
fetch_dataset_stats()
#> $total_datasets
#> [1] 1821
#> 
#> $total_downloads
#> [1] 104937
#> 
#> $omics_types_count
#> [1] 6
#> 
#> $unique_organisms
#> [1] 189
#> 
# }
```
