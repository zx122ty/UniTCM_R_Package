# Search TCM bilingual corpus terms

Query the TCM Bilingual Corpus with optional text search and filters.

## Usage

``` r
search_terms(
  q = NULL,
  sources = NULL,
  category = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Optional search query string.

- sources:

  Data source filter (character vector, comma-collapsed).

- category:

  Category filter (character vector, comma-collapsed).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 100).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of terms with attribute `"total"`.

## Examples

``` r
# \donttest{
search_terms(q = "ginseng")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 14
#>       id chinese_name         pinyin     english_name latin_name synonym_chinese
#>    <int> <chr>                <chr>      <chr>        <chr>      <chr>          
#>  1   163 朝鲜参               "chao xia… "Korean gin… ""         ""             
#>  2  1313 大力参               "da li sh… "great stre… ""         ""             
#>  3  1561 单行                 "dan xing" "acting sin… ""         ""             
#>  4  2251 高丽参               "gao li s… "Korean gin… ""         ""             
#>  5  2813 广东人参             "guang do… "American g… ""         ""             
#>  6  2841 龟鹿参杞胶           "gui lu s… "Tortoise S… ""         ""             
#>  7  2951 桂枝加芍药生姜人参汤 "gui zhi … "Cinnamon T… ""         ""             
#>  8  2962 桂枝人参汤           "gui zhi … "Cinnamon T… ""         ""             
#>  9  3391 何人饮               "he ren y… "Flowery Kn… ""         ""             
#> 10  3686 红参                 "hong she… "red ginsen… ""         ""             
#> 11  4294 白人参               "bai ren … "white gins… ""         ""             
#> 12  4310 白参                 "bai shen" "white gins… ""         ""             
#> 13  4333 白糖参               "bai tang… "white-suga… ""         ""             
#> 14  5926 东北参               "dong bei… "Manchurian… ""         ""             
#> 15  5947 东洋参               "dong yan… "ginseng (G… ""         ""             
#> 16  6059 独参汤               "du shen … "Pure Ginse… ""         ""             
#> 17  6220 峨三七               "e san qi" "Emei great… ""         ""             
#> 18  7234 佛兰参               "fo lan s… "American g… ""         ""             
#> 19  7565 干姜黄芩黄连人参汤   "gan jian… "Dried Ging… ""         ""             
#> 20  7566 干姜人参半夏丸       "gan jian… "Dried Ging… ""         ""             
#> # ℹ 8 more variables: synonym_english <chr>, description_english <chr>,
#> #   description_chinese <chr>, category_english <chr>, category_second <chr>,
#> #   category_chinese <chr>, source <chr>, origin_code <chr>
# }
```
