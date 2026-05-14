# Clear the UniTCM API Key

Removes the API key from session memory and optionally from the system
keyring.

## Usage

``` r
clear_api_key(keyring = FALSE)
```

## Arguments

- keyring:

  Logical. If `TRUE`, also remove from system keyring.

## Value

Invisible `NULL`.

## Examples

``` r
if (FALSE) { # \dontrun{
clear_api_key()
} # }
```
