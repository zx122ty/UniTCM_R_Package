# Query the STRING database for protein-protein interactions

Queries the [STRING database](https://string-db.org/) REST API to
retrieve a protein-protein interaction (PPI) network for a list of gene
symbols. Large gene lists are automatically split into batches to
respect API limits.

## Usage

``` r
query_string_ppi(
  gene_list,
  species = 9606L,
  score_threshold = 400L,
  batch_size = 500L
)
```

## Arguments

- gene_list:

  Character vector of gene symbols (e.g. `c("TP53", "BRCA1")`).

- species:

  NCBI taxonomy ID. Default `9606` (Homo sapiens). Use `10090` for
  mouse, `10116` for rat.

- score_threshold:

  Minimum combined STRING score, in the 0–1000 range. Default `400`
  (medium confidence).

- batch_size:

  Maximum number of genes per API request. Default `500`.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns:

- gene1, gene2:

  Preferred gene symbols of the interaction partners.

- score:

  Combined STRING score (0–1000).

## Examples

``` r
if (FALSE) { # \dontrun{
ppi <- query_string_ppi(c("TP53", "BRCA1", "EGFR", "VEGFA", "TNF"))
head(ppi)
} # }
```
