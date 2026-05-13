# Gene-Disease Analysis with MIDAS

``` r

library(unitcm)
library(dplyr)
```

MIDAS (Multi-source Integrated Disease Association Search) aggregates
gene-disease associations from multiple databases. This vignette
demonstrates common analysis workflows.

## Data Sources

See what databases are available:

``` r

sources <- fetch_midas_sources()
sources

stats <- fetch_midas_stats()
cat(stats$total_associations, "associations across",
    stats$total_genes, "genes and",
    stats$total_diseases, "diseases\n")
```

## Gene-to-Disease Mapping

Find diseases associated with a gene list:

``` r

genes <- c("TP53", "BRCA1", "EGFR", "VEGFA", "MYC")

results <- query_gene_diseases(
  genes,
  min_sources = 2,
  scoring_method = "max"
)

head(results, 10)

# Gene ID resolution mapping
attr(results, "gene_mapping")
```

## Disease-to-Gene Mapping

Find genes associated with a disease:

``` r

results <- query_disease_genes(
  "breast cancer",
  min_sources = 3,
  page_size = 50
)

head(results, 10)

# Which diseases were matched?
attr(results, "matched_diseases")
```

## Disease Enrichment Analysis

Test whether a gene list is significantly enriched for specific
diseases:

``` r

gene_list <- c("TP53", "BRCA1", "EGFR", "VEGFA", "MYC", "KRAS",
               "AKT1", "PIK3CA", "PTEN", "RB1")

enrichment <- query_disease_enrichment(
  gene_list,
  p_value_cutoff = 0.05,
  correction_method = "fdr",
  min_hit_count = 3
)

cat(attr(enrichment, "total_significant"), "significant diseases from",
    attr(enrichment, "total_tested"), "tested\n")

head(enrichment, 10)
```

## Gene ID Conversion

Normalize mixed identifiers before analysis:

``` r

mixed_ids <- c("TP53", "7157", "ENSG00000141510", "BRCA1")
converted <- convert_gene_ids(mixed_ids)
converted
```

## Source Comparison

Compare coverage across evidence databases:

``` r

comparison <- query_source_comparison(
  c("TP53", "BRCA1", "EGFR"),
  mode = "union"
)

# Genes covered by each source
lapply(comparison$sets, length)

# Exclusive to each source
comparison$exclusives
```

## Disease Intersection

Find shared genetic targets across diseases:

``` r

intersection <- query_disease_intersection(
  c("breast cancer", "lung cancer", "colorectal cancer")
)

cat(intersection$total_intersection_genes, "genes shared across all diseases\n")
head(intersection$targets)
```

## Disease Autocomplete

Find disease names interactively:

``` r

autocomplete_disease("diabet")
autocomplete_disease("breast")
```
