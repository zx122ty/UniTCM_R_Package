# Get herb doses for a formula

Retrieve the composition and dosage information for a specific formula.

## Usage

``` r
get_formula_doses(order_id)
```

## Arguments

- order_id:

  The formula order ID.

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns: `id`, `herb_name`, `original_dose`, `composition_ratio`,
`modern_dose_g`, `clinical_ref_dose_g`, `dynasty`, `notes`, `herb_ids`.

## Examples

``` r
if (FALSE) { # \dontrun{
get_formula_doses(1)
} # }
```
