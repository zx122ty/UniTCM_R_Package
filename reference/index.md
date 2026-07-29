# Package index

## Infrastructure

HTTP client, authentication, and pagination helpers.

- [`set_base_url()`](https://zx122ty.github.io/UniTCM_R_Package/reference/set_base_url.md)
  : Set the UniTCM API base URL
- [`get_base_url()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_base_url.md)
  : Get the UniTCM API base URL
- [`set_unitcm_token()`](https://zx122ty.github.io/UniTCM_R_Package/reference/set_unitcm_token.md)
  : Set a UniTCM API token
- [`get_unitcm_token()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_unitcm_token.md)
  : Get the UniTCM API token
- [`clear_unitcm_token()`](https://zx122ty.github.io/UniTCM_R_Package/reference/clear_unitcm_token.md)
  : Clear the UniTCM API token
- [`set_api_key()`](https://zx122ty.github.io/UniTCM_R_Package/reference/set_api_key.md)
  : Set a UniTCM API Key
- [`get_api_key()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_api_key.md)
  : Get the UniTCM API Key
- [`clear_api_key()`](https://zx122ty.github.io/UniTCM_R_Package/reference/clear_api_key.md)
  : Clear the UniTCM API Key
- [`flatten_response()`](https://zx122ty.github.io/UniTCM_R_Package/reference/flatten_response.md)
  : Flatten a nested API response to a tibble
- [`unitcm_cache_clear()`](https://zx122ty.github.io/UniTCM_R_Package/reference/unitcm_cache_clear.md)
  : Clear unitcm cache

## TCMomics Database

Browse and search multi-omics datasets.

- [`search_datasets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_datasets.md)
  : Search TCMomics datasets
- [`get_dataset()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_dataset.md)
  : Get a single dataset by submission ID
- [`get_similar_datasets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_similar_datasets.md)
  : Get similar datasets
- [`fetch_dataset_facets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_dataset_facets.md)
  : Get dataset facets
- [`fetch_dataset_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_dataset_stats.md)
  : Get TCMomics database statistics
- [`export_datasets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/export_datasets.md)
  : Export datasets to CSV

## Home & Statistics

Platform-level statistics and latest submissions.

- [`fetch_home_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_home_stats.md)
  : Get homepage statistics
- [`fetch_latest_submissions()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_latest_submissions.md)
  : Get latest submissions
- [`fetch_tcm_classification_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_tcm_classification_stats.md)
  : Get TCM classification statistics
- [`fetch_omics_type_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_omics_type_stats.md)
  : Get omics type statistics

## Herb Explorer

Query herbs, their properties, and associated compounds.

- [`search_herbs()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_herbs.md)
  : Search herbs in the Herb Explorer
- [`get_herb()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_herb.md)
  : Get a single herb by ID
- [`fetch_herb_facets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_herb_facets.md)
  : Get herb filter facets
- [`get_herb_compounds()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_herb_compounds.md)
  : Get compounds for a herb
- [`export_herbs()`](https://zx122ty.github.io/UniTCM_R_Package/reference/export_herbs.md)
  : Export herbs to CSV
- [`export_herb_compounds()`](https://zx122ty.github.io/UniTCM_R_Package/reference/export_herb_compounds.md)
  : Export herb compounds to CSV

## Ingredient Explorer

Query compounds, ADMET predictions, and target predictions.

- [`search_compounds()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_compounds.md)
  : Search compounds in the Ingredient Explorer
- [`get_compound()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_compound.md)
  : Get a single compound by ID
- [`get_compound_admet()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_compound_admet.md)
  : Get ADMET predictions for a compound
- [`get_compound_targets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_compound_targets.md)
  : Get predicted targets for a compound
- [`get_compound_herbs()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_compound_herbs.md)
  : Get herbs containing a compound
- [`fetch_compound_facets()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_compound_facets.md)
  : Get compound facets and statistics
- [`export_compounds()`](https://zx122ty.github.io/UniTCM_R_Package/reference/export_compounds.md)
  : Export compounds to CSV
- [`export_compound_module()`](https://zx122ty.github.io/UniTCM_R_Package/reference/export_compound_module.md)
  : Export compound data by module

## Disease-Formula Atlas

Query disease-formula associations and ICD-11 classification.

- [`search_formulas()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_formulas.md)
  : Search formulas in the Disease-Formula Atlas
- [`get_formula()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_formula.md)
  : Get a single formula by order ID
- [`get_formula_doses()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_formula_doses.md)
  : Get herb doses for a formula
- [`fetch_disease_tree()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_disease_tree.md)
  : Get the ICD-11 disease classification tree
- [`list_book_sources()`](https://zx122ty.github.io/UniTCM_R_Package/reference/list_book_sources.md)
  : List book sources
- [`list_origin_sources()`](https://zx122ty.github.io/UniTCM_R_Package/reference/list_origin_sources.md)
  : List origin sources
- [`list_dosage_forms()`](https://zx122ty.github.io/UniTCM_R_Package/reference/list_dosage_forms.md)
  : List dosage forms

## TCM Ontology

Navigate and search the TCM ontology hierarchy.

- [`search_ontology()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_ontology.md)
  : Search the TCM Ontology
- [`get_ontology_entity()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_ontology_entity.md)
  : Get a TCM ontology entity
- [`get_ontology_children()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_ontology_children.md)
  : Get children of an ontology entity
- [`get_ontology_descendants()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_ontology_descendants.md)
  : Get all descendants of an ontology entity
- [`get_ontology_ancestors()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_ontology_ancestors.md)
  : Get ancestors of an ontology entity
- [`fetch_ontology_tree()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_ontology_tree.md)
  : Fetch the TCM ontology tree
- [`fetch_ontology_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_ontology_stats.md)
  : Fetch ontology statistics
- [`list_ontology_categories()`](https://zx122ty.github.io/UniTCM_R_Package/reference/list_ontology_categories.md)
  : List top-level ontology categories
- [`get_ontology_by_level()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_ontology_by_level.md)
  : Get ontology entities by level
- [`search_ontology_mapping()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_ontology_mapping.md)
  : Search ontology external mapping
- [`export_ontology()`](https://zx122ty.github.io/UniTCM_R_Package/reference/export_ontology.md)
  : Export the TCM ontology

## MIDAS Gene-Disease

Multi-source gene-disease association analysis.

- [`query_gene_diseases()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_gene_diseases.md)
  : Query gene-to-disease associations (MIDAS)
- [`query_disease_genes()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_disease_genes.md)
  : Query disease-to-gene associations (MIDAS)
- [`convert_gene_ids()`](https://zx122ty.github.io/UniTCM_R_Package/reference/convert_gene_ids.md)
  : Convert gene identifiers (MIDAS)
- [`query_disease_enrichment()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_disease_enrichment.md)
  : Disease enrichment analysis (MIDAS)
- [`query_source_comparison()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_source_comparison.md)
  : Compare gene-disease sources (MIDAS)
- [`query_disease_intersection()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_disease_intersection.md)
  : Find disease intersection (MIDAS)
- [`autocomplete_disease()`](https://zx122ty.github.io/UniTCM_R_Package/reference/autocomplete_disease.md)
  : Autocomplete disease names (MIDAS)
- [`fetch_midas_sources()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_midas_sources.md)
  : Get MIDAS data sources
- [`fetch_midas_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_midas_stats.md)
  : Get MIDAS statistics

## TCM Terms & Mechanisms

Search TCM terms and their modern mechanisms.

- [`search_terms()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_terms.md)
  : Search TCM bilingual corpus terms
- [`get_term()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_term.md)
  : Get a single term by ID
- [`list_term_sources()`](https://zx122ty.github.io/UniTCM_R_Package/reference/list_term_sources.md)
  : List term sources
- [`list_term_categories()`](https://zx122ty.github.io/UniTCM_R_Package/reference/list_term_categories.md)
  : List term categories
- [`search_mechanisms()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_mechanisms.md)
  : Search terms molecular mechanisms
- [`get_mechanism()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_mechanism.md)
  : Get a single mechanism term by ID
- [`fetch_mechanism_filters()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_mechanism_filters.md)
  : Get mechanism filter options

## Transcriptome Hub

Query TCM transcriptomics datasets and analysis results.

- [`search_transcriptomes()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_transcriptomes.md)
  : Search transcriptome datasets
- [`get_transcriptome()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_transcriptome.md)
  : Get a single transcriptome dataset
- [`fetch_transcriptome_filters()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_transcriptome_filters.md)
  : Get transcriptome filter options
- [`fetch_transcriptome_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_transcriptome_stats.md)
  : Get Transcriptome Hub statistics
- [`get_analysis_modules()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_analysis_modules.md)
  : List available analysis modules for a dataset
- [`get_analysis_data()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_analysis_data.md)
  : Get analysis data for a transcriptome dataset

## NetVis

Network pharmacology graph queries.

- [`fetch_netvis_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_netvis_stats.md)
  : Get NetVis network statistics
- [`search_netvis()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_netvis.md)
  : Search NetVis nodes
- [`get_neighbors()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_neighbors.md)
  : Get neighbors of a node
- [`get_subgraph()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_subgraph.md)
  : Get subgraph for a set of nodes
- [`find_path()`](https://zx122ty.github.io/UniTCM_R_Package/reference/find_path.md)
  : Find shortest path between two nodes
- [`get_node_detail()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_node_detail.md)
  : Get node detail
- [`get_node_metrics()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_node_metrics.md)
  : Get node metrics
- [`detect_communities()`](https://zx122ty.github.io/UniTCM_R_Package/reference/detect_communities.md)
  : Detect communities in a graph

## Network Helpers

Build and convert network objects locally.

- [`build_hct_network()`](https://zx122ty.github.io/UniTCM_R_Package/reference/build_hct_network.md)
  : Build an Herb-Compound-Target network
- [`build_formula_herb_network()`](https://zx122ty.github.io/UniTCM_R_Package/reference/build_formula_herb_network.md)
  : Build a Formula-Herb network
- [`as_igraph()`](https://zx122ty.github.io/UniTCM_R_Package/reference/as_igraph.md)
  : Convert a NetVis graph response to igraph
- [`as_tidygraph()`](https://zx122ty.github.io/UniTCM_R_Package/reference/as_tidygraph.md)
  : Convert a NetVis graph response to tidygraph

## Visualization

Quick plotting helpers.

- [`plot_network()`](https://zx122ty.github.io/UniTCM_R_Package/reference/plot_network.md)
  : Plot a network graph
- [`plot_enrichment()`](https://zx122ty.github.io/UniTCM_R_Package/reference/plot_enrichment.md)
  : Plot enrichment results
- [`plot_compound_radar()`](https://zx122ty.github.io/UniTCM_R_Package/reference/plot_compound_radar.md)
  : Plot compound physicochemical radar chart

## PPI & Enrichment

Protein-protein interaction networks and GO/KEGG enrichment via STRING
and Enrichr APIs.

- [`query_string_ppi()`](https://zx122ty.github.io/UniTCM_R_Package/reference/query_string_ppi.md)
  : Query the STRING database for protein-protein interactions
- [`build_ppi_network()`](https://zx122ty.github.io/UniTCM_R_Package/reference/build_ppi_network.md)
  : Build a PPI network as an igraph object
- [`identify_hub_genes()`](https://zx122ty.github.io/UniTCM_R_Package/reference/identify_hub_genes.md)
  : Identify hub genes by degree centrality
- [`louvain_cluster()`](https://zx122ty.github.io/UniTCM_R_Package/reference/louvain_cluster.md)
  : Detect communities in a PPI network using the Louvain algorithm
- [`enrichr_enrichment()`](https://zx122ty.github.io/UniTCM_R_Package/reference/enrichr_enrichment.md)
  : Perform GO and KEGG pathway enrichment via the Enrichr API

## Network Separation

Network-based separation analysis (Menche et al. 2015) to quantify
drug-target-to-disease-module proximity.

- [`set_distance()`](https://zx122ty.github.io/UniTCM_R_Package/reference/set_distance.md)
  : Compute closest distance between two gene sets in a network
- [`self_distance()`](https://zx122ty.github.io/UniTCM_R_Package/reference/self_distance.md)
  : Compute mean internal distance of a gene set
- [`network_separation()`](https://zx122ty.github.io/UniTCM_R_Package/reference/network_separation.md)
  : Compute the network separation score S_AB
- [`per_node_distance()`](https://zx122ty.github.io/UniTCM_R_Package/reference/per_node_distance.md)
  : Compute per-node closest distance to another gene set
- [`find_elbow()`](https://zx122ty.github.io/UniTCM_R_Package/reference/find_elbow.md)
  : Find the elbow (knee) point in a curve
- [`find_saturation_point()`](https://zx122ty.github.io/UniTCM_R_Package/reference/find_saturation_point.md)
  : Find the saturation point in a curve
- [`network_separation_sweep()`](https://zx122ty.github.io/UniTCM_R_Package/reference/network_separation_sweep.md)
  : Sweep network separation across top-N gene selection
- [`network_separation_analysis()`](https://zx122ty.github.io/UniTCM_R_Package/reference/network_separation_analysis.md)
  : Network separation analysis

## Target2NP

Reverse target-to-natural-product search across DrugCLIP and SEA.

- [`search_target2np()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_target2np.md)
  : Search Target2NP compound-target interactions
- [`search_target2np_drugclip()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_target2np_drugclip.md)
  : Search DrugCLIP predicted compound-target interactions
- [`search_target2np_sea()`](https://zx122ty.github.io/UniTCM_R_Package/reference/search_target2np_sea.md)
  : Search SEA (ChEMBL similarity) predicted compound-target
  interactions
- [`get_target2np()`](https://zx122ty.github.io/UniTCM_R_Package/reference/get_target2np.md)
  : Get a single Target2NP interaction record
- [`batch_target2np()`](https://zx122ty.github.io/UniTCM_R_Package/reference/batch_target2np.md)
  : Batch query Target2NP by identifier list
- [`aggregated_target2np()`](https://zx122ty.github.io/UniTCM_R_Package/reference/aggregated_target2np.md)
  : Aggregated Target2NP view across data sources
- [`target2np_multi_source_summary()`](https://zx122ty.github.io/UniTCM_R_Package/reference/target2np_multi_source_summary.md)
  : Multi-source summary for a Target2NP query
- [`fetch_target2np_filters()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_target2np_filters.md)
  : Fetch Target2NP filter options
- [`fetch_target2np_stats()`](https://zx122ty.github.io/UniTCM_R_Package/reference/fetch_target2np_stats.md)
  : Fetch Target2NP database statistics
