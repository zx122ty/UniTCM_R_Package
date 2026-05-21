# Get a single term by ID

Retrieve full detail for one term from the TCM Bilingual Corpus.

## Usage

``` r
get_term(term_id)
```

## Arguments

- term_id:

  The term ID.

## Value

A named list with fields including `chinese_name`, `pinyin`,
`english_name`, `latin_name`, `description_english`, etc.

## Examples

``` r
# \donttest{
get_term("TCM_T001")
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Error in httr2::req_perform(req): HTTP 422 Unprocessable Entity.
#> ℹ HTTP 422: list(type = "int_parsing", loc = list("path", "term_id"), msg =
#>   "Input should be a valid integer, unable to parse string as an integer")
# }
```
