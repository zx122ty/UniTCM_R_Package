# Get MIDAS data sources

List all available gene-disease association databases.

## Usage

``` r
fetch_midas_sources()
```

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns: `key`, `label`, `has_score`, `weight`, `row_count`.

## Examples

``` r
# \donttest{
fetch_midas_sources()
#> # A tibble: 11 × 5
#>    key                  label                         has_score weight row_count
#>    <chr>                <chr>                         <lgl>      <dbl>     <int>
#>  1 OpenTargets          Open Targets                  TRUE         1     4502004
#>  2 CTD                  CTD (Comparative Toxicogenom… FALSE        0.8     33426
#>  3 DISEASES_experiments DISEASES (Experiments)        TRUE         0.8    405789
#>  4 DISEASES_knowledge   DISEASES (Knowledge)          TRUE         0.8     70219
#>  5 DISEASES_textmining  DISEASES (Text Mining)        TRUE         0.5     60929
#>  6 ClinVar              ClinVar                       FALSE        0.9     12886
#>  7 GWAScatalog          GWAS Catalog                  TRUE         0.7    601500
#>  8 TTD                  TTD (Therapeutic Target Data… FALSE        0.7      9933
#>  9 UniProt              UniProt                       FALSE        0.9        32
#> 10 PharmGKB             PharmGKB                      FALSE        0.8      5575
#> 11 HPO                  HPO (Human Phenotype Ontolog… FALSE        0.7     15904
# }
```
