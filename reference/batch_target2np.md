# Batch query Target2NP by identifier list

Look up interaction records for up to 50 gene symbols, UniProt IDs, or
Entrez gene IDs in one call.

## Usage

``` r
batch_target2np(
  identifiers,
  id_type = c("gene_symbol", "uniprot_id", "entrez_gene_id")
)
```

## Arguments

- identifiers:

  Character vector of identifiers (max 50).

- id_type:

  One of `"gene_symbol"` (default), `"uniprot_id"`, or
  `"entrez_gene_id"`.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of matching records with attributes `"total"`, `"queries_matched"`, and
`"queries_not_found"`.

## Examples

``` r
# \donttest{
batch_target2np(c("TP53", "BRCA1", "EGFR"))
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 300 × 13
#>    query record_id source_db evidence_level evidence_label       compound_name 
#>    <chr>     <int> <chr>              <int> <chr>                <chr>         
#>  1 TP53        361 HIT2                   2 Experimental binding Diosmin       
#>  2 TP53        492 HIT2                   2 Experimental binding Emodin        
#>  3 TP53        850 HIT2                   2 Experimental binding Eupatilin     
#>  4 TP53        930 HIT2                   2 Experimental binding Fisetin       
#>  5 TP53       1048 HIT2                   2 Experimental binding Gallic Acid   
#>  6 TP53       1167 HIT2                   2 Experimental binding Genistein     
#>  7 TP53       1355 HIT2                   2 Experimental binding Hydrocortisone
#>  8 TP53       1471 HIT2                   2 Experimental binding Isotretinoin  
#>  9 TP53       1489 HIT2                   2 Experimental binding Juglone       
#> 10 TP53       1679 HIT2                   2 Experimental binding Luteolin      
#> # ℹ 290 more rows
#> # ℹ 7 more variables: pubchem_cid <chr>, gene_symbol <chr>, uniprot_id <chr>,
#> #   activity_type <chr>, activity_value <dbl>, activity_units <chr>,
#> #   unitcm_ingredient_id <lgl>
batch_target2np(c("P04637", "P38398"), id_type = "uniprot_id")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 200 × 13
#>    query  record_id source_db evidence_level evidence_label       compound_name 
#>    <chr>      <int> <chr>              <int> <chr>                <chr>         
#>  1 P04637       361 HIT2                   2 Experimental binding Diosmin       
#>  2 P04637       492 HIT2                   2 Experimental binding Emodin        
#>  3 P04637       850 HIT2                   2 Experimental binding Eupatilin     
#>  4 P04637       930 HIT2                   2 Experimental binding Fisetin       
#>  5 P04637      1048 HIT2                   2 Experimental binding Gallic Acid   
#>  6 P04637      1167 HIT2                   2 Experimental binding Genistein     
#>  7 P04637      1355 HIT2                   2 Experimental binding Hydrocortisone
#>  8 P04637      1471 HIT2                   2 Experimental binding Isotretinoin  
#>  9 P04637      1489 HIT2                   2 Experimental binding Juglone       
#> 10 P04637      1679 HIT2                   2 Experimental binding Luteolin      
#> # ℹ 190 more rows
#> # ℹ 7 more variables: pubchem_cid <chr>, gene_symbol <chr>, uniprot_id <chr>,
#> #   activity_type <chr>, activity_value <dbl>, activity_units <chr>,
#> #   unitcm_ingredient_id <lgl>
# }
```
