# Search terms molecular mechanisms

Query the Terms Molecular Mechanisms database with optional filters.

## Usage

``` r
search_mechanisms(
  search = NULL,
  category = NULL,
  omics_type = NULL,
  evidence_level = NULL,
  confidence_level = NULL,
  study_type = NULL,
  species = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- search:

  Optional text search query.

- category:

  Category filter.

- omics_type:

  Omics type filter.

- evidence_level:

  Evidence level filter.

- confidence_level:

  Confidence level filter.

- study_type:

  Study type filter.

- species:

  Species filter.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
mechanism terms with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_mechanisms(search = "Qi deficiency")
} # }
```
