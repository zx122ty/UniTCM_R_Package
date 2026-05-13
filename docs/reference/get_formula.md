# Get a single formula by order ID

Retrieve full detail for one formula from the Disease-Formula Atlas.

## Usage

``` r
get_formula(order_id)
```

## Arguments

- order_id:

  The formula order ID (integer or character).

## Value

A named list with 30+ fields.

## Examples

``` r
# \donttest{
get_formula(1)
#> $order
#> [1] 1
#> 
#> $formula_name
#> [1] "增效调经丸"
#> 
#> $composition
#> [1] "地黄10g，当归6g，党参10g，炒白术10g，陈皮10g，菟丝子10g，川续断10g，制香附10g，月季花3g。"
#> 
#> $formula_type
#> [1] "丸剂 (Pill)"
#> 
#> $efficacy
#> [1] "补肾培本，养血调经。"
#> 
#> $syndromes_en
#> [1] ""
#> 
#> $major_symptoms
#> [1] ""
#> 
#> $target_disease_zh
#> [1] ""
#> 
#> $target_disease_en
#> [1] ""
#> 
#> $clinical_signs_zh
#> [1] ""
#> 
#> $clinical_signs_en
#> [1] ""
#> 
#> $indications
#> [1] "妇女月经不调。"
#> 
#> $usage
#> [1] "按上药比例可制成丸剂，也可作汤剂煎服。"
#> 
#> $modification
#> [1] "如作汤药煎服，因血热而致月经先期者加地骨皮、丹皮；证偏阴虚血热，迫经先行者加麦冬、女贞子、白芍；因寒客胞脉而致月经后期者加桂心、艾叶；证偏血虚加枸杞、枣皮；证见郁滞腹痛者加元胡、台乌药；因肝郁而致月经先后无定期者加柴胡、炒白芍；证偏因郁瘀者加元胡、蒲黄；证见肾虚者加山茱萸、山药、五味子；因气虚不能摄血而致月经过多者加黄芪、仙鹤草，重用党参；因热盛于里而致月经过少者加炒黄柏、炒地榆、旱莲草；因血瘀而致月经过少者、加桃仁、红花；证见痰湿者加陈皮、茯苓、半夏。"
#> 
#> $book_source
#> [1] "妇科病良方1500首"
#> 
#> $formula_source_full
#> [1] "彭澍方.中国中医药报第3版.1991；12：13"
#> 
#> $formula_source_abbr
#> [1] "Other"
#> 
#> $clinical_evidence
#> [1] ""
#> 
#> $typical_case
#> [1] ""
#> 
#> $formula_explanation
#> [1] ""
#> 
#> $commentary
#> [1] ""
#> 
#> $preparation
#> [1] ""
#> 
#> $author
#> [1] ""
#> 
#> $brief_intro
#> [1] ""
#> 
#> $description
#> [1] ""
#> 
#> $notes
#> [1] ""
#> 
#> $contraindications
#> [1] ""
#> 
#> $disease_name
#> [1] "menstruation disorder"
#> 
#> $icd11_matched_name
#> [1] "Disorders of breast augmentation"
#> 
#> $icd11_code
#> [1] "GC7A"
#> 
#> $icd_order
#> [1] 10100
#> 
#> $similarity_score
#> [1] 77.19298
#> 
#> $mapping_confidence
#> [1] ""
#> 
#> $level
#> [1] 3
#> 
#> $disease_level1
#> [1] "Diseases of the genitourinary system"
#> 
#> $disease_level2
#> [1] "- Postprocedural disorders of genitourinary system"
#> 
#> $disease_level3
#> [1] "- - Disorders of breast augmentation"
#> 
#> $disease_level4
#> [1] ""
#> 
# }
```
