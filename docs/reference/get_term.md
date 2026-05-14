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
if (FALSE) { # \dontrun{
get_term("TCM_T001")
} # }
```
