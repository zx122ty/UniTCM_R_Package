# Clear the UniTCM API token

Removes the token from session memory and optionally from the system
keyring.

## Usage

``` r
clear_unitcm_token(keyring = FALSE)
```

## Arguments

- keyring:

  Logical. If `TRUE`, also remove from system keyring.

## Value

Invisible `NULL`.

## Examples

``` r
# \donttest{
clear_unitcm_token()
#> Token cleared from session.
# }
```
