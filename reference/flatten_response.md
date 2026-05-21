# Flatten a nested API response to a tibble

Recursively flattens a nested list into a single-row tibble. Nested
lists that cannot be further flattened are kept as list-columns.

## Usage

``` r
flatten_response(x)
```

## Arguments

- x:

  A named list from an API response.

## Value

A single-row
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html).

## Examples

``` r
# \donttest{
herb <- get_herb("UNITCM_H001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
flatten_response(herb)
#> # A tibble: 1 × 32
#>   unitcm_herb_id herb_english_name_unique herb_english_name    herb_chinese_name
#>            <int> <chr>                    <chr>                <chr>            
#> 1              1 Delphinium stapeliosum   Delphinium stapelio… 斯塔佩尔翠雀花   
#> # ℹ 28 more variables: herb_pinyin_name <lgl>, herb_alias_name_ch <lgl>,
#> #   herb_alias_name_en <lgl>, herb_latin_name <lgl>, source <chr>,
#> #   herb_tcmbank_id <lgl>, tcmid_id <lgl>, tcm_id_id <lgl>, symmap_id <lgl>,
#> #   tcmsp_id <lgl>, herb_db_id <lgl>, tcmkd_id <lgl>, flavors <lgl>,
#> #   properties <lgl>, meridians <lgl>, medicinal_part <lgl>, efficacy <lgl>,
#> #   indication <lgl>, toxicity <lgl>, clinical_manifestations <lgl>,
#> #   therapeutic_en_class <lgl>, therapeutic_cn_class <lgl>, …
# }
```
