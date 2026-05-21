# Get compounds for a herb

List chemical compounds (ingredients) associated with a specific herb.

## Usage

``` r
get_herb_compounds(herb_id, page = 1L, page_size = 20L, all_pages = FALSE)
```

## Arguments

- herb_id:

  The UniTCM herb ID.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of compounds with attribute `"total"`.

## Examples

``` r
# \donttest{
get_herb_compounds("UNITCM_H001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 12 × 3
#>    unitcm_ingredient_id component_name                       source
#>                   <int> <chr>                                <chr> 
#>  1                36597 14-deacetyl-14-isobutyrylajadine     paper 
#>  2                36596 14-deacetyl-14-isobutyrylnudicauline paper 
#>  3                36599 14-deacetylajadine                   paper 
#>  4                36598 14-deacetylnudicauline               paper 
#>  5                36595 14-demethyltuguaconitine             paper 
#>  6                   77 Ajacine                              paper 
#>  7                13519 Delbonine                            paper 
#>  8                13524 Delcosine                            paper 
#>  9                13553 Deltatsine                           paper 
#> 10                 9671 Methyllycaconitine                   paper 
#> 11                 1843 Nudicauline                          paper 
#> 12                36600 ajadine                              paper 
# }
```
