# Getting Started with unitcm

## Installation

Install the development version from GitHub:

``` r

# install.packages("pak")
pak::pkg_install("zx122ty/UniTCM_R_Package")
```

Or using `remotes`:

``` r

remotes::install_github("zx122ty/UniTCM_R_Package")
```

## Setup

``` r

library(unitcm)
```

By default, `unitcm` connects to the public UniTCM API at
`https://UniTCM.cn/api/v1`. You can override this if needed:

``` r

# Only needed for custom/local deployments
set_base_url("https://UniTCM.cn/api/v1")
```

## Authentication

All data-access endpoints are currently public and require no
authentication. For future authenticated endpoints, you can set a token:

``` r

# Via environment variable (recommended for scripts/CI)
# Set UNITCM_TOKEN in your .Renviron

# Or set in session
set_unitcm_token("your-token-here")

# Or store securely in system keyring
set_unitcm_token("your-token-here", keyring = TRUE)
```

## Your First Query

Search for herbs related to ginseng:

``` r

herbs <- search_herbs(q = "ginseng")
herbs
```

Get detailed information for a specific herb:

``` r

herb <- get_herb("UNITCM_H001")
herb$herb_english_name
herb$efficacy
```

## Pagination

Most search functions return paginated results. Use `page` and
`page_size` to control pagination manually, or set `all_pages = TRUE` to
fetch everything:

``` r

# Manual pagination
page1 <- search_herbs(q = "ginseng", page = 1, page_size = 50)
attr(page1, "total") # Total records available

# Auto-pagination: fetches all pages with a progress bar
all_herbs <- search_herbs(q = "ginseng", all_pages = TRUE)
nrow(all_herbs)
```

## Available Modules

`unitcm` provides access to these UniTCM platform modules:

| Module | Key Functions |
|----|----|
| Herb Explorer | [`search_herbs()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_herbs.md), [`get_herb()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_herb.md), [`get_herb_compounds()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_herb_compounds.md) |
| Ingredient Explorer | [`search_compounds()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_compounds.md), [`get_compound_admet()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_compound_admet.md), [`get_compound_targets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_compound_targets.md) |
| Disease-Formula Atlas | [`search_formulas()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_formulas.md), [`get_formula_doses()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_formula_doses.md), [`fetch_disease_tree()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_disease_tree.md) |
| TCM Ontology | [`search_ontology()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_ontology.md), [`get_ontology_entity()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_ontology_entity.md), [`export_ontology()`](https://zx122ty.github.io/UniTCM_R_Package/reference/export_ontology.md) |
| MIDAS Gene-Disease | [`query_gene_diseases()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_gene_diseases.md), [`query_disease_enrichment()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_disease_enrichment.md) |

See
[`vignette("database-queries")`](https://zx122ty.github.io/UniTCM_R_Package/articles/database-queries.md)
for detailed examples of each module.
