# Search NetVis nodes

Search NetVis nodes

## Usage

``` r
search_netvis(q, type = "all", limit = 20L)
```

## Arguments

- q:

  Search query.

- type:

  Node type filter: `"all"` (default), `"formula"`, `"herb"`,
  `"compound"`, `"target"`, or `"disease"`.

- limit:

  Maximum results (default 20).

## Value

A [`tibble::tibble()`](https://rdrr.io/pkg/tibble/man/tibble.html) with
columns: `id`, `type`, `label`, `label_cn`, `degree`.

## Examples

``` r
if (FALSE) { # \dontrun{
search_netvis("ginseng", type = "herb")
} # }
```
