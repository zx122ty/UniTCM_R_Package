# Get transcriptome filter options

Get transcriptome filter options

## Usage

``` r
fetch_transcriptome_filters()
```

## Value

A named list of character vectors for each filter field.

## Examples

``` r
# \donttest{
filters <- fetch_transcriptome_filters()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
filters$organism
#>  [1] "Aconitum carmichaelii"                              
#>  [2] "Annulohypoxylon stygium"                            
#>  [3] "Arabidopsis thaliana"                               
#>  [4] "Artemisia annua"                                    
#>  [5] "Caenorhabditis elegans"                             
#>  [6] "Campylobacter jejuni subsp. jejuni NCTC 11168"      
#>  [7] "Candida albicans"                                   
#>  [8] "Canis lupus familiaris"                             
#>  [9] "Cervus elaphus"                                     
#> [10] "Cordyceps militaris"                                
#> [11] "Cornus officinalis"                                 
#> [12] "Cryptococcus neoformans H99"                        
#> [13] "Danio rerio"                                        
#> [14] "Dendrobium catenatum"                               
#> [15] "Dendrobium officinale"                              
#> [16] "Echinococcus granulosus"                            
#> [17] "Epinephelus fuscoguttatus x Epinephelus lanceolatus"
#> [18] "Equus caballus"                                     
#> [19] "Escherichia coli"                                   
#> [20] "Forsythia koreana"                                  
#> [21] "Forsythia suspensa"                                 
#> [22] "Forsythia viridissima"                              
#> [23] "Fusarium verticillioides"                           
#> [24] "Ganoderma lucidum"                                  
#> [25] "Glycyrrhiza uralensis"                              
#> [26] "Homo sapiens"                                       
#> [27] "Lithospermum officinale"                            
#> [28] "Lycium barbarum/Lycium ruthenicum"                  
#> [29] "Magnolia obovata"                                   
#> [30] "Mus musculus"                                       
#> [31] "Mycobacterium tuberculosis"                         
#> [32] "Mycolicibacterium smegmatis MC2 155"                
#> [33] "Ophiocordyceps sinensis"                            
#> [34] "Oryzias latipes"                                    
#> [35] "Panax ginseng"                                      
#> [36] "Panax japonicus"                                    
#> [37] "Panax notoginseng"                                  
#> [38] "Pinellia ternata"                                   
#> [39] "Plasmodium falciparum"                              
#> [40] "Platycodon grandiflorus"                            
#> [41] "Pseudomonas aeruginosa"                             
#> [42] "Rattus norvegicus"                                  
#> [43] "Saccharomyces cerevisiae"                           
#> [44] "Salvia miltiorrhiza"                                
#> [45] "Shigella flexneri"                                  
#> [46] "Staphylococcus aureus"                              
#> [47] "Staphylococcus aureus subsp. aureus MW2"            
#> [48] "Streptococcus mutans"                               
#> [49] "Streptococcus suis 05ZYH33"                         
#> [50] "Sus scrofa"                                         
#> [51] "Tachysurus fulvidraco x Tachysurus vachelli"        
#> [52] "Tremella fuciformis"                                
#> [53] "Trichophyton mentagrophytes"                        
#> [54] "Trichophyton rubrum"                                
# }
```
