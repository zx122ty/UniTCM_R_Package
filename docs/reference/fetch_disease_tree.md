# Get the ICD-11 disease classification tree

Returns the full 4-level ICD-11 disease classification tree used by the
Disease-Formula Atlas.

## Usage

``` r
fetch_disease_tree()
```

## Value

A recursive nested list with structure
`list(label, count, children = list(...))`.

## Examples

``` r
if (FALSE) { # \dontrun{
tree <- fetch_disease_tree()
names(tree[[1]])
} # }
```
