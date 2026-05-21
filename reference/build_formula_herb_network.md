# Build a Formula-Herb network

Given a formula order ID, fetches its herb doses and constructs a
star-topology network.

## Usage

``` r
build_formula_herb_network(formula_id)
```

## Arguments

- formula_id:

  The formula order ID (integer or character).

## Value

An `igraph` graph object with vertex attributes `name`, `type`
(`"formula"`, `"herb"`), `label`, and `dose` (for herbs).

## Examples

``` r
if (FALSE) { # \dontrun{
g <- build_formula_herb_network(1)
igraph::V(g)$label
} # }
```
