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

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
herbs with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
get_compound_herbs("UNITCM_I00001")
} # }
```
