# Search formulas in the Disease-Formula Atlas

Query the Disease-Formula Atlas with optional text search and ICD-11
disease classification filters. Multi-value parameters accept character
vectors and are collapsed to comma-separated strings internally.

## Usage

``` r
search_formulas(
  q = NULL,
  level1 = NULL,
  level2 = NULL,
  level3 = NULL,
  level4 = NULL,
  book_sources = NULL,
  origin_sources = NULL,
  dosage_forms = NULL,
  mapping_confidence = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Optional search query string.

- level1, level2, level3, level4:

  ICD-11 disease classification levels.

- book_sources:

  Book source filter (character vector).

- origin_sources:

  Origin source filter (character vector).

- dosage_forms:

  Dosage form filter (character vector).

- mapping_confidence:

  Mapping confidence filter (character vector).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 100).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of formulas with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_formulas(q = "insomnia")
search_formulas(level1 = "Neoplasms", mapping_confidence = "high")
} # }
```
