# Export herbs to CSV

Download a CSV export of herbs matching the given filters.

## Usage

``` r
export_herbs(
  q = NULL,
  therapeutic_en = NULL,
  therapeutic_cn = NULL,
  family = NULL,
  toxicity = NULL,
  source = NULL,
  flavors = NULL,
  properties = NULL,
  meridians = NULL,
  medicinal_part = NULL,
  file = "herbs_export.csv"
)
```

## Arguments

- q:

  Optional search query string.

- therapeutic_en:

  English therapeutic classification filter (character vector).

- therapeutic_cn:

  Chinese therapeutic classification filter (character vector).

- family:

  Botanical family filter (character vector).

- toxicity:

  Toxicity level filter (character vector).

- source:

  Data source filter (character vector).

- flavors:

  Flavor filter (character vector).

- properties:

  Property filter (character vector).

- meridians:

  Meridian tropism filter (character vector).

- medicinal_part:

  Medicinal part filter (character vector).

- file:

  Output file path (default `"herbs_export.csv"`).

## Value

Invisible file path.

## Examples

``` r
if (FALSE) { # \dontrun{
export_herbs(q = "ginseng", file = "ginseng_herbs.csv")
} # }
```
