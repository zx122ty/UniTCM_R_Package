# Get analysis data for a transcriptome dataset

Retrieve data for a specific analysis module. Return type varies by
module.

## Usage

``` r
get_analysis_data(dataset_id, module, gene = NULL)
```

## Arguments

- dataset_id:

  The dataset ID.

- module:

  Analysis module name. One of: `"meta"`, `"expression"`, `"deg"`,
  `"go"`, `"kegg"`, `"gsea"`, `"ppi"`, `"immune"`, `"tf"`, `"pca"`,
  `"qc"`.

- gene:

  Optional gene filter (for expression module only).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
for tabular modules (deg, go, kegg, gsea, immune, tf), or a named list
for structured modules (meta, expression, ppi, pca, qc).

## Examples

``` r
if (FALSE) { # \dontrun{
get_analysis_data("TCMtrans00001", "deg")
get_analysis_data("TCMtrans00001", "expression", gene = "TP53")
} # }
```
