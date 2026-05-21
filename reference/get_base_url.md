# Get the UniTCM API base URL

Checks in order: (1) session value set via
[`set_base_url()`](https://zx122ty.github.io/UniTCM_R_Package/reference/set_base_url.md),
(2) option `unitcm.base_url`, (3) environment variable
`UNITCM_BASE_URL`, (4) hardcoded default.

## Usage

``` r
get_base_url()
```

## Value

A character string.

## Examples

``` r
if (FALSE) { # \dontrun{
get_base_url()
} # }
```
