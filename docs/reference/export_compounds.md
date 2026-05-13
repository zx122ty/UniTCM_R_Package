# Export compounds to CSV

Download a CSV export of compounds matching the given filters (max
10,000 rows).

## Usage

``` r
export_compounds(
  q = NULL,
  mw_min = NULL,
  mw_max = NULL,
  clogp_min = NULL,
  clogp_max = NULL,
  tpsa_min = NULL,
  tpsa_max = NULL,
  qed_min = NULL,
  qed_max = NULL,
  ring_count_min = NULL,
  ring_count_max = NULL,
  lipinski = NULL,
  is_drug = NULL,
  sort = NULL,
  file = "compounds_export.csv"
)
```

## Arguments

- q:

  Search query (name, SMILES, formula, or CAS number).

- mw_min, mw_max:

  Molecular weight range.

- clogp_min, clogp_max:

  CLogP range.

- tpsa_min, tpsa_max:

  Topological polar surface area range.

- qed_min, qed_max:

  QED score range.

- ring_count_min, ring_count_max:

  Ring count range.

- lipinski:

  Lipinski rule filter (character vector, comma-collapsed).

- is_drug:

  Approved drug filter (logical or `NULL`).

- sort:

  Sort field (e.g. `"mw"`, `"-mw"`).

- file:

  Output file path (default `"compounds_export.csv"`).

## Value

Invisible file path.

## Examples

``` r
# \donttest{
export_compounds(mw_min = 200, file = "filtered_compounds.csv")
#> Error in httr2::req_perform(req, path = file): HTTP 400 Bad Request.
#> ℹ Bad request: Result set contains 30134 records, exceeding the 10,000 limit.
#>   Please download the full dataset from Zenodo: https://zenodo.org
# }
```
