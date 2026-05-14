# Multi-source summary for a Target2NP query

Combine experimental records, DrugCLIP predictions, and SEA predictions
for one query, returning source counts, target/compound overlap sets,
confidence distributions, cross-validated compound-target pairs, and an
interpretive suggestion string.

## Usage

``` r
target2np_multi_source_summary(
  search = NULL,
  sources = c("experimental", "drugclip", "sea"),
  search_field = c("all", "gene_symbol", "compound_name", "uniprot_id", "inchikey",
    "pubchem_cid", "chembl_id"),
  search_mode = c("exact", "fuzzy")
)
```

## Arguments

- search:

  Free-text search query.

- sources:

  Character vector of sources to query. Subset of
  `c("experimental", "drugclip", "sea")` (default: all three).

- search_field:

  One of `"all"`, `"gene_symbol"`, `"compound_name"`, `"uniprot_id"`,
  `"inchikey"`, `"pubchem_cid"`, `"chembl_id"`.

- search_mode:

  `"exact"` or `"fuzzy"`.

## Value

A named list with fields `source_counts`, `target_overlap`,
`compound_overlap`, `confidence_distribution`, `cross_validated`, and
`suggestion_text`.

## Examples

``` r
if (FALSE) { # \dontrun{
summary <- target2np_multi_source_summary(
  search = "TP53", search_field = "gene_symbol"
)
summary$source_counts
summary$suggestion_text
} # }
```
