# Get Transcriptome Hub statistics

Get Transcriptome Hub statistics

## Usage

``` r
fetch_transcriptome_stats()
```

## Value

A named list with fields: `total_datasets`, `total_organisms`,
`total_tcm_entities`, `total_analysis_modules`, plus distribution data.

## Examples

``` r
# \donttest{
fetch_transcriptome_stats()
#> $total_datasets
#> [1] 1037
#> 
#> $total_organisms
#> [1] 54
#> 
#> $total_tcm_entities
#> [1] 451
#> 
#> $total_analysis_modules
#> [1] 11
#> 
#> $tcm_classification_distribution
#>                               name count
#> 1            TCM Active ingredient   566
#> 2             Herb/herbal medicine   200
#> 3                   Modern formula    65
#> 4        Acupuncture & moxibustion    64
#> 5                  Classic formula    55
#> 6          Chinese patent medicine    46
#> 7                            Other    24
#> 8         TCM theory & methodology    12
#> 9                  TCM diagnostics     3
#> 10 Integrated TCM-Western medicine     2
#> 
#> $organism_distribution
#>                                                   name count
#> 1                                         Homo sapiens   452
#> 2                                         Mus musculus   331
#> 3                                    Rattus norvegicus   135
#> 4                                Plasmodium falciparum    19
#> 5                             Saccharomyces cerevisiae     8
#> 6                                          Danio rerio     5
#> 7                                     Escherichia coli     5
#> 8                                  Salvia miltiorrhiza     5
#> 9                                           Sus scrofa     4
#> 10                               Staphylococcus aureus     4
#> 11                                     Panax japonicus     3
#> 12                              Caenorhabditis elegans     3
#> 13                                Streptococcus mutans     3
#> 14                         Cryptococcus neoformans H99     3
#> 15                               Glycyrrhiza uralensis     3
#> 16                                       Panax ginseng     3
#> 17                                      Equus caballus     2
#> 18                             Ophiocordyceps sinensis     2
#> 19 Epinephelus fuscoguttatus x Epinephelus lanceolatus     2
#> 20                                 Cordyceps militaris     2
#> 
#> $experiment_type_distribution
#>                                                 name count
#> 1                      Expression profiling by array   519
#> 2 Expression profiling by high throughput sequencing   497
#> 3                  Non-coding RNA profiling by array    15
#> 4                       Expression profiling by SAGE     3
#> 5       Methylation profiling by genome tiling array     2
#> 6                Genome variation profiling by array     1
#> 
# }
```
