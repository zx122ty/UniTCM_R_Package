# Convert gene identifiers (MIDAS)

Convert a mixed list of gene identifiers (symbols, Entrez IDs, Ensembl
IDs) to a standardized mapping.

## Usage

``` r
convert_gene_ids(identifiers)
```

## Arguments

- identifiers:

  Character vector of gene identifiers.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns including match status.

## Examples

``` r
if (FALSE) { # \dontrun{
convert_gene_ids(c("TP53", "7157", "ENSG00000141510"))
} # }
```
