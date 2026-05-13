# Set a UniTCM API token

Stores the token in session memory. Optionally also stores it in the
system keyring (requires the keyring package).

## Usage

``` r
set_unitcm_token(token, keyring = FALSE)
```

## Arguments

- token:

  A character string. The bearer token.

- keyring:

  Logical. If `TRUE`, also store in system keyring.

## Value

Invisible `NULL`.

## Examples

``` r
# \donttest{
set_unitcm_token("my-secret-token")
#> Token stored in session.
# }
```
