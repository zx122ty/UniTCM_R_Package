# Query disease-to-gene associations (MIDAS)

Given a disease query, find associated genes across multiple evidence
sources.

## Usage

``` r
query_disease_genes(
  disease_query,
  disease_id_type = "name",
  sources = NULL,
  min_sources = 1L,
  scoring_method = "max",
  page = 1L,
  page_size = 20L
)
```

## Arguments

- disease_query:

  Disease name or ID.

- disease_id_type:

  ID type: `"name"` (default) or `"icd11"`.

- sources:

  Character vector of source databases (or `NULL` for all).

- min_sources:

  Minimum supporting sources (default 1).

- scoring_method:

  Scoring method: `"max"` (default) or `"mean"`.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
disease-gene associations with attribute `"matched_diseases"`.

## Examples

``` r
# \donttest{
query_disease_genes("breast cancer")
#> # A tibble: 20 × 10
#>    gene_symbol ensembl_id      entrez_id uniprot_id    disease_name  disease_id
#>    <chr>       <chr>           <chr>     <chr>         <chr>         <chr>     
#>  1 CCND1       ENSG00000110092 595       P24385        Cancer        DOID:162  
#>  2 CDKN2A      ENSG00000147889 1029      P42771|Q8N726 Cancer        DOID:162  
#>  3 CDH1        ENSG00000039068 999       P12830        Cancer        DOID:162  
#>  4 BRCA2       ENSG00000139618 675       P51587        Cancer        DOID:162  
#>  5 BRCA2       ENSG00000139618 675       P51587        Breast cancer DOID:1612 
#>  6 AR          ENSG00000169083 367       P10275        Cancer        DOID:162  
#>  7 ATM         ENSG00000149311 472       Q13315        Cancer        DOID:162  
#>  8 AKT1        ENSG00000142208 207       P31749        Cancer        DOID:162  
#>  9 CASP8       ENSG00000064012 841       Q14790        Cancer        DOID:162  
#> 10 BRCA1       ENSG00000012048 672       P38398        Cancer        DOID:162  
#> 11 ALK         ENSG00000171094 238       Q9UM73        Cancer        DOID:162  
#> 12 BCL2        ENSG00000171791 596       P10415        Cancer        DOID:162  
#> 13 CHEK2       ENSG00000183765 11200     O96017        Cancer        DOID:162  
#> 14 ATM         ENSG00000149311 472       Q13315        Breast cancer DOID:1612 
#> 15 CDKN2A      ENSG00000147889 1029      P42771|Q8N726 Lung cancer   DOID:1324 
#> 16 CDKN1B      ENSG00000111276 1027      P46527        Cancer        DOID:162  
#> 17 CASP8       ENSG00000064012 841       Q14790        Breast cancer DOID:1612 
#> 18 CCNE1       ENSG00000105173 898       P24864        Cancer        DOID:162  
#> 19 AXIN1       ENSG00000103126 8312      O15169        Cancer        DOID:162  
#> 20 CTCF        ENSG00000102974 10664     P49711        Cancer        DOID:162  
#> # ℹ 4 more variables: source_count <int>, sources_detail <list>,
#> #   aggregated_score <dbl>, total_pubmed_count <int>
# }
```
