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
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "herb_id"), msg =
#>   "Input should be a valid integer, unable to parse string as an integer")
igraph::vcount(g)
#> Error: object 'g' not found
# }
```
