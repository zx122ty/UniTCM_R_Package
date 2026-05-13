# Fetch ontology statistics

Fetch ontology statistics

## Usage

``` r
fetch_ontology_stats()
```

## Value

A named list with fields: `total_entities`, `total_level1`–
`total_level4`, `total_relations`, `total_mappings`, `categories`.

## Examples

``` r
# \donttest{
fetch_ontology_stats()
#> $total_entities
#> [1] 632
#> 
#> $total_level1
#> [1] 14
#> 
#> $total_level2
#> [1] 76
#> 
#> $total_level3
#> [1] 411
#> 
#> $total_level4
#> [1] 62
#> 
#> $total_relations
#> [1] 0
#> 
#> $total_mappings
#> [1] 56
#> 
#> $categories
#>         tcm_id                               name        name_cn count
#> 1  TCM:0100000                     Materia Medica           中药    46
#> 2  TCM:0200000          Formulas and Preparations     方剂与制剂    54
#> 3  TCM:0300000             Therapeutic Techniques       治疗技术    58
#> 4  TCM:0400000               Theoretical Concepts       理论概念    48
#> 5  TCM:0500000                 Diagnostic Methods       诊断方法    36
#> 6  TCM:0600000              Diseases and Patterns           病证    29
#> 7  TCM:0700000                Anatomical Concepts       解剖概念    20
#> 8  TCM:0800000                   TCM Pharmacology       中药药理   129
#> 9  TCM:0900000      Integration and Modernization   整合与现代化    22
#> 10 TCM:1000000       Classical Texts and Heritage 经典文献与传承    39
#> 11 TCM:1100000           Regulatory and Standards     法规与标准    16
#> 12 TCM:1200000   Treatment Principles and Methods       治则治法    26
#> 13 TCM:1300000 Health Preservation and Prevention     养生与预防    24
#> 14 TCM:1400000        Ethnic Traditional Medicine       民族医药    84
#> 
# }
```
