# Get omics type statistics

Get omics type statistics

## Usage

``` r
fetch_omics_type_stats()
```

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns: `omics_type`, `count`, `percentage`.

## Examples

``` r
# \donttest{
fetch_omics_type_stats()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 6 × 3
#>   omics_type      count percentage
#>   <chr>           <int>      <dbl>
#> 1 Transcriptomics  1164       64  
#> 2 proteomics        417       22.9
#> 3 Metabolomics      112        6.2
#> 4 Multi-omics        81        4.5
#> 5 Genomics           44        2.4
#> 6 Proteomics          1        0.1
# }
```
