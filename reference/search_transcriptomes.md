# Search transcriptome datasets

Query the TCM Transcriptome Hub. This endpoint uses Style-B pagination
(`count`/`results` instead of `total`/`items`).

## Usage

``` r
search_transcriptomes(
  search = NULL,
  tcm_classification = NULL,
  organism = NULL,
  model_type = NULL,
  experiment_type = NULL,
  disease_classification = NULL,
  cell_line = NULL,
  comparison_type = NULL,
  confidence = NULL,
  sequence_type = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- search:

  Optional text search query.

- tcm_classification:

  TCM classification filter.

- organism:

  Organism filter.

- model_type:

  Model type filter.

- experiment_type:

  Experiment type filter.

- disease_classification:

  Disease classification filter.

- cell_line:

  Cell line filter.

- comparison_type:

  Comparison type filter.

- confidence:

  Confidence filter.

- sequence_type:

  Sequence type filter.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of datasets with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_transcriptomes(search = "ginseng")
} # }
```
