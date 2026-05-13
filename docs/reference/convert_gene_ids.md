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

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns including match status.

## Examples

``` r
# \donttest{
convert_gene_ids(c("TP53", "7157", "ENSG00000141510"))
#> # A tibble: 3 × 11
#>   input       detected_type symbol ensembl_id entrez_id uniprot_id hgnc_id name 
#>   <chr>       <chr>         <chr>  <chr>      <chr>     <chr>      <chr>   <chr>
#> 1 TP53        symbol        TP53   ENSG00000… 7157      P04637     HGNC:1… tumo…
#> 2 7157        entrez        TP53   ENSG00000… 7157      P04637     HGNC:1… tumo…
#> 3 ENSG000001… ensembl       TP53   ENSG00000… 7157      P04637     HGNC:1… tumo…
#> # ℹ 3 more variables: status <chr>, match_type <chr>, alternatives <lgl>
# }
```
