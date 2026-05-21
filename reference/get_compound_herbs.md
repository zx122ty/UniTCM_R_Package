# Get herbs containing a compound

List herbs that contain a specific compound.

## Usage

``` r
get_compound_herbs(id, page = 1L, page_size = 20L, all_pages = FALSE)
```

## Arguments

- id:

  The UniTCM ingredient ID.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of herbs with attribute `"total"`.

## Examples

``` r
# \donttest{
get_compound_herbs("UNITCM_I00001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 9 × 3
#>   unitcm_herb_id herb_english_name          source     
#>            <int> <chr>                      <chr>      
#> 1          10504 Calamus gum;Dragon's blood TCMbank    
#> 2           9534 Colophony                  TCMbank    
#> 3           3158 Draconis Sanguis           book_batch1
#> 4          19479 Juniperus oxycedrus        book_batch2
#> 5           1289 Liquidambaris Resina       paper      
#> 6           1251 Myrrha                     paper      
#> 7          25227 Pinus massoniana           book_batch2
#> 8          24831 Pinus massoniana           book_batch2
#> 9           2300 Styrax                     paper      
# }
```
