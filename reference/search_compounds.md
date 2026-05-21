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
#>    unitcm_ingredient_id component_name formula    mw clogp  tpsa   hbd qed_score
#>                   <int> <chr>          <chr>   <dbl> <dbl> <dbl> <int>     <dbl>
#>  1                    1 Abietic acid   C20H30…  302.  5.21  37.3     1     0.760
#>  2                    4 Abscisic acid  C15H20…  264.  2.25  74.6     2     0.605
#>  3                    5 Absinthin      C30H40…  497.  3.80  93.1     2     0.392
#>  4                    6 Abyssinone I   C20H18…  322.  4.28  55.8     1     0.851
#>  5                    7 Abyssinone V   C25H28…  408.  5.53  87.0     3     0.567
#>  6                    8 Abyssinone VI  C25H28…  392.  5.72  77.8     3     0.32 
#>  7                    9 Acacetin       C16H12…  284.  2.88  79.9     2     0.756
#>  8                   10 Acalyphin      C14H20…  360. -3.61 173.      5     0.337
#>  9                   12 Acanthamolide  C19H25…  347.  1.45  92.7     2     0.349
#> 10                   13 (-)-Acanthoca… C17H12…  328.  1.86  75.6     1     0.791
#> 11                   14 Acanthoglabro… C23H30…  434.  2.20 116.      1     0.230
#> 12                   16 Acantholide    C19H24…  348.  1.88  89.9     1     0.362
#> 13                   19 Acanthospermo… C20H26…  362.  2.53  78.9     0     0.331
#> 14                   20 Acerosin       C18H16…  360.  2.60 119.      3     0.650
#> 15                   25 1'-Acetoxycha… C13H14…  234.  2.40  52.6     0     0.456
#> 16                   26 1'-Acetoxyeug… C14H16…  264.  2.41  61.8     0     0.464
#> 17                   28 1-Acetoxypino… C22H24…  416.  2.88 104.      2     0.718
#> 18                   32 O-Acetylcypho… C20H28…  360.  3.41  73.4     1     0.519
#> 19                   35 3-Acetylnerbo… C19H23…  361.  1.34  77.5     1     0.797
#> 20                   37 6-Acetylpicro… C24H28…  460.  2.52 122.      0     0.379
#> # ℹ 5 more variables: lipinski_violations <int>, is_approved_drug <lgl>,
#> #   bioactivity_target_count <int>, smiles_canonical <chr>, cas_number <chr>
# }
```
