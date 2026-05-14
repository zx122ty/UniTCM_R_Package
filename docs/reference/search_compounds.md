# Search compounds in the Ingredient Explorer

Query the UniTCM Ingredient Explorer with optional text search and
physicochemical property filters.

## Usage

``` r
search_compounds(
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
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
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

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 200).

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
compounds with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_compounds(q = "quercetin")
search_compounds(mw_min = 200, mw_max = 500, lipinski = "pass")
} # }
```
