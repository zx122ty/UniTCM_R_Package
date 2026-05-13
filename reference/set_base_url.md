# Set the UniTCM API base URL

Set the UniTCM API base URL

## Usage

``` r
set_base_url(url)
```

## Arguments

- url:

  A character string. The base URL for the UniTCM API, e.g.
  `"https://UniTCM.cn/api/v1"`.

## Value

Invisible previous URL value.

## Examples

``` r
# \donttest{
set_base_url("https://UniTCM.cn/api/v1")
#> UniTCM base URL set to <https://UniTCM.cn/api/v1>
# }
```
