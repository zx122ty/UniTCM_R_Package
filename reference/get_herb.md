# Get a single herb by ID

Retrieve full detail for one herb from the Herb Explorer.

## Usage

``` r
get_herb(herb_id)
```

## Arguments

- herb_id:

  The UniTCM herb ID (e.g. `"UNITCM_H001"`).

## Value

A named list with 31 fields including cross-reference IDs.

## Examples

``` r
# \donttest{
get_herb("UNITCM_H001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $unitcm_herb_id
#> [1] 1
#> 
#> $herb_english_name_unique
#> [1] "Delphinium stapeliosum"
#> 
#> $herb_english_name
#> [1] "Delphinium stapeliosum"
#> 
#> $herb_chinese_name
#> [1] "斯塔佩尔翠雀花"
#> 
#> $herb_pinyin_name
#> NULL
#> 
#> $herb_alias_name_ch
#> NULL
#> 
#> $herb_alias_name_en
#> NULL
#> 
#> $herb_latin_name
#> NULL
#> 
#> $source
#> [1] "paper"
#> 
#> $herb_tcmbank_id
#> NULL
#> 
#> $tcmid_id
#> NULL
#> 
#> $tcm_id_id
#> NULL
#> 
#> $symmap_id
#> NULL
#> 
#> $tcmsp_id
#> NULL
#> 
#> $herb_db_id
#> NULL
#> 
#> $tcmkd_id
#> NULL
#> 
#> $flavors
#> NULL
#> 
#> $properties
#> NULL
#> 
#> $meridians
#> NULL
#> 
#> $medicinal_part
#> NULL
#> 
#> $efficacy
#> NULL
#> 
#> $indication
#> NULL
#> 
#> $toxicity
#> NULL
#> 
#> $clinical_manifestations
#> NULL
#> 
#> $therapeutic_en_class
#> NULL
#> 
#> $therapeutic_cn_class
#> NULL
#> 
#> $acquisition_time
#> NULL
#> 
#> $standards_for_medicinal_use
#> NULL
#> 
#> $family
#> NULL
#> 
#> $producer
#> NULL
#> 
#> $origin_text
#> NULL
#> 
#> $pmid
#> [1] "10650068"
#> 
# }
```
