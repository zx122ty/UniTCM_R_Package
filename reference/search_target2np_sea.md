# Search SEA (ChEMBL similarity) predicted compound-target interactions

Query SEA-style predictions derived from ChEMBL similarity scoring, with
optional adjusted p-value filtering.

## Usage

``` r
search_target2np_sea(
  search = NULL,
  search_field = c("all", "gene_symbol", "compound_name", "uniprot_id", "inchikey"),
  search_mode = c("exact", "fuzzy"),
  max_pvalue = NULL,
  confidence = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- search:

  Free-text search.

- search_field:

  One of `"all"`, `"gene_symbol"`, `"compound_name"`, `"uniprot_id"`, or
  `"inchikey"`.

- search_mode:

  `"exact"` or `"fuzzy"`.

- max_pvalue:

  Maximum adjusted p-value.

- confidence:

  One of `"high"` (adj. p \< 0.01), `"medium"` (0.01-0.05), `"low"` (\>=
  0.05).

- page, page_size:

  Pagination.

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of SEA predictions with attribute `"total"`.

## Examples

``` r
# \donttest{
search_target2np_sea(search = "quercetin", confidence = "high")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 16
#>        id compound_id compound_name             smiles inchikey target_chembl_id
#>     <int>       <int> <chr>                     <lgl>  <lgl>    <chr>           
#>  1 121863       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL4878      
#>  2 121864       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL5393      
#>  3 121865       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL215       
#>  4 121866       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL2231      
#>  5 121867       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL4302      
#>  6 121868       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL3356      
#>  7 121869       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL1951      
#>  8 121870       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL1929      
#>  9 121871       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL4523488   
#> 10 121872       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL1865      
#> 11 121873       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL3242      
#> 12 121874       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL2326      
#> 13 121875       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL3885525   
#> 14 121876       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL1900      
#> 15 121877       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL3004      
#> 16 121878       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL3729      
#> 17 121879       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL1974      
#> 18 121880       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL205       
#> 19 121881       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL242       
#> 20 121882       40270 3',4'-dimethoxy quercetin NA     NA       CHEMBL4822      
#> # ℹ 10 more variables: target_pref_name <chr>, uniprot_id <chr>,
#> #   gene_symbol <chr>, sea_pvalue <dbl>, pvalue_adjusted <dbl>,
#> #   sea_zscore <dbl>, max_tanimoto <dbl>, n_similar_ligands <int>,
#> #   confidence_level <chr>, unitcm_ingredient_id <int>
# }
```
