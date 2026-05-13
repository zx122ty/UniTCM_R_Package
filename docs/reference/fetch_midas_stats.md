# Get MIDAS statistics

Get MIDAS statistics

## Usage

``` r
fetch_midas_stats()
```

## Value

A named list with fields: `total_associations`, `total_genes`,
`total_diseases`, `sources`.

## Examples

``` r
# \donttest{
fetch_midas_stats()
#> $total_associations
#> [1] 5718197
#> 
#> $total_genes
#> [1] 38074
#> 
#> $total_diseases
#> [1] 60752
#> 
#> $sources
#>                     key                                     label has_score
#> 1           OpenTargets                              Open Targets      TRUE
#> 2           GWAScatalog                              GWAS Catalog      TRUE
#> 3  DISEASES_experiments                    DISEASES (Experiments)      TRUE
#> 4    DISEASES_knowledge                      DISEASES (Knowledge)      TRUE
#> 5   DISEASES_textmining                    DISEASES (Text Mining)      TRUE
#> 6                   CTD CTD (Comparative Toxicogenomics Database)     FALSE
#> 7                   HPO            HPO (Human Phenotype Ontology)     FALSE
#> 8               ClinVar                                   ClinVar     FALSE
#> 9                   TTD         TTD (Therapeutic Target Database)     FALSE
#> 10             PharmGKB                                  PharmGKB     FALSE
#> 11              UniProt                                   UniProt     FALSE
#>    weight row_count
#> 1     1.0   4502004
#> 2     0.7    601500
#> 3     0.8    405789
#> 4     0.8     70219
#> 5     0.5     60929
#> 6     0.8     33426
#> 7     0.7     15904
#> 8     0.9     12886
#> 9     0.7      9933
#> 10    0.8      5575
#> 11    0.9        32
#> 
# }
```
