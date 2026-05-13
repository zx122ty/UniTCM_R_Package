# Set a UniTCM API Key

Stores the API key in session memory. Optionally also stores it in the
system keyring (requires the keyring package).

## Usage

``` r
set_api_key(api_key, keyring = FALSE)
```

## Arguments

- api_key:

  A character string. The API key (starts with `unitcm_`).

- keyring:

  Logical. If `TRUE`, also store in system keyring.

## Value

Invisible `NULL`.

## Examples

``` r
# \donttest{
set_api_key("unitcm_your_key_here")
#> API key stored in session.
# }
```
