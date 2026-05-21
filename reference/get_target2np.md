# Get a single Target2NP interaction record

Retrieve the full detail for one compound-target interaction record.

## Usage

``` r
get_target2np(record_id)
```

## Arguments

- record_id:

  Integer record ID.

## Value

A named list of interaction fields.

## Examples

``` r
# \donttest{
get_target2np(1)
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> $record_id
#> [1] 1
#> 
#> $source_db
#> [1] "HERB2"
#> 
#> $evidence_level
#> [1] 4
#> 
#> $evidence_label
#> [1] "Database-derived"
#> 
#> $compound_name
#> [1] "8beta-ethoxy atractylenolide I"
#> 
#> $inchikey
#> [1] "CCOC12CC3(CCCC(=C)C3CC1=C(C(=O)O2)C)C"
#> 
#> $smiles
#> [1] ""
#> 
#> $pubchem_cid
#> [1] ""
#> 
#> $chembl_id
#> [1] ""
#> 
#> $cas_number
#> [1] "C17H24O3"
#> 
#> $molecular_formula
#> [1] ""
#> 
#> $inchi
#> [1] "ACHE"
#> 
#> $gene_symbol
#> [1] "acetylcholinesterase (Cartwright blood group)"
#> 
#> $protein_name
#> [1] ""
#> 
#> $uniprot_id
#> [1] "43"
#> 
#> $entrez_gene_id
#> [1] "ENSG00000087085"
#> 
#> $ensembl_id
#> [1] "Homo sapiens"
#> 
#> $target_organism
#> [1] "9606"
#> 
#> $taxonomy_id
#> [1] ""
#> 
#> $interaction_type
#> [1] ""
#> 
#> $activity_type
#> [1] ""
#> 
#> $activity_value
#> NULL
#> 
#> $activity_units
#> [1] ""
#> 
#> $activity_relation
#> [1] ""
#> 
#> $pmid
#> [1] ""
#> 
#> $doi
#> [1] ""
#> 
#> $paper_title
#> [1] ""
#> 
#> $evidence_text
#> [1] ""
#> 
#> $herb2_grade
#> [1] "database"
#> 
#> $herb2_source_type
#> [1] ""
#> 
#> $bindingdb_curation
#> [1] ""
#> 
#> $npass_ref_id_type
#> [1] ""
#> 
#> $npass_ref_id
#> [1] ""
#> 
#> $batman_target_source
#> [1] "73950"
#> 
#> $unitcm_ingredient_id
#> NULL
#> 
# }
```
