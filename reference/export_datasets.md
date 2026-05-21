# Export datasets to CSV

Download a CSV export of datasets matching the given filters.

## Usage

``` r
export_datasets(
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
  file = "datasets_export.csv"
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

- file:

  Output file path (default `"datasets_export.csv"`).

## Value

Invisible file path.

## Examples

``` r
if (FALSE) { # \dontrun{
export_datasets(omics = "Transcriptomics", file = "transcriptomics.csv")
} # }
```
