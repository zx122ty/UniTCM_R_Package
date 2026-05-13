# Get ontology entities by level

Get ontology entities by level

## Usage

``` r
get_ontology_by_level(level, parent_id = NULL)
```

## Arguments

- level:

  Ontology level (integer, 1–4).

- parent_id:

  Optional parent entity ID to filter by.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html).

## Examples

``` r
# \donttest{
get_ontology_by_level(2)
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 76 × 7
#>    tcm_id      name              name_cn level path  children_count has_children
#>    <chr>       <chr>             <chr>   <int> <chr>          <int> <lgl>       
#>  1 TCM:0701000 Acupoints         腧穴        2 Trad…              7 TRUE        
#>  2 TCM:0301000 Acupuncture       针刺疗法……     2 Trad…             10 TRUE        
#>  3 TCM:0801000 Drug Properties   药性        2 Trad…              4 TRUE        
#>  4 TCM:0201000 Formula Composit… 组方原则……     2 Trad…              4 TRUE        
#>  5 TCM:0401000 Fundamental Theo… 基础理论……     2 Trad…              5 TRUE        
#>  6 TCM:1201000 General Treatmen… 基本治则……     2 Trad…              7 TRUE        
#>  7 TCM:0101000 Herbal Medicine   草药        2 Trad…              9 TRUE        
#>  8 TCM:0501000 Inspection Diagn… 望诊        2 Trad…              6 TRUE        
#>  9 TCM:0901000 Integrated TCM-W… 中西医结合……     2 Trad…              4 TRUE        
#> 10 TCM:1001000 Medical Classics  医学经典……     2 Trad…             12 TRUE        
#> # ℹ 66 more rows
# }
```
