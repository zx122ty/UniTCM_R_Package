# Search TCMomics datasets

Query the TCMomics multi-omics database with optional text search and
faceted filters.

## Usage

``` r
search_datasets(
  q = NULL,
  tcm = NULL,
  omics = NULL,
  source = NULL,
  organism = NULL,
  tissue = NULL,
  disease = NULL,
  repo = NULL,
  year_min = NULL,
  year_max = NULL,
  sort = NULL,
  search_mode = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Optional search query string.

- tcm:

  TCM classification filter.

- omics:

  Omics type filter.

- source:

  Source type filter.

- organism:

  Organism filter.

- tissue:

  Tissue filter.

- disease:

  Disease filter.

- repo:

  Repository filter.

- year_min:

  Minimum publication year.

- year_max:

  Maximum publication year.

- sort:

  Sort field: `"relevance"`, `"date_desc"`, `"views_desc"`, or
  `"downloads_desc"`.

- search_mode:

  Search mode: `"fuzzy"` (default) or `"exact"`.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
datasets with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_datasets(q = "ginseng", omics = "Transcriptomics")
} # }
```
