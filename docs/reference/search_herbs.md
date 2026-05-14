# Search herbs in the Herb Explorer

Query the UniTCM Herb Explorer with optional text search and faceted
filters. Multi-value filter parameters accept character vectors and are
collapsed to semicolon-separated strings internally.

## Usage

``` r
search_herbs(
  q = NULL,
  therapeutic_en = NULL,
  therapeutic_cn = NULL,
  family = NULL,
  toxicity = NULL,
  source = NULL,
  flavors = NULL,
  properties = NULL,
  meridians = NULL,
  medicinal_part = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Optional search query string.

- therapeutic_en:

  English therapeutic classification filter (character vector).

- therapeutic_cn:

  Chinese therapeutic classification filter (character vector).

- family:

  Botanical family filter (character vector).

- toxicity:

  Toxicity level filter (character vector).

- source:

  Data source filter (character vector).

- flavors:

  Flavor filter (character vector).

- properties:

  Property filter (character vector).

- meridians:

  Meridian tropism filter (character vector).

- medicinal_part:

  Medicinal part filter (character vector).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 200).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
herbs with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_herbs(q = "ginseng")
search_herbs(flavors = c("sweet", "bitter"), page_size = 50)
} # }
```
