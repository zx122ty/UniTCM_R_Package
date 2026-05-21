# Search ontology external mapping

Find TCM entities mapped to an external database identifier.

## Usage

``` r
search_ontology_mapping(database, external_id)
```

## Arguments

- database:

  External database name. Must be one of: `"UMLS"`, `"SNOMED_CT"`,
  `"ICD11_TM"`, `"MeSH"`.

- external_id:

  The external identifier to look up.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of matched TCM entities.

## Examples

``` r
if (FALSE) { # \dontrun{
search_ontology_mapping("MeSH", "D008516")
} # }
```
