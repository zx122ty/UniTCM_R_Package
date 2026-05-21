# Get predicted targets for a compound

Retrieve target predictions from DrugCLIP, ChEMBL similarity search, or
both.

## Usage

``` r
get_compound_targets(
  id,
  method = c("drugclip", "chembl", "both"),
  page = 1L,
  page_size = 20L
)
```

## Arguments

- id:

  The UniTCM ingredient ID.

- method:

  One of `"drugclip"`, `"chembl"`, or `"both"` (default `"drugclip"`).

- page:

  Page number (for ChEMBL targets, default 1).

- page_size:

  Results per page (for ChEMBL targets, default 20).

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of targets. When `method = "both"`, a `source` column is added to
distinguish results.

## Examples

``` r
if (FALSE) { # \dontrun{
get_compound_targets("UNITCM_I00001")
get_compound_targets("UNITCM_I00001", method = "both")
} # }
```
