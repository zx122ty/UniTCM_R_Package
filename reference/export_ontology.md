# Export the TCM ontology

Download the full ontology in JSON, OWL/RDF, or CSV format.

## Usage

``` r
export_ontology(format = c("json", "owl", "csv"), file = NULL, depth = 4L)
```

## Arguments

- format:

  Export format: `"json"`, `"owl"`, or `"csv"`.

- file:

  Output file path. If `NULL`, auto-named as `"unitcm_ontology.{ext}"`.

- depth:

  Tree depth for JSON export (default 4).

## Value

Invisible file path.

## Examples

``` r
# \donttest{
export_ontology("csv")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
export_ontology("json", depth = 2, file = "ontology_shallow.json")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
# }
```
