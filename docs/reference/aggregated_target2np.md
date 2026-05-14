# Aggregated Target2NP view across data sources

Return compound-target pairs (keyed by InChIKey + UniProt ID) supported
by interaction records in at least `min_sources` source databases.
Optionally extends each pair with DrugCLIP / SEA prediction support.

## Usage

``` r
aggregated_target2np(
  search = NULL,
  target_organism = NULL,
  min_sources = 2L,
  include_predictions = FALSE,
  page = 1L,
  page_size = 20L
)
```

## Arguments

- search:

  Free-text search query.

- target_organism:

  Optional target organism filter.

- min_sources:

  Minimum number of source databases supporting the pair (1-5, default
  2).

- include_predictions:

  If `TRUE`, also count DrugCLIP and SEA predictions as additional
  supporting sources.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 50).

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
aggregated pairs with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
aggregated_target2np(search = "quercetin")
aggregated_target2np(search = "TP53", min_sources = 3,
                     include_predictions = TRUE)
} # }
```
