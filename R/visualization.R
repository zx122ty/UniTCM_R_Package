#' Plot a network graph
#'
#' Visualize an `igraph` or `tbl_graph` object using `ggraph`.
#'
#' @param graph An `igraph` or `tidygraph::tbl_graph` object.
#' @param layout Layout algorithm (default `"fr"` for Fruchterman-Reingold).
#'   See [ggraph::create_layout()] for options.
#' @param color_by Vertex attribute name to map to node color (default
#'   `"type"`).
#' @param node_size Base node size (default 3).
#' @param edge_alpha Edge transparency (default 0.3).
#' @param show_labels Whether to label nodes (default `TRUE` for nodes
#'   with degree >= 3, or all if graph has <= 50 nodes).
#' @return A `ggplot` object.
#' @export
#' @examples
#' \dontrun{
#' g <- build_hct_network("UNITCM_H001")
#' plot_network(g)
#' }
plot_network <- function(graph, layout = "fr", color_by = "type",
                         node_size = 3, edge_alpha = 0.3,
                         show_labels = NULL) {
  check_pkg("ggraph", reason = "to plot networks")
  check_pkg("ggplot2", reason = "to plot networks")

  n <- igraph::vcount(graph)
  if (is.null(show_labels)) {
    show_labels <- n <= 50L
  }

  p <- ggraph::ggraph(graph, layout = layout) +
    ggraph::geom_edge_link(alpha = edge_alpha) +
    ggplot2::theme_void()

  if (color_by %in% igraph::vertex_attr_names(graph)) {
    p <- p + ggraph::geom_node_point(
      ggplot2::aes(color = .data[[color_by]]),
      size = node_size
    )
  } else {
    p <- p + ggraph::geom_node_point(size = node_size)
  }

  if (isTRUE(show_labels)) {
    label_attr <- if ("label" %in% igraph::vertex_attr_names(graph)) {
      "label"
    } else {
      "name"
    }
    p <- p + ggraph::geom_node_text(
      ggplot2::aes(label = .data[[label_attr]]),
      repel = TRUE, size = 2.5
    )
  }

  p
}

#' Plot enrichment results
#'
#' Create a dot plot or bar plot from enrichment analysis results
#' (e.g. from [query_disease_enrichment()]).
#'
#' @param enrichment_result A [tibble::tibble()] from an enrichment
#'   analysis. Must contain columns mappable to term name and p-value.
#' @param type Plot type: `"dotplot"` (default) or `"barplot"`.
#' @param top_n Number of top terms to show (default 20).
#' @param name_col Column name for term labels (auto-detected if `NULL`).
#' @param pvalue_col Column name for p-values (auto-detected if `NULL`).
#' @param count_col Column name for gene counts (auto-detected if `NULL`).
#' @return A `ggplot` object.
#' @export
#' @examples
#' \dontrun{
#' enrich <- query_disease_enrichment(c("TP53", "BRCA1", "EGFR"))
#' plot_enrichment(enrich)
#' }
plot_enrichment <- function(enrichment_result,
                            type = c("dotplot", "barplot"),
                            top_n = 20L,
                            name_col = NULL, pvalue_col = NULL,
                            count_col = NULL) {
  check_pkg("ggplot2", reason = "to plot enrichment results")
  type <- rlang::arg_match(type)

  cols <- names(enrichment_result)

  if (is.null(name_col)) {
    name_col <- intersect(
      c("disease_name", "term_name", "name", "description", "pathway"),
      cols
    )[1L]
  }
  if (is.null(pvalue_col)) {
    pvalue_col <- intersect(
      c("p_value_adjusted", "p_adjusted", "padj", "fdr", "p_value", "pvalue"),
      cols
    )[1L]
  }
  if (is.null(count_col)) {
    count_col <- intersect(
      c("hit_count", "gene_count", "count", "n_genes", "hits"),
      cols
    )[1L]
  }

  if (is.na(name_col) || is.na(pvalue_col)) {
    rlang::abort("Could not auto-detect column names. Specify `name_col` and `pvalue_col`.")
  }

  df <- utils::head(enrichment_result, top_n)
  df[["..name.."]] <- df[[name_col]]
  df[["..pval.."]] <- df[[pvalue_col]]
  df[["..neg_log_p.."]] <- -log10(df[["..pval.."]])

  df[["..name.."]] <- factor(df[["..name.."]],
    levels = rev(df[["..name.."]]))

  if (type == "barplot") {
    p <- ggplot2::ggplot(df, ggplot2::aes(x = .data[["..neg_log_p.."]],
                                          y = .data[["..name.."]])) +
      ggplot2::geom_col(fill = "#3498db") +
      ggplot2::labs(x = expression(-log[10](p)), y = NULL)
  } else {
    if (!is.na(count_col) && count_col %in% names(df)) {
      df[["..count.."]] <- df[[count_col]]
      p <- ggplot2::ggplot(df, ggplot2::aes(
        x = .data[["..neg_log_p.."]],
        y = .data[["..name.."]],
        size = .data[["..count.."]],
        color = .data[["..pval.."]]
      )) +
        ggplot2::geom_point() +
        ggplot2::scale_color_gradient(low = "red", high = "blue",
          name = "p-value") +
        ggplot2::labs(x = expression(-log[10](p)), y = NULL, size = "Count")
    } else {
      p <- ggplot2::ggplot(df, ggplot2::aes(
        x = .data[["..neg_log_p.."]],
        y = .data[["..name.."]],
        color = .data[["..pval.."]]
      )) +
        ggplot2::geom_point(size = 4) +
        ggplot2::scale_color_gradient(low = "red", high = "blue",
          name = "p-value") +
        ggplot2::labs(x = expression(-log[10](p)), y = NULL)
    }
  }

  p + ggplot2::theme_minimal()
}

