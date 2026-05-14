# Plot enrichment results

Create a dot plot or bar plot from enrichment analysis results (e.g.
from
[`query_disease_enrichment()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_disease_enrichment.md)).

## Usage

``` r
plot_enrichment(
  enrichment_result,
  type = c("dotplot", "barplot"),
  top_n = 20L,
  name_col = NULL,
  pvalue_col = NULL,
  count_col = NULL
)
```

## Arguments

- enrichment_result:

  A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html)
  from an enrichment analysis. Must contain columns mappable to term
  name and p-value.

- type:

  Plot type: `"dotplot"` (default) or `"barplot"`.

- top_n:

  Number of top terms to show (default 20).

- name_col:

  Column name for term labels (auto-detected if `NULL`).

- pvalue_col:

  Column name for p-values (auto-detected if `NULL`).

- count_col:

  Column name for gene counts (auto-detected if `NULL`).

## Value

A `ggplot` object.

## Examples

``` r
if (FALSE) { # \dontrun{
enrich <- query_disease_enrichment(c("TP53", "BRCA1", "EGFR"))
plot_enrichment(enrich)
} # }
```
