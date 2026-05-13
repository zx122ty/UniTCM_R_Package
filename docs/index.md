# unitcm ![](inst/icon.png)

**unitcm** is an R client for the [UniTCM](https://unitcm.qfxulab.com/)
Traditional Chinese Medicine multi-omics platform. It provides tidy,
paginated access to herbs, compounds, disease-formula associations, TCM
ontology, and gene-disease analysis (MIDAS).

## Installation

``` r

# install.packages("pak")
pak::pkg_install("zx122ty/UniTCM_R_Package")
```

## Quick Start

``` r

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
|----|----|----|
| Herb Explorer | [`search_herbs()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_herbs.md), [`get_herb()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_herb.md) | 800+ herbs with properties and compounds |
| Ingredient Explorer | [`search_compounds()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_compounds.md), [`get_compound_admet()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_compound_admet.md) | 50,000+ compounds with ADMET and targets |
| Disease-Formula Atlas | [`search_formulas()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_formulas.md), [`get_formula_doses()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_formula_doses.md) | 259,000+ formula-disease associations |
| TCM Ontology | [`search_ontology()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_ontology.md), [`export_ontology()`](https://zx122ty.github.io/UniTCM_R_Package/reference/export_ontology.md) | Hierarchical TCM knowledge system |
| MIDAS | [`query_gene_diseases()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_gene_diseases.md), [`query_disease_enrichment()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_disease_enrichment.md) | Multi-source gene-disease analysis |

## Documentation

- [Getting
  Started](https://zx122ty.github.io/UniTCM_R_Package/articles/unitcm.html)
- [Database
  Queries](https://zx122ty.github.io/UniTCM_R_Package/articles/database-queries.html)
- [Network Pharmacology
  Workflow](https://zx122ty.github.io/UniTCM_R_Package/articles/network-pharmacology.html)
- [Gene-Disease
  Analysis](https://zx122ty.github.io/UniTCM_R_Package/articles/gene-disease-analysis.html)
- [Function
  Reference](https://zx122ty.github.io/UniTCM_R_Package/reference/index.html)