#' Plot compound physicochemical radar chart
#'
#' Create a radar/spider chart of normalized physicochemical properties
#' for a compound.
#'
#' @param compound_id The UniTCM ingredient ID.
#' @param properties Character vector of property names to plot (default:
#'   key drug-likeness properties).
#' @return A `ggplot` object.
#' @export
#' @examples
#' \dontrun{
#' plot_compound_radar("UNITCM_I00001")
#' }
plot_compound_radar <- function(compound_id,
                                properties = c("mw", "clogp", "tpsa",
                                               "hbd", "hba", "qed_score")) {
  check_pkg("ggplot2", reason = "to plot radar charts")

  compound <- get_compound(compound_id)

  ref_max <- c(mw = 500, clogp = 5, tpsa = 140, hbd = 5, hba = 10,
               rotatable_bonds = 10, ring_count = 6, aromatic_ring_count = 4,
               fsp3 = 1, qed_score = 1, sa_score = 10,
               np_likeness_score = 5, lipinski_violations = 5)

  vals <- vapply(properties, function(p) {
    v <- compound[[p]]
    if (is.null(v) || is.na(v)) return(0)
    mx <- ref_max[p]
    if (is.na(mx)) mx <- max(abs(v), 1)
    min(abs(as.numeric(v)) / mx, 1)
  }, numeric(1L))

  n <- length(properties)
  angles <- seq(0, 2 * pi, length.out = n + 1L)[-(n + 1L)]

  df <- data.frame(
    property = properties,
    value = vals,
    x = vals * cos(angles),
    y = vals * sin(angles),
    stringsAsFactors = FALSE
  )
  df_closed <- rbind(df, df[1L, ])

  ggplot2::ggplot(df_closed, ggplot2::aes(x = .data[["x"]],
                                           y = .data[["y"]])) +
    ggplot2::geom_polygon(fill = "#3498db", alpha = 0.3) +
    ggplot2::geom_path(color = "#2c3e50") +
    ggplot2::geom_point(data = df, color = "#e74c3c", size = 3) +
    ggplot2::geom_text(data = df,
      ggplot2::aes(
        x = 1.15 * cos(angles),
        y = 1.15 * sin(angles),
        label = .data[["property"]]
      ), size = 3) +
    ggplot2::coord_fixed() +
    ggplot2::theme_void() +
    ggplot2::labs(title = paste("Compound:", compound_id))
}
