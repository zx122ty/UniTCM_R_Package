# Search herbs in the Herb Explorer

Query the UniTCM Herb Explorer with optional text search and faceted
filters. Multi-value filter parameters accept character vectors and are
collapsed to semicolon-separated strings internally.

## Usage

``` r
search_herbs(
  q = NULL,
  therapeutic_en = NULL,
  therapeutic_cn = NULL,
  family = NULL,
  toxicity = NULL,
  source = NULL,
  flavors = NULL,
  properties = NULL,
  meridians = NULL,
  medicinal_part = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Optional search query string.

- therapeutic_en:

  English therapeutic classification filter (character vector).

- therapeutic_cn:

  Chinese therapeutic classification filter (character vector).

- family:

  Botanical family filter (character vector).

- toxicity:

  Toxicity level filter (character vector).

- source:

  Data source filter (character vector).

- flavors:

  Flavor filter (character vector).

- properties:

  Property filter (character vector).

- meridians:

  Meridian tropism filter (character vector).

- medicinal_part:

  Medicinal part filter (character vector).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 200).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of herbs with attribute `"total"`.

## Examples

``` r
# \donttest{
search_herbs(q = "ginseng")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 9
#>    unitcm_herb_id herb_english_name     herb_chinese_name herb_latin_name family
#>             <int> <chr>                 <chr>             <chr>           <chr> 
#>  1             34 Panax ginseng         人参果实          NA              NA    
#>  2             57 Panax ginseng C. A. … 人参              NA              NA    
#>  3             58 Panax quinquefolius … 西洋参            NA              NA    
#>  4             66 ginseng               人参              Radix Ginseng   Arali…
#>  5             86 Panax                 人参属            NA              NA    
#>  6            156 Panax ginseng C.A. M… 人参              NA              NA    
#>  7            186 Panax notoginseng     三七              NA              NA    
#>  8            304 Radix Notoginseng     三七              NA              NA    
#>  9            318 Radix ginseng         人参              NA              NA    
#> 10            475 Panax notoginseng (B… 三七              NA              NA    
#> 11            660 Panax ginseng C. A. … 人参              NA              NA    
#> 12            755 Radix Panacis Quinqu… 西洋参            NA              NA    
#> 13           1113 Radix Ginseng Rubra   红参              NA              NA    
#> 14           1119 Acanthopanax sentico… 刺五加            NA              NA    
#> 15           1125 red ginseng           红参              Radix Ginseng … Arali…
#> 16           1126 white ginseng         白参              NA              NA    
#> 17           1284 white ginseng (WG)    白参              NA              NA    
#> 18           1285 red ginseng (RG)      红参              NA              NA    
#> 19           1286 dali ginseng (DG)     大理黄草乌        NA              NA    
#> 20           1415 Leejung-tang          理中汤            NA              NA    
#> # ℹ 4 more variables: therapeutic_en_class <chr>, toxicity <lgl>, source <chr>,
#> #   pmid <chr>
search_herbs(flavors = c("sweet", "bitter"), page_size = 50)
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 50 × 9
#>    unitcm_herb_id herb_english_name     herb_chinese_name herb_latin_name family
#>             <int> <chr>                 <chr>             <chr>           <chr> 
#>  1             32 Centella asiatica     百脉根            Lotus cornicul… Legum…
#>  2             36 Propolis              蜂胶              Apis mellifera… Apidae
#>  3             48 Silybum marianum      水飞蓟            Silybi Fructus… Aster…
#>  4             54 Radix Salviae miltio… 丹参              Salviae Miltio… Labia…
#>  5             61 red yeast rice        红曲              Semen Oryzae c… NA    
#>  6             66 ginseng               人参              Radix Ginseng   Arali…
#>  7            217 Angelica sinensis     当归藤            Embelia parvif… Myrsi…
#>  8            240 Cordyceps sinensis    大团囊虫草        Cordyceps Ophi… Clavi…
#>  9            323 Isatis indigotica     板蓝根（大青叶）  Folium Isatidis NA    
#> 10            357 Caulis Sinomenii      青风藤            Sinomenii Caul… Menis…
#> # ℹ 40 more rows
#> # ℹ 4 more variables: therapeutic_en_class <chr>, toxicity <lgl>, source <chr>,
#> #   pmid <chr>
# }
```
