# Perform GO and KEGG pathway enrichment via the Enrichr API

Submits a gene list to the [Enrichr](https://maayanlab.cloud/Enrichr/)
web service and retrieves enrichment results for the specified gene-set
libraries. This is a programmatic interface analogous to using the
Enrichr website.

## Usage

``` r
enrichr_enrichment(gene_list, gene_set_libraries = NULL, top_n = 10L)
```

## Arguments

- gene_list:

  Character vector of gene symbols.

- gene_set_libraries:

  Character vector of Enrichr library names, or `NULL` (the default) to
  use a standard set: `"GO_Biological_Process_2023"`,
  `"GO_Molecular_Function_2023"`, `"GO_Cellular_Component_2023"`,
  `"KEGG_2021_Human"`, `"WikiPathway_2021_Human"`.

- top_n:

  Maximum number of top terms to return per library. Default `10`.

## Value

A named list of
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
data frames, one per successfully queried library. Each tibble contains:

- Term:

  Enriched term name.

- Overlap:

  Gene overlap string (e.g. `"5/200"`).

- P_value:

  Nominal p-value.

- Adjusted_P:

  Adjusted p-value (FDR).

- Z_Score:

  Enrichment z-score.

- Combined_Score:

  Enrichr combined score.

- Genes:

  Comma-separated overlapping gene symbols.

## Examples

``` r
if (FALSE) { # \dontrun{
enrich <- enrichr_enrichment(c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF"))
names(enrich)
head(enrich[["KEGG_2021_Human"]])
} # }
```
