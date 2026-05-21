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
# \donttest{
opts <- fetch_target2np_filters()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
opts$source_db
#> [1] "BATMAN-TCM" "BindingDB"  "HERB2"      "HIT2"       "NPASS"     
# }
```
