# Disease enrichment analysis (MIDAS)

Perform Fisher's exact test enrichment analysis to identify diseases
significantly associated with a gene list.

## Usage

``` r
query_disease_enrichment(
  gene_list,
  gene_id_type = "symbol",
  sources = NULL,
  min_sources = 1L,
  background_gene_count = 20000L,
  p_value_cutoff = 0.05,
  correction_method = "fdr",
  min_hit_count = 2L,
  page = 1L,
  page_size = 20L
)
```

## Arguments

- gene_list:

  Character vector of gene identifiers.

- gene_id_type:

  ID type: `"symbol"` (default), `"entrez"`, or `"ensembl"`.

- sources:

  Character vector of source databases (or `NULL`).

- min_sources:

  Minimum supporting sources (default 1).

- background_gene_count:

  Background gene count (default 20000).

- p_value_cutoff:

  P-value significance cutoff (default 0.05).

- correction_method:

  P-value correction: `"fdr"` (default), `"bonferroni"`, `"holm"`, or
  `"none"`.

- min_hit_count:

  Minimum gene hits per disease (default 2).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of enrichment results with attributes `"total_significant"`,
`"total_tested"`, and `"input_gene_count"`.

## Examples

``` r
if (FALSE) { # \dontrun{
query_disease_enrichment(c("TP53", "BRCA1", "EGFR", "VEGFA"))
} # }
```
