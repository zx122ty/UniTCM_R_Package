# Search TCM bilingual corpus terms

Query the TCM Bilingual Corpus with optional text search and filters.

## Usage

``` r
search_terms(
  q = NULL,
  sources = NULL,
  category = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Optional search query string.

- sources:

  Data source filter (character vector, comma-collapsed).

- category:

  Category filter (character vector, comma-collapsed).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 100).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
terms with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_terms(q = "ginseng")
} # }
```
