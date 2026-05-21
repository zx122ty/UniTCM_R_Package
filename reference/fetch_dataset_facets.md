# Get dataset facets

Returns available filter values and their counts for the TCMomics
database.

## Usage

``` r
fetch_dataset_facets()
```

## Value

A named list of tibbles for each facet field.

## Examples

``` r
# \donttest{
facets <- fetch_dataset_facets()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
facets$omics_type
#> # A tibble: 6 × 3
#>   value           label           count
#>   <chr>           <chr>           <int>
#> 1 Transcriptomics Transcriptomics  1164
#> 2 proteomics      proteomics        417
#> 3 Metabolomics    Metabolomics      112
#> 4 Multi-omics     Multi-omics        81
#> 5 Genomics        Genomics           44
#> 6 Proteomics      Proteomics          1
# }
```
