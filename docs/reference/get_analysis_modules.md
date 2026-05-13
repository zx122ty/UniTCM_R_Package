# List available analysis modules for a dataset

List available analysis modules for a dataset

## Usage

``` r
get_analysis_modules(dataset_id)
```

## Arguments

- dataset_id:

  The dataset ID.

## Value

A character vector of available module names.

## Examples

``` r
# \donttest{
get_analysis_modules("TCMtrans00001")
#>  [1] "meta"       "expression" "deg"        "go"         "kegg"      
#>  [6] "gsea"       "ppi"        "immune"     "tf"         "pca"       
#> [11] "qc"        
# }
```
