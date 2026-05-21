# List term sources

List term sources

## Usage

``` r
list_term_sources()
```

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns `value`, `label`, `count`.

## Examples

``` r
# \donttest{
list_term_sources()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 13 × 3
#>    value                                                             label count
#>    <chr>                                                             <chr> <int>
#>  1 "Chinese-English-Medical-Dictionary"                              "Chi… 28430
#>  2 "简明汉英中医词典"                                                "简明汉… 26428
#>  3 "新编汉英中医药分类词典 Classified Dictionary of TraditionalChinese Medicin… "新编汉…  7284
#>  4 "people's Health Publishing House (PMPH)"                         "peo…  6833
#>  5 "World Federation of Chinese Medicine Associations (WFCMS)"       "Wor…  6078
#>  6 "中医基本名词术语中英对照国际标准 International Standard Chinese-EnglishBasic No… "中医基…  6003
#>  7 "汉英中医药分类辞典 CLASSIFIED DICTIONARYOF TRADITIONALCHINESE MEDICINE"…… "汉英中…  5936
#>  8 "国家中医药管理局 国家卫生健康委员会《中医病证分类与代码》\\《中医临床诊疗术语》"…… "国家中…  4590
#>  9 "World Health Organization (WHO)"                                 "Wor…  3261
#> 10 "汉英双解中医临床标准术语辞典Chinese-English Dictionary of State Standard Clin… "汉英双…  3126
#> 11 "TCMWiKi"                                                         "TCM…  1337
#> 12 "《中药方剂图像数据库》"                                          "《中药…   603
#> 13 "TCMCN website"                                                   "TCM…    25
# }
```
