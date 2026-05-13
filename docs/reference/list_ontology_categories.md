# List top-level ontology categories

List top-level ontology categories

## Usage

``` r
list_ontology_categories()
```

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
level-1 entities.

## Examples

``` r
# \donttest{
list_ontology_categories()
#> # A tibble: 14 × 7
#>    tcm_id      name              name_cn level path  children_count has_children
#>    <chr>       <chr>             <chr>   <int> <chr>          <int> <lgl>       
#>  1 TCM:0100000 Materia Medica    中药        1 Trad…              6 TRUE        
#>  2 TCM:0200000 Formulas and Pre… 方剂与制剂……     1 Trad…              7 TRUE        
#>  3 TCM:0300000 Therapeutic Tech… 治疗技术……     1 Trad…              9 TRUE        
#>  4 TCM:0400000 Theoretical Conc… 理论概念……     1 Trad…              7 TRUE        
#>  5 TCM:0500000 Diagnostic Metho… 诊断方法……     1 Trad…              6 TRUE        
#>  6 TCM:0600000 Diseases and Pat… 病证        1 Trad…              3 TRUE        
#>  7 TCM:0700000 Anatomical Conce… 解剖概念……     1 Trad…              3 TRUE        
#>  8 TCM:0800000 TCM Pharmacology  中药药理……     1 Trad…              5 TRUE        
#>  9 TCM:0900000 Integration and … 整合与现代化…     1 Trad…              5 TRUE        
#> 10 TCM:1000000 Classical Texts … 经典文献与传…     1 Trad…              5 TRUE        
#> 11 TCM:1100000 Regulatory and S… 法规与标准……     1 Trad…              4 TRUE        
#> 12 TCM:1200000 Treatment Princi… 治则治法……     1 Trad…              3 TRUE        
#> 13 TCM:1300000 Health Preservat… 养生与预防……     1 Trad…              6 TRUE        
#> 14 TCM:1400000 Ethnic Tradition… 民族医药……     1 Trad…              7 TRUE        
# }
```
