# Build an Herb-Compound-Target network

Given herb names or IDs, fetches herb-compound-target data from the API
and constructs a typed `igraph` network.

## Usage

``` r
build_hct_network(
  herbs,
  target_method = "drugclip",
  max_compounds = 50L,
  progress = TRUE
)
```

## Arguments

- herbs:

  Character vector of herb names or UniTCM herb IDs.

- target_method:

  Target prediction method passed to
  [`get_compound_targets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_compound_targets.md):
  `"drugclip"` (default), `"chembl"`, or `"both"`.

- max_compounds:

  Maximum compounds per herb to include (default 50).

- progress:

  Show progress messages (default `TRUE`).

## Value

An `igraph` graph object with vertex attributes `name`, `type`
(`"herb"`, `"compound"`, `"target"`), and `label`.

## Examples

``` r
# \donttest{
g <- build_hct_network(c("UNITCM_H001", "UNITCM_H002"))
#> Fetching compounds for "UNITCM_H001"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-deacetyl-14-isobutyrylajadine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-deacetyl-14-isobutyrylnudicauline"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-deacetylajadine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-deacetylnudicauline"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "14-demethyltuguaconitine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Ajacine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Delbonine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Delcosine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Deltatsine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Methyllycaconitine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Nudicauline"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "ajadine"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching compounds for "UNITCM_H002"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Acteoside"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Fetching targets for "Echinacoside"...
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in igraph::graph_from_data_frame(edge_df, directed = FALSE, vertices = node_df): Some vertex names in `d` are not listed in `vertices`
igraph::vcount(g)
#> Error: object 'g' not found
# }
```
