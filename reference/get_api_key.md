# Get the UniTCM API Key

Checks in order: (1) session value set via
[`set_api_key()`](https://zx122ty.github.io/UniTCM_R_Package/reference/set_api_key.md),
(2) environment variable `UNITCM_API_KEY`, (3) system keyring.

## Usage

``` r
get_api_key()
```

## Value

A character string, or `NULL` if no API key is found.

## Examples

``` r
if (FALSE) { # \dontrun{
get_api_key()
} # }
```
