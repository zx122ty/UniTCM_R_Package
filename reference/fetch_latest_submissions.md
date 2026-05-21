# Get latest submissions

Get latest submissions

## Usage

``` r
fetch_latest_submissions()
```

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
of recent submissions with columns: `submission_id`, `project_title`,
`submitted_by`, `updated_at`, `institution`, `total_file_size`.

## Examples

``` r
# \donttest{
fetch_latest_submissions()
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> Warning: Selecting ‘env’ backend. Secrets are stored in environment variables
#> # A tibble: 5 × 6
#>   submission_id  project_title               submitted_by updated_at institution
#>   <chr>          <chr>                       <chr>        <lgl>      <chr>      
#> 1 tcmomics000003 A Deep Learning based Effi… 3            NA         Peking Uni…
#> 2 tcmomics000925 Natural product inhibition… 925          NA         Zhejiang U…
#> 3 tcmomics000010 Analysis of DNA methylatio… 10           NA         Baylor Uni…
#> 4 tcmomics000011 Androgen-starved LNCaP cel… 11           NA         Broad Inst…
#> 5 tcmomics000005 A systematic exploration o… 5            NA         Gwangju In…
#> # ℹ 1 more variable: total_file_size <int>
# }
```
