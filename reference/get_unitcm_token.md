# Get the UniTCM API token

Checks in order: (1) session value set via
[`set_unitcm_token()`](https://zx122ty.github.io/UniTCM_R_Package/reference/set_unitcm_token.md),
(2) environment variable `UNITCM_TOKEN`, (3) system keyring.

## Usage

``` r
get_unitcm_token()
```

## Value

A character string, or `NULL` if no token is found.

## Examples

``` r
# \donttest{
get_unitcm_token()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> NULL
# }
```
