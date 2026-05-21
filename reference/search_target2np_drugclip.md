# Search DrugCLIP predicted compound-target interactions

Query DrugCLIP deep-learning predictions, with optional confidence
filtering by predicted score.

## Usage

``` r
search_target2np_drugclip(
  search = NULL,
  search_field = c("all", "gene_symbol", "compound_name", "inchikey"),
  search_mode = c("exact", "fuzzy"),
  min_score = NULL,
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

  One of `"all"`, `"gene_symbol"`, `"compound_name"`, or `"inchikey"`.

- search_mode:

  `"exact"` or `"fuzzy"`.

- min_score:

  Minimum DrugCLIP score (0-1).

- confidence:

  One of `"high"` (\>= 0.8), `"medium"` (0.5-0.8), `"low"` (\< 0.5).

- page, page_size:

  Pagination.

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of DrugCLIP predictions with attribute `"total"`.

## Examples

``` r
# \donttest{
search_target2np_drugclip(search = "quercetin", confidence = "high")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 11
#>        id compound_id compound_name  smiles inchikey target_id gene_symbol score
#>     <int>       <int> <chr>          <chr>  <chr>    <chr>     <chr>       <dbl>
#>  1 516701       66534 quercetin 3-O… CC1OC… SHRUKDV… Q5KSL6    DGKK         4.67
#>  2 516702       66534 quercetin 3-O… CC1OC… SHRUKDV… Q68DK2    ZFYVE26      4.66
#>  3 516703       66534 quercetin 3-O… CC1OC… SHRUKDV… P33527    ABCC1        4.54
#>  4 516704       66534 quercetin 3-O… CC1OC… SHRUKDV… Q9UKK3    PARP4        4.38
#>  5 516705       66534 quercetin 3-O… CC1OC… SHRUKDV… O94823    ATP10B       4.38
#>  6 516706       66534 quercetin 3-O… CC1OC… SHRUKDV… O43592    XPOT         4.36
#>  7 516707       66534 quercetin 3-O… CC1OC… SHRUKDV… Q8N4C6    NIN          4.35
#>  8 516708       66534 quercetin 3-O… CC1OC… SHRUKDV… Q15858    SCN9A        4.33
#>  9 516709       66534 quercetin 3-O… CC1OC… SHRUKDV… O15439    ABCC4        4.31
#> 10 516710       66534 quercetin 3-O… CC1OC… SHRUKDV… Q9Y5Y9    SCN10A       4.30
#> 11 516711       66534 quercetin 3-O… CC1OC… SHRUKDV… Q96GE4    CEP95        4.29
#> 12 516712       66534 quercetin 3-O… CC1OC… SHRUKDV… Q96AA8    JAKMIP2      4.27
#> 13 516713       66534 quercetin 3-O… CC1OC… SHRUKDV… O95602    POLR1A       4.25
#> 14 516714       66534 quercetin 3-O… CC1OC… SHRUKDV… O60706    ABCC9        4.25
#> 15 516715       66534 quercetin 3-O… CC1OC… SHRUKDV… P05023    ATP1A1       4.25
#> 16 580101       67911 quercetin 3-O… COc1c… HUHCPMK… P33527    ABCC1        4.24
#> 17 608001       47827 Quercetin-3-O… CC1OC… LSMKTLJ… Q68DK2    ZFYVE26      4.23
#> 18 516716       66534 quercetin 3-O… CC1OC… SHRUKDV… Q9NUD7    C20orf96     4.23
#> 19 516717       66534 quercetin 3-O… CC1OC… SHRUKDV… Q8TB69    ZNF519       4.23
#> 20 516718       66534 quercetin 3-O… CC1OC… SHRUKDV… Q14524    SCN5A        4.23
#> # ℹ 3 more variables: pocket_id <int>, confidence_level <chr>,
#> #   unitcm_ingredient_id <int>
# }
```
