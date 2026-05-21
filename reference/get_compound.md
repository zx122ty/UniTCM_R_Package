# Get a single compound by ID

Retrieve full detail for one compound including cross-references.

## Usage

``` r
get_compound(id)
```

## Arguments

- id:

  The UniTCM ingredient ID (e.g. `"UNITCM_I00001"`).

## Value

A named list with 26+ fields including an `xref` sub-list.

## Examples

``` r
# \donttest{
get_compound("UNITCM_I00001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $unitcm_ingredient_id
#> [1] 1
#> 
#> $component_name
#> [1] "Abietic acid"
#> 
#> $formula
#> [1] "C20H30O2"
#> 
#> $mw
#> [1] 302.458
#> 
#> $exact_mass
#> [1] 302.2246
#> 
#> $heavy_atom_count
#> [1] 22
#> 
#> $formal_charge
#> [1] 0
#> 
#> $clogp
#> [1] 5.2062
#> 
#> $tpsa
#> [1] 37.3
#> 
#> $hbd
#> [1] 1
#> 
#> $hba
#> [1] 1
#> 
#> $rotatable_bonds
#> [1] 2
#> 
#> $aromatic_ring_count
#> [1] 0
#> 
#> $ring_count
#> [1] 3
#> 
#> $fsp3
#> [1] 0.75
#> 
#> $lipinski_violations
#> [1] 1
#> 
#> $qed_score
#> [1] 0.7603
#> 
#> $sa_score
#> [1] 4.1708
#> 
#> $np_likeness_score
#> [1] 2.8679
#> 
#> $murcko_scaffold
#> [1] "C1=CC2=CC[C@H]3CCCCC3[C@H]2CC1"
#> 
#> $is_approved_drug
#> [1] FALSE
#> 
#> $bioactivity_target_count
#> [1] 0
#> 
#> $smiles_canonical
#> [1] "CC(C)C1=CC2=CCC3C(C)(C(=O)O)CCCC3(C)C2CC1"
#> 
#> $smiles_isomeric
#> [1] "CC(C)C1=CC2=CC[C@@H]3[C@@]([C@H]2CC1)(CCC[C@@]3(C)C(=O)O)C"
#> 
#> $inchi
#> [1] "InChI=1S/C20H30O2/c1-13(2)14-6-8-16-15(12-14)7-9-17-19(16,3)10-5-11-20(17,4)18(21)22/h7,12-13,16-17H,5-6,8-11H2,1-4H3,(H,21,22)/t16-,17+,19+,20+/m0/s1"
#> 
#> $inchikey
#> [1] "RSWGJHLUYNHPMX-ONCXSQPRSA-N"
#> 
#> $pubchem_cid
#> [1] 10569
#> 
#> $iupac_name
#> [1] "(1R,4aR,4bR,10aR)-1,4a-dimethyl-7-propan-2-yl-2,3,4,4b,5,6,10,10a-octahydrophenanthrene-1-carboxylic acid"
#> 
#> $synonyms
#>  [1] "ABIETIC ACID"                                                                                                          
#>  [2] "514-10-3"                                                                                                              
#>  [3] "Sylvic acid"                                                                                                           
#>  [4] "l-Abietic acid"                                                                                                        
#>  [5] "7,13-Abietadien-18-oic acid"                                                                                           
#>  [6] "13-Isopropylpodocarpa-7,13-dien-15-oic acid"                                                                           
#>  [7] "Kyselina abietova"                                                                                                     
#>  [8] "V3DHX33184"                                                                                                            
#>  [9] "NSC-25149"                                                                                                             
#> [10] "1-Phenanthrenecarboxylic acid, 1,2,3,4,4a,4b,5,6,10,10a-decahydro-1,4a-dimethyl-7-(1-methylethyl)-, (1R,4aR,4bR,10aR)-"
#> 
#> $cas_number
#> [1] "514-10-3"
#> 
#> $chebi_id
#> [1] "CHEBI:28987"
#> 
#> $complexity
#> [1] 542
#> 
# }
```
