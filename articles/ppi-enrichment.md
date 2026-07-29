# PPI Network & Enrichment Analysis

``` r

library(unitcm)
library(igraph)
library(dplyr)
```

This vignette demonstrates how to perform protein-protein interaction
(PPI) network analysis and GO/KEGG pathway enrichment using the `unitcm`
package. These functions call the public STRING and Enrichr APIs
directly — no UniTCM API key is required.

------------------------------------------------------------------------

## Step 1: Define a Gene List

Start with a list of target genes — for example, the integrated targets
from a network pharmacology analysis of a TCM formula:

``` r

genes <- c(
  "TP53", "BRCA1", "EGFR", "VEGFA", "TNF",
  "MYC", "AKT1", "IL6", "JUN", "MAPK3",
  "PTEN", "NFKB1", "STAT3", "HIF1A", "CCND1",
  "BCL2", "CASP3", "CTNNB1", "ERBB2", "FOS"
)
length(genes)
```

------------------------------------------------------------------------

## Step 2: Query the STRING PPI Database

``` r

ppi <- query_string_ppi(genes, species = 9606, score_threshold = 400)
nrow(ppi)
head(ppi)
```

------------------------------------------------------------------------

## Step 3: Build the PPI Network

``` r

g <- build_ppi_network(ppi, genes)
cat("Nodes:", vcount(g), "\n")
cat("Edges:", ecount(g), "\n")
```

------------------------------------------------------------------------

## Step 4: Identify Hub Genes

Hub genes are the most highly connected nodes in the network, ranked by
degree centrality:

``` r

hubs <- identify_hub_genes(g, top_n = 10)
hubs

# Hub genes as a data frame
hub_df <- data.frame(
  Gene = names(hubs),
  Degree_Centrality = as.numeric(hubs)
)
hub_df
```

------------------------------------------------------------------------

## Step 5: Community Detection (Louvain Clustering)

Partition the PPI network into functional modules:

``` r

clusters <- louvain_cluster(g)
lengths(clusters)

# View members of the largest cluster
largest_idx <- which.max(lengths(clusters))
cat("Largest cluster (", lengths(clusters)[largest_idx], "genes):\n",
    paste(clusters[[largest_idx]], collapse = ", "))
```

------------------------------------------------------------------------

## Step 6: GO & KEGG Enrichment via Enrichr

Submit the gene list to Enrichr for functional enrichment analysis:

``` r

enrich <- enrichr_enrichment(genes, top_n = 10)
names(enrich)
```

### KEGG Pathways

``` r

kegg <- enrich[["KEGG_2021_Human"]]
kegg
```

### GO Biological Process

``` r

go_bp <- enrich[["GO_Biological_Process_2023"]]
go_bp
```

### WikiPathways

``` r

wp <- enrich[["WikiPathway_2021_Human"]]
wp
```

------------------------------------------------------------------------

## Full Workflow Summary

Putting it all together in a compact pipeline:

``` r

# 1. Query PPI
ppi <- query_string_ppi(genes)

# 2. Build network
g <- build_ppi_network(ppi, genes)

# 3. Hub genes
hubs <- identify_hub_genes(g, top_n = 10)

# 4. Functional modules
clusters <- louvain_cluster(g)

# 5. Pathway enrichment
enrich <- enrichr_enrichment(genes)

# 6. Report
cat("\n=== SUMMARY ===\n")
cat("Input genes:", length(genes), "\n")
cat("PPI edges:", nrow(ppi), "\n")
cat("Network nodes:", vcount(g), "  edges:", ecount(g), "\n")
cat("Top hub:", names(hubs)[1], " (degree centrality =", round(hubs[1], 4), ")\n")
cat("Communities:", length(clusters), "\n")
cat("Enriched KEGG pathways:", nrow(enrich[["KEGG_2021_Human"]]), "\n")
```

## Notes

- **Species parameter:** Use NCBI taxonomy IDs — `9606` for human,
  `10090` for mouse, `10116` for rat.
- **Score threshold:** STRING combined score (0–1000). Values ≥ 700
  represent high confidence, ≥ 400 medium confidence.
- **Enrichr libraries:** The default set covers GO (BP, MF, CC), KEGG,
  and WikiPathways. See the [Enrichr
  website](https://maayanlab.cloud/Enrichr/#stats) for the full list of
  available gene-set libraries.
- **Rate limits:** Both STRING and Enrichr are free, public APIs. The
  functions include built-in throttling and retries, but avoid sending
  large numbers of requests in rapid succession.
