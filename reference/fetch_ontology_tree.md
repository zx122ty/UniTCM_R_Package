# Fetch the TCM ontology tree

Returns the full ontology as a recursive nested list.

## Usage

``` r
fetch_ontology_tree(depth = 4L)
```

## Arguments

- depth:

  Tree depth to return (1–10, default 4).

## Value

A recursive nested list:
`list(tcm_id, name, name_cn, level, children = list(...))`.

## Examples

``` r
# \donttest{
tree <- fetch_ontology_tree(depth = 2)
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
# }
```
