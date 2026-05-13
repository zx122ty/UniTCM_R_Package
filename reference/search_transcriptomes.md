# Search transcriptome datasets

Query the TCM Transcriptome Hub. This endpoint uses Style-B pagination
(`count`/`results` instead of `total`/`items`).

## Usage

``` r
search_transcriptomes(
  search = NULL,
  tcm_classification = NULL,
  organism = NULL,
  model_type = NULL,
  experiment_type = NULL,
  disease_classification = NULL,
  cell_line = NULL,
  comparison_type = NULL,
  confidence = NULL,
  sequence_type = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- search:

  Optional text search query.

- tcm_classification:

  TCM classification filter.

- organism:

  Organism filter.

- model_type:

  Model type filter.

- experiment_type:

  Experiment type filter.

- disease_classification:

  Disease classification filter.

- cell_line:

  Cell line filter.

- comparison_type:

  Comparison type filter.

- confidence:

  Confidence filter.

- sequence_type:

  Sequence type filter.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of datasets with attribute `"total"`.

## Examples

``` r
# \donttest{
search_transcriptomes(search = "ginseng")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 11 × 11
#>    id            submission_id  gse_id tcm_classification tcm_entity_name_chin…¹
#>    <chr>         <chr>          <chr>  <chr>              <chr>                 
#>  1 TCMtrans00041 tcmomics000231 GSE10… Herb/herbal medic… 三七                  
#>  2 TCMtrans00102 tcmomics000278 GSE12… Herb/herbal medic… 人参                  
#>  3 TCMtrans00103 tcmomics000278 GSE12… Herb/herbal medic… 人参                  
#>  4 TCMtrans00104 tcmomics000278 GSE12… Herb/herbal medic… 人参                  
#>  5 TCMtrans00129 tcmomics000152 GSE12… Herb/herbal medic… 高丽红参              
#>  6 TCMtrans00130 tcmomics000152 GSE12… Herb/herbal medic… 高丽红参              
#>  7 TCMtrans00191 tcmomics000340 GSE14… Herb/herbal medic… 人参花蕾              
#>  8 TCMtrans00192 tcmomics000340 GSE14… Herb/herbal medic… 人参花蕾              
#>  9 TCMtrans00196 tcmomics000349 GSE14… Herb/herbal medic… 高丽红参提取物        
#> 10 TCMtrans00197 tcmomics000349 GSE14… Herb/herbal medic… 高丽红参提取物        
#> 11 TCMtrans00719 tcmomics000920 GSE28… Herb/herbal medic… 熟三七                
#> # ℹ abbreviated name: ¹​tcm_entity_name_chinese
#> # ℹ 6 more variables: tcm_entity_name_english <chr>, organism <chr>,
#> #   tissue_organ <chr>, disease_model <chr>, experiment_type <chr>,
#> #   confidence <chr>
# }
```
