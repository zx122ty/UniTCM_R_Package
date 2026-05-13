# Query gene-to-disease associations (MIDAS)

Given a list of gene symbols or IDs, find associated diseases across
multiple evidence sources.

## Usage

``` r
query_gene_diseases(
  gene_list,
  gene_id_type = "symbol",
  sources = NULL,
  min_sources = 1L,
  min_score = 0,
  evidence_types = NULL,
  scoring_method = "max",
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

  Character vector of source databases to query (or `NULL` for all).

- min_sources:

  Minimum number of sources supporting an association (default 1).

- min_score:

  Minimum association score (default 0).

- evidence_types:

  Character vector of evidence types to filter by.

- scoring_method:

  Scoring method: `"max"` (default) or `"mean"`.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
gene-disease associations with attribute `"gene_mapping"` containing the
gene ID resolution mapping.

## Examples

``` r
# \donttest{
query_gene_diseases(c("TP53", "BRCA1"))
#> # A tibble: 20 × 12
#>    gene_symbol ensembl_id      entrez_id uniprot_id disease_name      disease_id
#>    <chr>       <chr>           <chr>     <chr>      <chr>             <chr>     
#>  1 BRCA1       ENSG00000012048 672       P38398     Organ system can… DOID:0050…
#>  2 BRCA1       ENSG00000012048 672       P38398     Ovarian disease   DOID:1100 
#>  3 BRCA1       ENSG00000012048 672       P38398     Female reproduct… DOID:120  
#>  4 BRCA1       ENSG00000012048 672       P38398     Disease of cellu… DOID:14566
#>  5 BRCA1       ENSG00000012048 672       P38398     Cancer            DOID:162  
#>  6 BRCA1       ENSG00000012048 672       P38398     Gonadal disease   DOID:2277 
#>  7 BRCA1       ENSG00000012048 672       P38398     Ovarian cancer    DOID:2394 
#>  8 BRCA1       ENSG00000012048 672       P38398     ICD10:C           ICD10:C   
#>  9 BRCA1       ENSG00000012048 672       P38398     ICD10:C5          ICD10:C5  
#> 10 BRCA1       ENSG00000012048 672       P38398     ICD10:C56         ICD10:C56 
#> 11 BRCA1       ENSG00000012048 672       P38398     ICD10:C57         ICD10:C57 
#> 12 BRCA1       ENSG00000012048 672       P38398     ICD10:C8          ICD10:C8  
#> 13 BRCA1       ENSG00000012048 672       P38398     Reproductive org… DOID:193  
#> 14 BRCA1       ENSG00000012048 672       P38398     Disease of anato… DOID:7    
#> 15 BRCA1       ENSG00000012048 672       P38398     Female reproduct… DOID:229  
#> 16 BRCA1       ENSG00000012048 672       P38398     Disease           DOID:4    
#> 17 BRCA1       ENSG00000012048 672       P38398     Reproductive sys… DOID:15   
#> 18 BRCA1       ENSG00000012048 672       P38398     Endocrine system… DOID:28   
#> 19 BRCA1       ENSG00000012048 672       P38398     Cell type cancer  DOID:0050…
#> 20 BRCA1       ENSG00000012048 672       P38398     Carcinoma         DOID:305  
#> # ℹ 6 more variables: disease_ids_by_source <df[,3]>, source_count <int>,
#> #   sources_detail <list>, aggregated_score <dbl>, total_pubmed_count <int>,
#> #   scoring_method <chr>
# }
```
