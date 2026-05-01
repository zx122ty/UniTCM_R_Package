# unitcm  <img src="inst/icon.png" align="right" height="139" alt="" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/zx122ty/UniTCM_R_Package/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/zx122ty/UniTCM_R_Package/actions/workflows/R-CMD-check.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

**unitcm** is an R client for the [UniTCM](https://unitcm.qfxulab.com/) Traditional
Chinese Medicine multi-omics platform. It provides tidy, paginated access to
herbs, compounds, disease-formula associations, TCM ontology, and gene-disease
analysis (MIDAS).

## Installation

```r
# install.packages("pak")
pak::pkg_install("zx122ty/UniTCM_R_Package")
```

## Quick Start

```r
library(unitcm)

# Search herbs
search_herbs(q = "ginseng")

# Get compound targets (DrugCLIP deep learning predictions)
get_compound_targets("UNITCM_I00001")

# Gene-disease enrichment
query_disease_enrichment(c("TP53", "BRCA1", "EGFR", "VEGFA"))
```

## Modules

| Module | Functions | Description |
|--------|-----------|-------------|
| Herb Explorer | `search_herbs()`, `get_herb()` | 800+ herbs with properties and compounds |
| Ingredient Explorer | `search_compounds()`, `get_compound_admet()` | 50,000+ compounds with ADMET and targets |
| Disease-Formula Atlas | `search_formulas()`, `get_formula_doses()` | 259,000+ formula-disease associations |
| TCM Ontology | `search_ontology()`, `export_ontology()` | Hierarchical TCM knowledge system |
| MIDAS | `query_gene_diseases()`, `query_disease_enrichment()` | Multi-source gene-disease analysis |

## Documentation

- [Getting Started](https://zx122ty.github.io/UniTCM_R_Package/articles/unitcm.html)
- [Database Queries](https://zx122ty.github.io/UniTCM_R_Package/articles/database-queries.html)
- [Network Pharmacology Workflow](https://zx122ty.github.io/UniTCM_R_Package/articles/network-pharmacology.html)
- [Gene-Disease Analysis](https://zx122ty.github.io/UniTCM_R_Package/articles/gene-disease-analysis.html)
- [Function Reference](https://zx122ty.github.io/UniTCM_R_Package/reference/index.html)
