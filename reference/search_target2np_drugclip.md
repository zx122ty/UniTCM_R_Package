# Search DrugCLIP predicted compound-target interactions

Query DrugCLIP deep-learning predictions, with optional confidence
filtering by predicted score.

## Usage

``` r
search_target2np_drugclip(
  search = NULL,
  search_field = c("all", "gene_symbol", "compound_name", "inchikey"),
  search_mode = c("exact", "fuzzy"),
  min_score = NULL,
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

  One of `"all"`, `"gene_symbol"`, `"compound_name"`, or `"inchikey"`.

- search_mode:

  `"exact"` or `"fuzzy"`.

- min_score:

  Minimum DrugCLIP score (0-1).

- confidence:

  One of `"high"` (\>= 0.8), `"medium"` (0.5-0.8), `"low"` (\< 0.5).

- page, page_size:

  Pagination.

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of DrugCLIP predictions with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_target2np_drugclip(search = "quercetin", confidence = "high")
} # }
```
