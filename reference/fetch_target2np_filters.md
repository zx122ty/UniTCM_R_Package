# Fetch Target2NP filter options

Returns the controlled values used by the Target2NP filter UI (source
databases, evidence labels, top target organisms, interaction types, and
top activity types).

## Usage

``` r
fetch_target2np_filters()
```

## Value

A named list with fields `source_db`, `evidence_label`,
`target_organism`, `interaction_type`, `activity_type`.

## Examples

``` r
if (FALSE) { # \dontrun{
opts <- fetch_target2np_filters()
opts$source_db
} # }
```
