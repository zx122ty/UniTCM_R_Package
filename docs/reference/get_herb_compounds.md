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
if (FALSE) { # \dontrun{
get_herb_compounds("UNITCM_H001")
} # }
```
