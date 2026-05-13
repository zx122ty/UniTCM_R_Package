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

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
compounds with attribute `"total"`.

## Examples

``` r
# \donttest{
get_herb_compounds("UNITCM_H001")
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "herb_id"), msg =
#>   "Input should be a valid integer, unable to parse string as an integer")
# }
```
