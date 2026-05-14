# Batch query Target2NP by identifier list

Look up interaction records for up to 50 gene symbols, UniProt IDs, or
Entrez gene IDs in one call.

## Usage

``` r
batch_target2np(
  identifiers,
  id_type = c("gene_symbol", "uniprot_id", "entrez_gene_id")
)
```

## Arguments

- identifiers:

  Character vector of identifiers (max 50).

- id_type:

  One of `"gene_symbol"` (default), `"uniprot_id"`, or
  `"entrez_gene_id"`.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
matching records with attributes `"total"`, `"queries_matched"`, and
`"queries_not_found"`.

## Examples

``` r
if (FALSE) { # \dontrun{
batch_target2np(c("TP53", "BRCA1", "EGFR"))
batch_target2np(c("P04637", "P38398"), id_type = "uniprot_id")
} # }
```
