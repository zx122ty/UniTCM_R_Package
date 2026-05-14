#' Get NetVis network statistics
#'
#' @return A named list with node counts (`formula`, `herb`, `compound`,
#'   `target`, `disease`) and `edges` sub-list.
#' @export
#' @examples
#' \dontrun{
#' fetch_netvis_stats()
#' }
fetch_netvis_stats <- function() {
  unitcm_request("/netvis/stats")
}

#' Search NetVis nodes
#'
#' @param q Search query.
#' @param type Node type filter: `"all"` (default), `"formula"`, `"herb"`,
#'   `"compound"`, `"target"`, or `"disease"`.
#' @param limit Maximum results (default 20).
#' @return A [tibble::tibble()] with columns: `id`, `type`, `label`,
#'   `label_cn`, `degree`.
#' @export
#' @examples
#' \dontrun{
#' search_netvis("ginseng", type = "herb")
#' }
search_netvis <- function(q, type = "all", limit = 20L) {
  resp <- unitcm_request("/netvis/search",
    query = list(q = q, type = type, limit = limit))
  if (is.data.frame(resp)) return(tibble::as_tibble(resp))
  if (is.list(resp) && length(resp) > 0L) {
    return(tryCatch(tibble::as_tibble(resp), error = function(e) tibble::tibble()))
  }
  tibble::tibble()
}

#' Get neighbors of a node
#'
#' @param node_id Node ID (e.g. `"H:UNITCM_H001"`).
#' @param depth Neighbor depth (1--3, default 1).
#' @param limit Maximum neighbors (max 200, default 50).
#' @param node_types Comma-separated node types to include.
#' @return A named list with `$nodes` ([tibble::tibble()]), `$edges`
#'   ([tibble::tibble()]), and `$has_more`.
#' @export
#' @examples
#' \dontrun{
#' get_neighbors("H:UNITCM_H001", depth = 1)
#' }
get_neighbors <- function(node_id, depth = 1L, limit = 50L,
                          node_types = NULL) {
  resp <- unitcm_request(paste0("/netvis/neighbors/", normalize_node_id(node_id)),
    query = list(depth = depth, limit = limit, node_types = node_types))
  parse_graph_response(resp)
}

#' Get subgraph for a set of nodes
#'
#' @param node_ids Character vector of node IDs (max 50).
#' @param limit Maximum edges (default 200).
#' @return A named list with `$nodes` ([tibble::tibble()]), `$edges`
#'   ([tibble::tibble()]), and `$has_more`.
#' @export
#' @examples
#' \dontrun{
#' get_subgraph(c("H:UNITCM_H001", "C:UNITCM_I00001"))
#' }
get_subgraph <- function(node_ids, limit = 200L) {
  resp <- unitcm_request("/netvis/subgraph",
    query = list(nodes = paste(normalize_node_id(node_ids), collapse = ","), limit = limit))
  parse_graph_response(resp)
}

#' Find shortest path between two nodes
#'
#' @param source Source node ID.
#' @param target Target node ID.
#' @param max_depth Maximum path depth (max 8, default 4).
#' @return A named list with `$nodes` ([tibble::tibble()]) and `$edges`
#'   ([tibble::tibble()]).
#' @export
#' @examples
#' \dontrun{
#' find_path("H:UNITCM_H001", "T:TP53")
#' }
find_path <- function(source, target, max_depth = 4L) {
  resp <- unitcm_request("/netvis/path",
    query = list(source = normalize_node_id(source),
                 target = normalize_node_id(target),
                 max_depth = max_depth))
  parse_graph_response(resp)
}

#' Get node detail
#'
#' @param node_id Node ID.
#' @return A named list with fields: `id`, `type`, `label`, `label_cn`,
#'   `properties`, `detail_url`.
#' @export
#' @examples
#' \dontrun{
#' get_node_detail("H:UNITCM_H001")
#' }
get_node_detail <- function(node_id) {
  unitcm_request(paste0("/netvis/node/", normalize_node_id(node_id)))
}

#' Get node metrics
#'
#' @param node_id Node ID.
#' @return A named list with fields: `node_id`, `degree`, `neighbor_types`.
#' @export
#' @examples
#' \dontrun{
#' get_node_metrics("H:UNITCM_H001")
#' }
get_node_metrics <- function(node_id) {
  unitcm_request(paste0("/netvis/metrics/", normalize_node_id(node_id)))
}

#' Detect communities in a graph
#'
#' POST a graph (nodes + edges) to the server for community detection.
#'
#' @param nodes Character vector of node IDs.
#' @param edges A data frame or list of edges, each with `source` and
#'   `target` fields.
#' @return A [tibble::tibble()] with columns `node_id` and `community_id`.
#' @export
#' @examples
#' \dontrun{
#' detect_communities(
#'   nodes = c("A", "B", "C"),
#'   edges = data.frame(source = c("A", "B"), target = c("B", "C"))
#' )
#' }
detect_communities <- function(nodes, edges) {
  if (is.data.frame(edges)) {
    edge_list <- lapply(seq_len(nrow(edges)), function(i) {
      list(source = edges$source[i], target = edges$target[i])
    })
  } else {
    edge_list <- edges
  }

  resp <- unitcm_request("/netvis/communities", method = "POST",
    body = list(nodes = as.list(nodes), edges = edge_list))

  comms <- resp[["communities"]]
  if (is.null(comms)) return(tibble::tibble(node_id = character(), community_id = integer()))

  tibble::tibble(
    node_id = names(comms),
    community_id = as.integer(unlist(comms))
  )
}

#' Parse a graph response into tibbles
#'
#' @param resp API response list with `nodes` and `edges`.
#' @return A named list with `$nodes` and `$edges` as tibbles, plus any
#'   extra fields (e.g. `$has_more`).
#' @noRd
parse_graph_response <- function(resp) {
  result <- list()

  nodes <- resp[["nodes"]]
  if (is.data.frame(nodes)) {
    result$nodes <- tibble::as_tibble(nodes)
  } else if (is.list(nodes) && length(nodes) > 0L) {
    result$nodes <- tryCatch(tibble::as_tibble(nodes),
      error = function(e) tibble::tibble())
  } else {
    result$nodes <- tibble::tibble()
  }

  edges <- resp[["edges"]]
  if (is.data.frame(edges)) {
    result$edges <- tibble::as_tibble(edges)
  } else if (is.list(edges) && length(edges) > 0L) {
    result$edges <- tryCatch(tibble::as_tibble(edges),
      error = function(e) tibble::tibble())
  } else {
    result$edges <- tibble::tibble()
  }

  extra_fields <- setdiff(names(resp), c("nodes", "edges"))
  for (f in extra_fields) {
    result[[f]] <- resp[[f]]
  }

  result
}
