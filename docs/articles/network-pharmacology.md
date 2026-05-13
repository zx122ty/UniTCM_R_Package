# Network Pharmacology Workflow

``` r

library(unitcm)
library(dplyr)
```

This vignette demonstrates a complete network pharmacology workflow:
from a TCM formula to its herb-compound-target (H-C-T) network.

## Step 1: Select a Formula

Start by searching for a formula related to a disease of interest:

``` r

formulas <- search_formulas(q = "insomnia", page_size = 5)
formulas

# Get full details for the first formula
formula <- get_formula(formulas$order[1])
formula$formula_name
formula$composition
```

## Step 2: Get Herb Composition

``` r

doses <- get_formula_doses(formulas$order[1])
doses

# Extract herb names
herb_names <- doses$herb_name
herb_names
```

## Step 3: Find Herb IDs

Search for each herb to get its UniTCM ID:

``` r

herb_data <- lapply(herb_names, function(name) {
  result <- search_herbs(q = name, page_size = 1)
  if (nrow(result) > 0) result[1, ]
})
herb_data <- bind_rows(herb_data)
herb_data
```

## Step 4: Get Compounds for Each Herb

``` r

all_compounds <- lapply(herb_data$unitcm_herb_id, function(hid) {
  comps <- get_herb_compounds(hid, all_pages = TRUE)
  if (nrow(comps) > 0) comps$herb_id <- hid
  comps
})
all_compounds <- bind_rows(all_compounds)

# Unique compounds
unique_compounds <- distinct(all_compounds, unitcm_ingredient_id,
                             .keep_all = TRUE)
cat(nrow(unique_compounds), "unique compounds found\n")
```

## Step 5: Get Targets for Key Compounds

``` r

# Get targets for top compounds (limit to first 10 for speed)
top_compounds <- head(unique_compounds, 10)

all_targets <- lapply(top_compounds$unitcm_ingredient_id, function(cid) {
  targets <- get_compound_targets(cid, method = "drugclip")
  if (nrow(targets) > 0) targets$compound_id <- cid
  targets
})
all_targets <- bind_rows(all_targets)
cat(length(unique(all_targets$gene_symbol)), "unique targets found\n")
```

## Step 6: Build Network with igraph

``` r

library(igraph)

# Herb-Compound edges
hc_edges <- all_compounds |>
  select(from = herb_id, to = unitcm_ingredient_id) |>
  distinct()

# Compound-Target edges
ct_edges <- all_targets |>
  select(from = compound_id, to = gene_symbol) |>
  distinct()

# Combine edges
edges <- bind_rows(hc_edges, ct_edges)

# Build graph
g <- graph_from_data_frame(edges, directed = FALSE)

# Add node type attribute
V(g)$type <- case_when(
  V(g)$name %in% herb_data$unitcm_herb_id ~ "herb",
  V(g)$name %in% unique_compounds$unitcm_ingredient_id ~ "compound",
  TRUE ~ "target"
)

cat("Network:", vcount(g), "nodes,", ecount(g), "edges\n")
```

## Step 7: Visualize with ggraph

``` r

library(ggraph)

ggraph(g, layout = "fr") +
  geom_edge_link(alpha = 0.3) +
  geom_node_point(aes(color = type, size = type)) +
  scale_color_manual(values = c(herb = "#e74c3c", compound = "#3498db",
                                target = "#2ecc71")) +
  scale_size_manual(values = c(herb = 6, compound = 3, target = 2)) +
  geom_node_text(
    aes(label = ifelse(type == "herb", name, "")),
    repel = TRUE, size = 3
  ) +
  theme_void() +
  labs(title = paste("H-C-T Network:", formula$formula_name))
```

## Step 8: Pathway Enrichment via MIDAS

Use the identified targets for disease enrichment analysis:

``` r

target_genes <- unique(all_targets$gene_symbol)
enrichment <- query_disease_enrichment(
  target_genes,
  p_value_cutoff = 0.05,
  correction_method = "fdr"
)
head(enrichment, 10)
```
