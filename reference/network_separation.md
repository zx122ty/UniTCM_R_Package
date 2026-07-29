# Compute the network separation score S_AB

Implements the network-based separation metric from Menche et al.
(Science 2015):

## Usage

``` r
network_separation(graph, setA, setB)
```

## Arguments

- graph:

  An `igraph` object.

- setA:

  Character vector of gene symbols (e.g. drug targets).

- setB:

  Character vector of gene symbols (e.g. disease genes).

## Value

A named numeric vector with elements:

- d_AB:

  Mean closest distance between set A and set B.

- d_AA:

  Mean internal distance of set A.

- d_BB:

  Mean internal distance of set B.

- S_AB:

  Network separation score.

## Details

\$\$S\_{AB} = d\_{AB} - \frac{d\_{AA} + d\_{BB}}{2}\$\$

- \\S\_{AB} \< 0\\: the modules are topologically overlapping /
  colocalized.

- \\S\_{AB} \ge 0\\: the modules are topologically separated.

## Examples

``` r
if (FALSE) { # \dontrun{
g <- build_ppi_network(ppi_df, all_genes)
network_separation(g,
  setA = c("TP53", "BRCA1", "MYC"),
  setB = c("TNF", "IL6", "NFKB1"))
} # }
```
