# Search SEA (ChEMBL similarity) predicted compound-target interactions

Query SEA-style predictions derived from ChEMBL similarity scoring, with
optional adjusted p-value filtering.

## Usage

``` r
search_target2np_sea(
  search = NULL,
  search_field = c("all", "gene_symbol", "compound_name", "uniprot_id", "inchikey"),
  search_mode = c("exact", "fuzzy"),
  max_pvalue = NULL,
  confidence = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- search:

  Free-text search.

- search_field:

  One of `"all"`, `"gene_symbol"`, `"compound_name"`, `"uniprot_id"`, or
  `"inchikey"`.

- search_mode:

  `"exact"` or `"fuzzy"`.

- max_pvalue:

  Maximum adjusted p-value.

- confidence:

  One of `"high"` (adj. p \< 0.01), `"medium"` (0.01-0.05), `"low"` (\>=
  0.05).

- page, page_size:

  Pagination.

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of SEA predictions with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_target2np_sea(search = "quercetin", confidence = "high")
} # }
```
