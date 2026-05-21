# Search formulas in the Disease-Formula Atlas

Query the Disease-Formula Atlas with optional text search and ICD-11
disease classification filters. Multi-value parameters accept character
vectors and are collapsed to comma-separated strings internally.

## Usage

``` r
search_formulas(
  q = NULL,
  level1 = NULL,
  level2 = NULL,
  level3 = NULL,
  level4 = NULL,
  book_sources = NULL,
  origin_sources = NULL,
  dosage_forms = NULL,
  mapping_confidence = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Optional search query string.

- level1, level2, level3, level4:

  ICD-11 disease classification levels.

- book_sources:

  Book source filter (character vector).

- origin_sources:

  Origin source filter (character vector).

- dosage_forms:

  Dosage form filter (character vector).

- mapping_confidence:

  Mapping confidence filter (character vector).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 100).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of formulas with attribute `"total"`.

## Examples

``` r
# \donttest{
search_formulas(q = "insomnia")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 20 × 17
#>    order formula_name composition        formula_type efficacy indications usage
#>    <int> <chr>        <chr>              <chr>        <chr>    <chr>       <chr>
#>  1  7901 理消汤       川厚朴、槟榔片、焦麦芽、藿香、广木… 汤剂 (Decocti… "理气消食，和… "脾胃不和，失眠多梦… "每日1…
#>  2  7902 百合夏枯草汤 百合30克，夏枯草15克。…… 汤剂 (Decocti… "养阴平肝安神… "长时间失眠，神情不… "每日1…
#>  3  7903 复方丹参酒   丹参50克，石菖蒲50克，玄胡50… 酒剂 (Medicat… "活心安神。"… "心烦意乱，不能入睡… "上药共…
#>  4  7904 去痰君安汤   法半夏、陈皮、炙甘草、炒枳壳、瓜蒌… 汤剂 (Decocti… "化痰饮，决壅… "久夜张目不瞑，因而… "水煎，…
#>  5  7905 惊恐不寐方   炒枣仁、生甘草、朱砂、陈皮、郁李仁… 其他剂型 (Other… "镇静安神，祛… "白日猝然受惊，入夜… "水煎，…
#>  6  7906 地芍二至丸   法半夏、夏枯草各10克，生地黄、白… 丸剂 (Pill)  "育阴潜阳，交… "顽固性失眠。"…… "上药睡…
#>  7  7907 补心安神膏   黄芪60克，党参30克，沙参60克… 膏剂 (Paste p… "健脾安神，养… "用脑过度，失眠，食… "将上药…
#>  8  7908 潜阳宁神汤   夜交藤30克，熟枣仁20克，远志1… 汤剂 (Decocti… "滋阴潜阳，清… "心烦不寐，惊悸怔忡… "水煎服…
#>  9 10714 失眠方19首1  大红枣1000克，放入大瓶子内，再… 其他剂型 (Other… ""       ""          "每天吃…
#> 10 10715 失眠方19首2  核桃仁4～6个，剥净去皮碾碎，放锅… 其他剂型 (Other… ""       ""          ""   
#> 11 10716 失眠方19首3  猪心（不洗，不去血）1个，熟枣仁3… 其他剂型 (Other… ""       ""          "将猪心…
#> 12 10717 失眠方19首4  当归、生地、红花、牛膝各1.5克，… 其他剂型 (Other… ""       ""          "水煎服…
#> 13 10718 失眠方19首5  莲子（去心）50克，百合30克，瘦… 其他剂型 (Other… ""       ""          "加水煲…
#> 14 10719 失眠方19首6  新鲜生蚝肉150克，瘦猪肉150克… 其他剂型 (Other… ""       ""          "加水煲…
#> 15 10720 失眠方19首7  黑豆15克，小麦15克（去壳），合… 其他剂型 (Other… ""       ""          "加水6…
#> 16 10721 失眠方19首8  白茯苓、人参、熟地、肉苁蓉各60克… 其他剂型 (Other… ""       ""          "共研细…
#> 17 10722 失眠方19首9  麻雀3只，去毛和内脏，烘干研粉。…… 其他剂型 (Other… ""       ""          "黄酒冲…
#> 18 10723 失眠方19首10 瘦猪肉炖灵芝汤。   其他剂型 (Other… ""       ""          "每次灵…
#> 19 10724 失眠方19首11 灵芝50克，浸于1000毫升高粱酒… 其他剂型 (Other… ""       ""          ""   
#> 20 10725 失眠方19首12 核桃三枚，每日一次，服用三周至一个… 其他剂型 (Other… ""       ""          ""   
#> # ℹ 10 more variables: book_source <chr>, formula_source_abbr <chr>,
#> #   disease_name <chr>, icd11_code <chr>, icd11_matched_name <chr>,
#> #   mapping_confidence <chr>, disease_level1 <chr>, disease_level2 <chr>,
#> #   disease_level3 <chr>, disease_level4 <chr>
search_formulas(level1 = "Neoplasms", mapping_confidence = "high")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 0 × 0
# }
```
