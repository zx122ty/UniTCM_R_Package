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
# \donttest{
get_analysis_data("TCMtrans00001", "deg")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 21,186 × 11
#>    dataset_id    gene_symbol   log2fc   pvalue    padj avg_expression regulation
#>    <chr>         <chr>          <dbl>    <dbl>   <dbl>          <dbl> <chr>     
#>  1 TCMtrans00001 A1BG-AS1     0.0952   5.17e-1 0.856             6.10 ns        
#>  2 TCMtrans00001 A1CF        -0.269    9.95e-2 0.477             8.16 ns        
#>  3 TCMtrans00001 A2M          1.09     3.07e-6 0.00138           7.15 up        
#>  4 TCMtrans00001 A2ML1        0.0272   8.41e-1 0.968             5.82 ns        
#>  5 TCMtrans00001 A4GALT       0.0509   6.70e-1 0.916             6.09 ns        
#>  6 TCMtrans00001 A4GNT       -0.146    4.85e-1 0.843             6.59 ns        
#>  7 TCMtrans00001 AAAS        -0.0340   8.08e-1 0.960             8.63 ns        
#>  8 TCMtrans00001 AACS         0.162    2.19e-1 0.650             9.09 ns        
#>  9 TCMtrans00001 AACSP1       0.116    3.54e-1 0.767             6.65 ns        
#> 10 TCMtrans00001 AADAC        0.00252  9.83e-1 0.996             6.13 ns        
#> # ℹ 21,176 more rows
#> # ℹ 4 more variables: deg_method <chr>, threshold_method <chr>,
#> #   lfc_cutoff_used <int>, padj_cutoff_used <dbl>
get_analysis_data("TCMtrans00001", "expression", gene = "TP53")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $data
#>    Gene_Symbol GSM2674900 GSM2674901 GSM2674902 GSM2674903
#> 1         TP53   6.887469   6.671971   6.790053   6.878225
#> 2     TP53AIP1   6.216912   6.161573   6.284461   6.303154
#> 3      TP53BP1   9.382983   9.018228   9.315843   9.405297
#> 4      TP53BP2   8.663844   8.750332   8.297279   8.490237
#> 5      TP53I11   6.927735   6.814678   7.004845   6.726881
#> 6      TP53I13  11.498844  11.420389  11.472003  11.506273
#> 7       TP53I3   6.889434   6.936535   6.923999   7.285657
#> 8     TP53INP1   8.030120   8.523623   8.898801   8.652514
#> 9     TP53INP2   8.350801   8.286349   8.776619   8.920531
#> 10      TP53RK   8.368675   8.383222   8.656528   8.643688
#> 11     TP53TG1   8.901293   9.194195   8.825908   8.924855
#> 12     TP53TG3   7.223258   7.357909   7.742752   7.743061
#> 13    TP53TG3C   6.516537   6.314740   6.436735   6.576379
#> 14    TP53TG3D   7.399409   7.258216   7.789119   7.713908
#> 15   TP53TG3HP   6.177941   5.923671   6.185055   6.187122
#> 16     TP53TG5   6.309678   6.278441   6.232825   6.264123
#> 
#> $total_rows
#> [1] 16
#> 
#> $returned_rows
#> [1] 16
#> 
# }
```
