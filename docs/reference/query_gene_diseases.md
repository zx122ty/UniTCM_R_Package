# Query gene-to-disease associations (MIDAS)

Given a list of gene symbols or IDs, find associated diseases across
multiple evidence sources.

## Usage

``` r
query_gene_diseases(
  gene_list,
  gene_id_type = "symbol",
  sources = NULL,
  min_sources = 1L,
  min_score = 0,
  evidence_types = NULL,
  scoring_method = "max",
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

  Character vector of source databases to query (or `NULL` for all).

- min_sources:

  Minimum number of sources supporting an association (default 1).

- min_score:

  Minimum association score (default 0).

- evidence_types:

  Character vector of evidence types to filter by.

- scoring_method:

  Scoring method: `"max"` (default) or `"mean"`.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
gene-disease associations with attribute `"gene_mapping"` containing the
gene ID resolution mapping.

## Examples

``` r
if (FALSE) { # \dontrun{
query_gene_diseases(c("TP53", "BRCA1"))
} # }
```
