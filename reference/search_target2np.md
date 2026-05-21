# Search Target2NP compound-target interactions

Query the UniTCM Target2NP database of natural-product to protein-target
interactions, combining records from experimental sources such as
BindingDB, HERB2, NPASS, BATMAN, and others.

## Usage

``` r
search_target2np(
  search = NULL,
  search_field = c("all", "gene_symbol", "compound_name", "uniprot_id", "inchikey",
    "pubchem_cid", "chembl_id"),
  search_mode = c("exact", "fuzzy"),
  source_db = NULL,
  evidence_level = NULL,
  evidence_label = NULL,
  target_organism = NULL,
  interaction_type = NULL,
  activity_type = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- search:

  Free-text search query.

- search_field:

  Field to restrict the search to. One of `"all"`, `"gene_symbol"`,
  `"compound_name"`, `"uniprot_id"`, `"inchikey"`, `"pubchem_cid"`, or
  `"chembl_id"`.

- search_mode:

  `"exact"` (case-insensitive equality) or `"fuzzy"` (substring match).

- source_db:

  Filter by source database (e.g. `"BindingDB"`).

- evidence_level:

  Filter by evidence level (integer 1-4 as string).

- evidence_label:

  Filter by evidence label.

- target_organism:

  Filter by target organism (e.g. `"Homo sapiens"`).

- interaction_type:

  Filter by interaction type.

- activity_type:

  Filter by activity type (e.g. `"IC50"`, `"Ki"`).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 100).

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of interaction records with attribute `"total"`.

## Examples

``` r
# \donttest{
search_target2np(search = "quercetin")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 15
#>    record_id source_db evidence_level evidence_label   compound_name pubchem_cid
#>        <int> <chr>              <int> <chr>            <chr>         <chr>      
#>  1      1459 HIT2                   2 Experimental bi… Isoquercetin  5280804    
#>  2      1460 HIT2                   2 Experimental bi… Isoquercetin  5280804    
#>  3      1461 HIT2                   2 Experimental bi… Isoquercetin  5280804    
#>  4      3112 HIT2                   2 Experimental bi… Quercetin     5280343    
#>  5      3113 HIT2                   2 Experimental bi… Quercetin     5280343    
#>  6      3114 HIT2                   2 Experimental bi… Quercetin     5280343    
#>  7      3115 HIT2                   2 Experimental bi… Quercetin     5280343    
#>  8      3116 HIT2                   2 Experimental bi… Quercetin     5280343    
#>  9      3117 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 10      3118 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 11      3119 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 12      3120 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 13      3121 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 14      3122 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 15      3123 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 16      3124 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 17      3125 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 18      3126 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 19      3127 HIT2                   2 Experimental bi… Quercetin     5280343    
#> 20      3128 HIT2                   2 Experimental bi… Quercetin     5280343    
#> # ℹ 9 more variables: gene_symbol <chr>, protein_name <chr>, uniprot_id <chr>,
#> #   target_organism <chr>, interaction_type <chr>, activity_type <chr>,
#> #   activity_value <lgl>, activity_units <chr>, unitcm_ingredient_id <int>
search_target2np(search = "TP53", search_field = "gene_symbol",
                 source_db = "BindingDB")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 4 × 15
#>   record_id source_db evidence_level evidence_label    compound_name pubchem_cid
#>       <int> <chr>              <int> <chr>             <chr>         <chr>      
#> 1     29484 BindingDB              5 Computational/Pa… US9403827, 8  90303398   
#> 2     53403 BindingDB              2 Experimental bin… CHEMBL3422267 101911084  
#> 3     53404 BindingDB              2 Experimental bin… CHEMBL3422268 118735492  
#> 4     99938 BindingDB              2 Experimental bin… CHEMBL4162051 133082032  
#> # ℹ 9 more variables: gene_symbol <chr>, protein_name <chr>, uniprot_id <chr>,
#> #   target_organism <chr>, interaction_type <chr>, activity_type <chr>,
#> #   activity_value <dbl>, activity_units <chr>, unitcm_ingredient_id <lgl>
# }
```
