# Get a single transcriptome dataset

Get a single transcriptome dataset

## Usage

``` r
get_transcriptome(dataset_id)
```

## Arguments

- dataset_id:

  The dataset ID (e.g. `"TCMtrans00001"`).

## Value

A named list with 35+ fields.

## Examples

``` r
# \donttest{
get_transcriptome("TCMtrans00001")
#> $id
#> [1] "TCMtrans00001"
#> 
#> $submission_id
#> [1] "tcmomics000205"
#> 
#> $gse_id
#> [1] "GSE100224"
#> 
#> $tcm_classification
#> [1] "Herb/herbal medicine"
#> 
#> $tcm_entity_name_chinese
#> [1] "蟛蜞菊提取物"
#> 
#> $tcm_entity_name_english
#> [1] "Wedelia chinensis extract"
#> 
#> $gpl_id
#> [1] "GPL10558"
#> 
#> $organism
#> [1] "Homo sapiens"
#> 
#> $model_type
#> [1] "in_vitro"
#> 
#> $species_strain
#> [1] ""
#> 
#> $tissue_organ
#> [1] ""
#> 
#> $cell_type
#> [1] "prostate cancer cell line"
#> 
#> $cell_line
#> [1] "22Rv1"
#> 
#> $disease_model
#> [1] "Hormone-refractory prostate cancer"
#> 
#> $experiment_type
#> [1] "Expression profiling by array"
#> 
#> $sequence_type
#> [1] "mRNA"
#> 
#> $study_design
#> [1] "treatment vs control"
#> 
#> $control_condition
#> [1] "22Rv1 cells treated with vehicle"
#> 
#> $control_samples
#> [1] "GSM2674900;GSM2674901"
#> 
#> $control_n
#> [1] 2
#> 
#> $treatment_condition
#> [1] "22Rv1 cells treated with 10 μg/mL Wedelia chinensis extract (WCE) for 16 hr"
#> 
#> $treatment_samples
#> [1] "GSM2674902;GSM2674903"
#> 
#> $treatment_n
#> [1] 2
#> 
#> $comparison_type
#> [1] "drug_vs_control"
#> 
#> $plat_info
#> [1] "GPL10558:Illumina HumanHT-12 V4.0 expression beadchip"
#> 
#> $disease_classification
#> [1] "Cancer"
#> 
#> $data_type
#> [1] "normalized"
#> 
#> $data_file_type
#> [1] "TAR;TXT"
#> 
#> $gene_id_type
#> [1] "Illumina_probe"
#> 
#> $annotation_package
#> [1] "illuminaHumanv4.db"
#> 
#> $orgdb
#> [1] "org.Hs.eg.db"
#> 
#> $array_channel
#> [1] "one_color"
#> 
#> $library_strategy
#> [1] "not_applicable"
#> 
#> $paired_end
#> [1] "not_applicable"
#> 
#> $platform_title
#> [1] "Illumina HumanHT-12 V4.0 expression beadchip"
#> 
#> $technology_type
#> [1] "oligonucleotide beads"
#> 
#> $n_samples
#> [1] 4
#> 
#> $confidence
#> [1] "high"
#> 
#> $notes
#> [1] "Metadata is clear; study focuses on WCE effect on 22Rv1 cells."
#> 
# }
```
