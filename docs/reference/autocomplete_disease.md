# Autocomplete disease names (MIDAS)

Search for disease names with autocomplete. Query must be at least 2
characters.

## Usage

``` r
autocomplete_disease(q)
```

## Arguments

- q:

  Search query (minimum 2 characters).

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns: `disease_name`, `disease_id`, `gene_count`.

## Examples

``` r
# \donttest{
autocomplete_disease("breast")
#> # A tibble: 10 × 3
#>    disease_name   disease_id    gene_count
#>    <chr>          <chr>              <int>
#>  1 breast cyst    EFO_1000848          109
#>  2 breast size    OBA_1000025           75
#>  3 Breast mass    HP_0032408            14
#>  4 breast cancer  MONDO_0007254      14687
#>  5 Breast disease DOID:3463            578
#>  6 Breast cancer  DOID:1612            576
#>  7 breast disease EFO_0009483          544
#>  8 Breast cancer  ICD11:2C6Y           134
#>  9 Breast cancer  ICD11:2C60           134
#> 10 breast density OBA_2050351          796
# }
```
