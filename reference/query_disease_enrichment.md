# Disease enrichment analysis (MIDAS)

Perform Fisher's exact test enrichment analysis to identify diseases
significantly associated with a gene list.

## Usage

``` r
query_disease_enrichment(
  gene_list,
  gene_id_type = "symbol",
  sources = NULL,
  min_sources = 1L,
  background_gene_count = 20000L,
  p_value_cutoff = 0.05,
  correction_method = "fdr",
  min_hit_count = 2L,
  page = 1L,
  page_size = 20L
)
```

## Arguments

- gene_list:

  Character vector of gene identifiers.

- gene_id_type:

  ID type: `"symbol"` (default), `"entrez"`, or `"ensembl"`.

- sources:

  Character vector of source databases (or `NULL`).

- min_sources:

  Minimum supporting sources (default 1).

- background_gene_count:

  Background gene count (default 20000).

- p_value_cutoff:

  P-value significance cutoff (default 0.05).

- correction_method:

  P-value correction: `"fdr"` (default), `"bonferroni"`, `"holm"`, or
  `"none"`.

- min_hit_count:

  Minimum gene hits per disease (default 2).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of enrichment results with attributes `"total_significant"`,
`"total_tested"`, and `"input_gene_count"`.

## Examples

``` r
# \donttest{
query_disease_enrichment(c("TP53", "BRCA1", "EGFR", "VEGFA"))
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 9
#>    disease_id    disease_name   observed_count disease_gene_count expected_count
#>    <chr>         <chr>                   <int>              <int>          <dbl>
#>  1 MONDO_0036976 benign epithe…              4                 47         0.0094
#>  2 EFO_1000412   Ovarian Carci…              4                 75         0.015 
#>  3 MONDO_0002379 cystic terato…              4                 83         0.0166
#>  4 EFO_0006718   ovarian leiom…              3                 11         0.0022
#>  5 EFO_0008491   atypical duct…              4                104         0.0208
#>  6 MONDO_0009668 lethal multip…              4                107         0.0214
#>  7 EFO_0002511   simple cystad…              4                116         0.0232
#>  8 MONDO_0017043 congenital me…              4                117         0.0234
#>  9 EFO_0011048   dermatologica…              4                121         0.0242
#> 10 MONDO_0002113 peritoneal ca…              4                131         0.0262
#> 11 EFO_0008545   Malignant Bre…              3                 17         0.0034
#> 12 EFO_0006891   breast adenos…              4                152         0.0304
#> 13 MONDO_0001082 lymph node ca…              3                 18         0.0036
#> 14 MONDO_0024621 serous cystad…              4                151         0.0302
#> 15 MONDO_0043771 radiodermatit…              4                148         0.0296
#> 16 MONDO_0859267 tumor predisp…              4                147         0.0294
#> 17 EFO_1000258   Fibrous Menin…              4                161         0.0322
#> 18 EFO_1000326   Lobular Breas…              4                162         0.0324
#> 19 MONDO_0002158 fallopian tub…              4                160         0.032 
#> 20 MONDO_0021047 breast phyllo…              4                156         0.0312
#> # ℹ 4 more variables: fold_enrichment <dbl>, p_value <dbl>,
#> #   adjusted_p_value <dbl>, hit_genes <list>
# }
```
