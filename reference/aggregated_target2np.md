# Aggregated Target2NP view across data sources

Return compound-target pairs (keyed by InChIKey + UniProt ID) supported
by interaction records in at least `min_sources` source databases.
Optionally extends each pair with DrugCLIP / SEA prediction support.

## Usage

``` r
aggregated_target2np(
  search = NULL,
  target_organism = NULL,
  min_sources = 2L,
  include_predictions = FALSE,
  page = 1L,
  page_size = 20L
)
```

## Arguments

- search:

  Free-text search query.

- target_organism:

  Optional target organism filter.

- min_sources:

  Minimum number of source databases supporting the pair (1-5, default
  2).

- include_predictions:

  If `TRUE`, also count DrugCLIP and SEA predictions as additional
  supporting sources.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 50).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of aggregated pairs with attribute `"total"`.

## Examples

``` r
# \donttest{
aggregated_target2np(search = "quercetin")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 10
#>    inchikey       uniprot_id compound_name gene_symbol protein_name source_count
#>    <chr>          <chr>      <chr>         <chr>       <chr>               <int>
#>  1 LUJAXSNNYBCFE… Q9NPH5     3',4',5-trih… NOX4        NADPH oxida…            2
#>  2 OVSQVDMCBVZWG… P18031     2-(3,4-dihyd… PTPN1       Tyrosine-pr…            2
#>  3 REFJWTPEDVJJI… O15296     2-(3,4-dihyd… ALOX15B     Polyunsatur…            2
#>  4 REFJWTPEDVJJI… O15438     2-(3,4-dihyd… ABCC3       ATP-binding…            2
#>  5 REFJWTPEDVJJI… O15439     2-(3,4-dihyd… ABCC4       ATP-binding…            2
#>  6 REFJWTPEDVJJI… O43451     2-(3,4-dihyd… MGAM        Maltase-glu…            2
#>  7 REFJWTPEDVJJI… O43570     2-(3,4-dihyd… CA12        Carbonic an…            2
#>  8 REFJWTPEDVJJI… O60285     2-(3,4-dihyd… NUAK1       NUAK family…            2
#>  9 REFJWTPEDVJJI… O60341     2-(3,4-dihyd… KDM1A       Lysine-spec…            2
#> 10 REFJWTPEDVJJI… O94956     2-(3,4-dihyd… SLCO2B1     Solute carr…            2
#> 11 REFJWTPEDVJJI… O95342     2-(3,4-dihyd… ABCB11      Bile salt e…            2
#> 12 REFJWTPEDVJJI… P00390     2-(3,4-dihyd… GSR         Glutathione…            2
#> 13 REFJWTPEDVJJI… P00533     2-(3,4-dihyd… EGFR        Epidermal g…            2
#> 14 REFJWTPEDVJJI… P00734     2-(3,4-dihyd… F2          Prothrombin             2
#> 15 REFJWTPEDVJJI… P00749     2-(3,4-dihyd… PLAU        Urokinase-t…            2
#> 16 REFJWTPEDVJJI… P00915     2-(3,4-dihyd… CA1         Carbonic an…            2
#> 17 REFJWTPEDVJJI… P00918     2-(3,4-dihyd… CA2         Carbonic an…            2
#> 18 REFJWTPEDVJJI… P03956     2-(3,4-dihyd… MMP1        Interstitia…            2
#> 19 REFJWTPEDVJJI… P04054     2-(3,4-dihyd… PLA2G1B     Phospholipa…            2
#> 20 LUJAXSNNYBCFE… P00747     3',4',5-trih… PLG         Plasminogen             2
#> # ℹ 4 more variables: sources <list>, best_evidence_level <int>,
#> #   evidence_labels <list>, activity_values <list>
aggregated_target2np(search = "TP53", min_sources = 3,
                     include_predictions = TRUE)
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 0 × 0
# }
```
