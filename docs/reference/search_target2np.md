# Search Target2NP compound-target interactions

Query the UniTCM Target2NP database of natural-product to protein-target
interactions, combining records from experimental sources such as
BindingDB, HERB2, NPASS, BATMAN, and others.

## Usage

``` r
search_target2np(
  search = NULL,
  search_field = c("all", "gene_symbol", "compound_name", "uniprot_id", "inchikey",
    "pubchem_cid", "chembl_id"),
  search_mode = c("exact", "fuzzy"),
  source_db = NULL,
  evidence_level = NULL,
  evidence_label = NULL,
  target_organism = NULL,
  interaction_type = NULL,
  activity_type = NULL,
  page = 1L,
  page_size = 20L,
  all_pages = FALSE
)
```

## Arguments

- search:

  Free-text search query.

- search_field:

  Field to restrict the search to. One of `"all"`, `"gene_symbol"`,
  `"compound_name"`, `"uniprot_id"`, `"inchikey"`, `"pubchem_cid"`, or
  `"chembl_id"`.

- search_mode:

  `"exact"` (case-insensitive equality) or `"fuzzy"` (substring match).

- source_db:

  Filter by source database (e.g. `"BindingDB"`).

- evidence_level:

  Filter by evidence level (integer 1-4 as string).

- evidence_label:

  Filter by evidence label.

- target_organism:

  Filter by target organism (e.g. `"Homo sapiens"`).

- interaction_type:

  Filter by interaction type.

- activity_type:

  Filter by activity type (e.g. `"IC50"`, `"Ki"`).

- page:

  Page number (default 1).

- page_size:

  Results per page (default 20, max 100).

- all_pages:

  If `TRUE`, fetch all pages.

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) of
interaction records with attribute `"total"`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_target2np(search = "quercetin")
search_target2np(search = "TP53", search_field = "gene_symbol",
                 source_db = "BindingDB")
} # }
```
