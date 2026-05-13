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
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "id"), msg = "Input
#>   should be a valid integer, unable to parse string as an integer")
# }
```
