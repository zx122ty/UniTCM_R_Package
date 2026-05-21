# Search terms molecular mechanisms

Query the Terms Molecular Mechanisms database with optional filters.

## Usage

``` r
search_mechanisms(
  search = NULL,
  category = NULL,
  omics_type = NULL,
  evidence_level = NULL,
  confidence_level = NULL,
  study_type = NULL,
  species = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- search:

  Optional text search query.

- category:

  Category filter.

- omics_type:

  Omics type filter.

- evidence_level:

  Evidence level filter.

- confidence_level:

  Confidence level filter.

- study_type:

  Study type filter.

- species:

  Species filter.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of mechanism terms with attribute `"total"`.

## Examples

``` r
# \donttest{
search_mechanisms(search = "Qi deficiency")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 10
#>    tcm_term_id tcm_term_cn tcm_term_en tcm_term_category_ch tcm_term_category_en
#>          <int> <chr>       <chr>       <chr>                <chr>               
#>  1          17 脾气        spleen qi   脏腑                 Zang-Fu Organ       
#>  2         165 气          Qi          脏腑                 Zang-Fu Organ       
#>  3         194 气          Qi          脏腑                 Zang-Fu Organ       
#>  4         291 中气        Central Qi  脏腑                 Zang-Fu Organ       
#>  5         387 气虚        Qi deficie… 证型                 Syndrome Pattern    
#>  6         397 气虚        qi deficie… 证型                 Syndrome Pattern    
#>  7         420 气虚血瘀证  Qi Deficie… 证型                 Syndrome Pattern    
#>  8         536 气虚        Qi deficie… 证型                 Syndrome Pattern    
#>  9         636 心气虚      Xin-qi def… 证型                 Syndrome Pattern    
#> 10         669 肾气虚      kidney-qi … 证型                 Syndrome Pattern    
#> 11         929 肺气虚      Fei-qi def… 证型                 Syndrome Pattern    
#> 12         930 肺阴虚      Fei-yin de… 证型                 Syndrome Pattern    
#> 13         970 气虚        qi deficie… 证型                 Syndrome Pattern    
#> 14        1112 气虚        deficiency… 证型                 Syndrome Pattern    
#> 15        1214 气虚        Qi deficie… 证型                 Syndrome Pattern    
#> 16        1230 血瘀证      blood stag… 证型                 Syndrome Pattern    
#> 17        1244 气虚        qi deficie… 证型                 Syndrome Pattern    
#> 18        1334 气虚        qi deficie… 证型                 Syndrome Pattern    
#> 19        1347 气虚        qi deficie… 证型                 Syndrome Pattern    
#> 20        1350 气虚血瘀    qi deficie… 证型                 Syndrome Pattern    
#> # ℹ 5 more variables: western_disease_name <chr>, mapping_relationship <chr>,
#> #   confidence_level <chr>, evidence_level <chr>, pathophysiology_summary <chr>
# }
```
