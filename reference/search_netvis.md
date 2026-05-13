# Search NetVis nodes

Search NetVis nodes

## Usage

``` r
search_netvis(q, type = "all", limit = 20L)
```

## Arguments

- q:

  Search query.

- type:

  Node type filter: `"all"` (default), `"formula"`, `"herb"`,
  `"compound"`, `"target"`, or `"disease"`.

- limit:

  Maximum results (default 20).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns: `id`, `type`, `label`, `label_cn`, `degree`.

## Examples

``` r
# \donttest{
search_netvis("ginseng", type = "herb")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 5
#>    id     type  label                               label_cn   degree
#>    <chr>  <chr> <chr>                               <chr>       <int>
#>  1 H:34   herb  Panax ginseng                       人参果实        0
#>  2 H:57   herb  Panax ginseng C. A. Meyer           人参            0
#>  3 H:66   herb  ginseng                             人参            0
#>  4 H:156  herb  Panax ginseng C.A. Meyer            人参            0
#>  5 H:186  herb  Panax notoginseng                   三七            0
#>  6 H:318  herb  Radix ginseng                       人参            0
#>  7 H:304  herb  Radix Notoginseng                   三七            0
#>  8 H:475  herb  Panax notoginseng (Burk.) F.H. Chen 三七            0
#>  9 H:660  herb  Panax ginseng C. A. Mey.            人参            0
#> 10 H:1113 herb  Radix Ginseng Rubra                 红参            0
#> 11 H:1125 herb  red ginseng                         红参            0
#> 12 H:1126 herb  white ginseng                       白参            0
#> 13 H:1284 herb  white ginseng (WG)                  白参            0
#> 14 H:1285 herb  red ginseng (RG)                    红参            0
#> 15 H:1286 herb  dali ginseng (DG)                   大理黄草乌      0
#> 16 H:1693 herb  Asian ginseng                       人参            0
#> 17 H:1747 herb  American ginseng                    西洋参          0
#> 18 H:1872 herb  Ginseng Radix et Rhizoma            人参            0
#> 19 H:1937 herb  mountain cultivated ginseng         山参            0
#> 20 H:2020 herb  Panax notoginseng flower            三七花          0
# }
```
