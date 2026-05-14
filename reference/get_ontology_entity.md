# Get a TCM ontology entity

Retrieve full detail for one entity including ancestors, children,
external mappings, and relations.

## Usage

``` r
get_ontology_entity(tcm_id)
```

## Arguments

- tcm_id:

  The TCM ontology ID (e.g. `"TCM_0001"`).

## Value

A named list with sub-elements: `ancestors`, `children`,
`external_mappings`, `relations`.

## Examples

``` r
if (FALSE) { # \dontrun{
get_ontology_entity("TCM_0001")
} # }
```
