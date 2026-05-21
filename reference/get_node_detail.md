# Get node detail

Get node detail

## Usage

``` r
get_node_detail(node_id)
```

## Arguments

- node_id:

  Node ID.

## Value

A named list with fields: `id`, `type`, `label`, `label_cn`,
`properties`, `detail_url`.

## Examples

``` r
# \donttest{
get_node_detail("H:UNITCM_H001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $id
#> [1] "H:1"
#> 
#> $type
#> [1] "herb"
#> 
#> $label
#> [1] "Delphinium stapeliosum"
#> 
#> $label_cn
#> [1] "斯塔佩尔翠雀花"
#> 
#> $properties
#> $properties$pinyin
#> NULL
#> 
#> $properties$latin_name
#> NULL
#> 
#> $properties$family
#> NULL
#> 
#> $properties$properties_tcm
#> NULL
#> 
#> $properties$flavors
#> NULL
#> 
#> $properties$meridians
#> NULL
#> 
#> $properties$efficacy
#> NULL
#> 
#> $properties$therapeutic_cn_class
#> NULL
#> 
#> $properties$therapeutic_en_class
#> NULL
#> 
#> 
#> $detail_url
#> [1] "/herb-explorer/1"
#> 
# }
```
