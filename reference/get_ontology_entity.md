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
# \donttest{
get_ontology_entity("TCM_0001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 404 Not Found.
#> ℹ Resource not found: Not Found
# }
```
