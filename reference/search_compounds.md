# Search compounds in the Ingredient Explorer

Query the UniTCM Ingredient Explorer with optional text search and
physicochemical property filters.

## Usage

``` r
search_compounds(
  q = NULL,
  mw_min = NULL,
  mw_max = NULL,
  clogp_min = NULL,
  clogp_max = NULL,
  tpsa_min = NULL,
  tpsa_max = NULL,
  qed_min = NULL,
  qed_max = NULL,
  ring_count_min = NULL,
  ring_count_max = NULL,
  lipinski = NULL,
  is_drug = NULL,
  sort = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Search query (name, SMILES, formula, or CAS number).

- mw_min, mw_max:

  Molecular weight range.

- clogp_min, clogp_max:

  CLogP range.

- tpsa_min, tpsa_max:

  Topological polar surface area range.

- qed_min, qed_max:

  QED score range.

- ring_count_min, ring_count_max:

  Ring count range.

- lipinski:

  Lipinski rule filter (character vector, comma-collapsed).

- is_drug:

  Approved drug filter (logical or `NULL`).

- sort:

  Sort field (e.g. `"mw"`, `"-mw"`).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 200).

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of compounds with attribute `"total"`.

## Examples

``` r
# \donttest{
search_compounds(q = "quercetin")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 13
#>    unitcm_ingredient_id component_name          formula    mw  clogp  tpsa   hbd
#>                   <int> <chr>                   <chr>   <dbl>  <dbl> <dbl> <int>
#>  1                 2089 "Quercetin"             C15H10…  302.  1.99   131.     5
#>  2                 2090 "Quercetin 3-methyl et… C16H12…  316.  2.29   120.     4
#>  3                 2900 "3,3'-Dimethylquerceti… C17H14…  330.  2.59   109.     3
#>  4                 3232 "3-Methylquercetin"     NA       316.  2.29   120.     4
#>  5                 4492 "Quercetin 3-O-alpha-L… NA        NA  NA       NA     NA
#>  6                 4493 "Quercetin 4-O-beta-D-… NA        NA  NA       NA     NA
#>  7                 4494 "Quercetin-3-O-alpha-r… NA        NA  NA       NA     NA
#>  8                 5580 "Quercetin 3-O-(2'',6'… NA        NA  NA       NA     NA
#>  9                 5581 "Quercetin-3-O-beta-D-… NA        NA  NA       NA     NA
#> 10                 6051 "Quercetin-3-O-alpha-L… NA        NA  NA       NA     NA
#> 11                 6052 "Quercetin-3-O-(2'',6'… NA        NA  NA       NA     NA
#> 12                 6053 "Quercetin-3,7-digluco… C27H30…  627. -3.07   290.    11
#> 13                 6054 "Quercetin-3-O-(2\",6\… NA        NA  NA       NA     NA
#> 14                 6055 "Quercetin-3-O-[(6-O-f… NA        NA  NA       NA     NA
#> 15                 6056 "Quercetin-3-O-(6\"-ga… NA        NA  NA       NA     NA
#> 16                 6057 "Quercetin-4'-O-beta-D… NA        NA  NA       NA     NA
#> 17                 6058 "Quercetin-3-O-[beta-D… NA        NA  NA       NA     NA
#> 18                 6059 "Quercetin-3-O-[beta-D… NA        NA  NA       NA     NA
#> 19                 6060 "Quercetin-4'-glucosid… NA        NA  NA       NA     NA
#> 20                 6061 "Quercetin-3-O-glucuro… C21H18…  478. -0.447  228.     8
#> # ℹ 6 more variables: qed_score <dbl>, lipinski_violations <int>,
#> #   is_approved_drug <lgl>, bioactivity_target_count <int>,
#> #   smiles_canonical <chr>, cas_number <lgl>
search_compounds(mw_min = 200, mw_max = 500, lipinski = "pass")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 13
#>    unitcm_ingredient_id component_name          formula    mw  clogp  tpsa   hbd
#>                   <int> <chr>                   <chr>   <dbl>  <dbl> <dbl> <int>
#>  1                 2089 "Quercetin"             C15H10…  302.  1.99   131.     5
#>  2                 2090 "Quercetin 3-methyl et… C16H12…  316.  2.29   120.     4
#>  3                 2900 "3,3'-Dimethylquerceti… C17H14…  330.  2.59   109.     3
#>  4                 3232 "3-Methylquercetin"     NA       316.  2.29   120.     4
#>  5                 4492 "Quercetin 3-O-alpha-L… NA        NA  NA       NA     NA
#>  6                 4493 "Quercetin 4-O-beta-D-… NA        NA  NA       NA     NA
#>  7                 4494 "Quercetin-3-O-alpha-r… NA        NA  NA       NA     NA
#>  8                 5580 "Quercetin 3-O-(2'',6'… NA        NA  NA       NA     NA
#>  9                 5581 "Quercetin-3-O-beta-D-… NA        NA  NA       NA     NA
#> 10                 6051 "Quercetin-3-O-alpha-L… NA        NA  NA       NA     NA
#> 11                 6052 "Quercetin-3-O-(2'',6'… NA        NA  NA       NA     NA
#> 12                 6053 "Quercetin-3,7-digluco… C27H30…  627. -3.07   290.    11
#> 13                 6054 "Quercetin-3-O-(2\",6\… NA        NA  NA       NA     NA
#> 14                 6055 "Quercetin-3-O-[(6-O-f… NA        NA  NA       NA     NA
#> 15                 6056 "Quercetin-3-O-(6\"-ga… NA        NA  NA       NA     NA
#> 16                 6057 "Quercetin-4'-O-beta-D… NA        NA  NA       NA     NA
#> 17                 6058 "Quercetin-3-O-[beta-D… NA        NA  NA       NA     NA
#> 18                 6059 "Quercetin-3-O-[beta-D… NA        NA  NA       NA     NA
#> 19                 6060 "Quercetin-4'-glucosid… NA        NA  NA       NA     NA
#> 20                 6061 "Quercetin-3-O-glucuro… C21H18…  478. -0.447  228.     8
#> # ℹ 6 more variables: qed_score <dbl>, lipinski_violations <int>,
#> #   is_approved_drug <lgl>, bioactivity_target_count <int>,
#> #   smiles_canonical <chr>, cas_number <lgl>
# }
```
