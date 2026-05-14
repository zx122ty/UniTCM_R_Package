# Query disease-to-gene associations (MIDAS)

Given a disease query, find associated genes across multiple evidence
sources.

## Usage

``` r
query_disease_genes(
  disease_query,
  disease_id_type = "name",
  sources = NULL,
  min_sources = 1L,
  scoring_method = "max",
  page = 1L,
  page_size = 20L
)
```

## Arguments

- disease_query:

  Disease name or ID.

- disease_id_type:

  ID type: `"name"` (default) or `"icd11"`.

- sources:

  Character vector of source databases (or `NULL` for all).

- min_sources:

  Minimum supporting sources (default 1).

- scoring_method:

  Scoring method: `"max"` (default) or `"mean"`.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
disease-gene associations with attribute `"matched_diseases"`.

## Examples

``` r
if (FALSE) { # \dontrun{
query_disease_genes("breast cancer")
} # }
```
