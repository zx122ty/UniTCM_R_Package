# Get predicted targets for a compound

Retrieve target predictions from DrugCLIP, ChEMBL similarity search, or
both.

## Usage

``` r
get_compound_targets(
  id,
  method = c("drugclip", "chembl", "both"),
  page = 1L,
  page_size = 20L
)
```

## Arguments

- id:

  The UniTCM ingredient ID.

- method:

  One of `"drugclip"`, `"chembl"`, or `"both"` (default `"drugclip"`).

- page:

  Page number (for ChEMBL targets, default 1).

- page_size:

  Results per page (for ChEMBL targets, default 20).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of targets. When `method = "both"`, a `source` column is added to
distinguish results.

## Examples

``` r
# \donttest{
get_compound_targets("UNITCM_I00001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 100 × 5
#>     rank gene_symbol target_id score pocket_id
#>    <int> <chr>       <chr>     <dbl>     <int>
#>  1     1 BLTP2       Q14667     2.42         4
#>  2     2 MTIF2       P46199     1.75         1
#>  3     3 ZNF605      Q86T29     1.49         2
#>  4     4 ZNF184      Q99676     1.49         1
#>  5     5 FN1         P02751     1.47        14
#>  6     6 SPTAN1      Q13813     1.46        20
#>  7     7 ZNF20       P17024     1.46         1
#>  8     8 ZNF607      Q96SK3     1.25         1
#>  9     9 CNTROB      Q8N137     1.23         0
#> 10    10 EZR         P15311     1.17         1
#> # ℹ 90 more rows
get_compound_targets("UNITCM_I00001", method = "both")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 107 × 15
#>     rank gene_symbol target_id score pocket_id source   target_chembl_id
#>    <int> <chr>       <chr>     <dbl>     <int> <chr>    <chr>           
#>  1     1 BLTP2       Q14667     2.42         4 drugclip NA              
#>  2     2 MTIF2       P46199     1.75         1 drugclip NA              
#>  3     3 ZNF605      Q86T29     1.49         2 drugclip NA              
#>  4     4 ZNF184      Q99676     1.49         1 drugclip NA              
#>  5     5 FN1         P02751     1.47        14 drugclip NA              
#>  6     6 SPTAN1      Q13813     1.46        20 drugclip NA              
#>  7     7 ZNF20       P17024     1.46         1 drugclip NA              
#>  8     8 ZNF607      Q96SK3     1.25         1 drugclip NA              
#>  9     9 CNTROB      Q8N137     1.23         0 drugclip NA              
#> 10    10 EZR         P15311     1.17         1 drugclip NA              
#> # ℹ 97 more rows
#> # ℹ 8 more variables: target_pref_name <chr>, uniprot_id <chr>,
#> #   n_similar_ligands <int>, max_tanimoto <dbl>, mean_tanimoto <dbl>,
#> #   sea_zscore <dbl>, sea_pvalue <dbl>, pvalue_adjusted <dbl>
# }
```
