# Plot compound physicochemical radar chart

Create a radar/spider chart of normalized physicochemical properties for
a compound.

## Usage

``` r
plot_compound_radar(
  compound_id,
  properties = c("mw", "clogp", "tpsa", "hbd", "hba", "qed_score")
)
```

## Arguments

- compound_id:

  The UniTCM ingredient ID.

- properties:

  Character vector of property names to plot (default: key drug-likeness
  properties).

## Value

A `ggplot` object.

## Examples

``` r
if (FALSE) { # \dontrun{
plot_compound_radar("UNITCM_I00001")
} # }
```
