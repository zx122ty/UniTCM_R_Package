# Compare gene-disease sources (MIDAS)

Compare how different evidence sources cover a gene list, producing
Venn-diagram-ready set data.

## Usage

``` r
query_source_comparison(
  gene_list,
  sources = NULL,
  mode = c("union", "intersection")
)
```

## Arguments

- gene_list:

  Character vector of gene identifiers.

- sources:

  Character vector of source databases (or `NULL`).

- mode:

  Comparison mode: `"union"` (default) or `"intersection"`.

## Value

A named list with elements: `$mode`, `$sources`, `$sets` (named list of
gene vectors), `$intersections`, `$exclusives`, `$genes_used`.

## Examples

``` r
# \donttest{
query_source_comparison(c("TP53", "BRCA1"), mode = "union")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "missing", loc = list("body", "body", "sources"), msg =
#>   "Field required")
# }
```
