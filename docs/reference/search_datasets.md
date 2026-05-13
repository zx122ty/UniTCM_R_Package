# Search TCMomics datasets

Query the TCMomics multi-omics database with optional text search and
faceted filters.

## Usage

``` r
search_datasets(
  q = NULL,
  tcm = NULL,
  omics = NULL,
  source = NULL,
  organism = NULL,
  tissue = NULL,
  disease = NULL,
  repo = NULL,
  year_min = NULL,
  year_max = NULL,
  sort = NULL,
  search_mode = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- q:

  Optional search query string.

- tcm:

  TCM classification filter.

- omics:

  Omics type filter.

- source:

  Source type filter.

- organism:

  Organism filter.

- tissue:

  Tissue filter.

- disease:

  Disease filter.

- repo:

  Repository filter.

- year_min:

  Minimum publication year.

- year_max:

  Maximum publication year.

- sort:

  Sort field: `"relevance"`, `"date_desc"`, `"views_desc"`, or
  `"downloads_desc"`.

- search_mode:

  Search mode: `"fuzzy"` (default) or `"exact"`.

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20).

- all_pages:

  If `TRUE`, fetch all pages via auto-pagination.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
datasets with attribute `"total"`.

## Examples

``` r
# \donttest{
search_datasets(q = "ginseng", omics = "Transcriptomics")
#> # A tibble: 20 × 18
#>    submission_id  project_title                  short_abstract project_keywords
#>    <chr>          <chr>                          <chr>          <chr>           
#>  1 tcmomics000079 Ginsenoside CK improves cogni… Ginsenoside C… Ginsenoside CK;…
#>  2 tcmomics000080 Ginsenoside Rg3 Reduces the T… Ginsenoside R… Ginsenoside Rg3…
#>  3 tcmomics000120 MicroRNAs expression in 20(R)… This study in… 20(R)-ginsenosi…
#>  4 tcmomics000127 Next generation sequencing an… Next-generati… Next generation…
#>  5 tcmomics000143 Role of MicroRNA-214 in Ginse… Ginsenoside-R… Ginsenoside-Rg1…
#>  6 tcmomics000150 Systems biology analysis of K… This study in… Korean red gins…
#>  7 tcmomics000188 Transcriptomics provides nove… Panax notogin… Panax notoginse…
#>  8 tcmomics000189 Transcriptomics provides nove… Transcriptomi… Panax notoginse…
#>  9 tcmomics000190 Transcriptomics provides nove… Panax notogin… Panax notoginse…
#> 10 tcmomics000228 RNA illumina sequencing of Pa… This study pe… Panax notoginse…
#> 11 tcmomics000261 Pro-angiogenic Ginsenoside F1… Ginsenosides … Ginsenoside F1;…
#> 12 tcmomics000266 lncRNA sequencing of human ov… Ginsenoside 2… ginsenoside 20(…
#> 13 tcmomics000273 Transcriptome analysis of the… Transcriptome… Panax ginseng;c…
#> 14 tcmomics000307 Effects of Korean red ginseng… This study in… Korean red gins…
#> 15 tcmomics000335 Treatment with ginseng flower… Ginseng flowe… ginseng flower …
#> 16 tcmomics000344 Expression data of mice ovari… This study in… Red Ginseng Ext…
#> 17 tcmomics000365 The effects of Korean Red Gin… This study in… Korean Red Gins…
#> 18 tcmomics000448 Myostain is involved in GINSE… Ginsenoside-R… GINSENOSIDE-Rb1…
#> 19 tcmomics000450 Next generation sequencing an… Next-generati… Next-generation…
#> 20 tcmomics000005 A systematic exploration on G… Ginsenoside R… Ginsenoside Rg5…
#> # ℹ 14 more variables: TCM_classification <chr>, TCM_entity_name_chinese <chr>,
#> #   omics_type <chr>, view_count <int>, like_count <int>,
#> #   totalFileDownloads <int>, totalFileSize <int>, updated_at <lgl>,
#> #   manul_publication_date <chr>, sample_number <int>, source_type <chr>,
#> #   submitted_by <chr>, manul_submitter <chr>, institution <chr>
# }
```
