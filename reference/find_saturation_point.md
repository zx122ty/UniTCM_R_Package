# Find the saturation point in a curve

Detects where adding more genes yields less than a threshold improvement
in the metric of interest (e.g. S_AB). Uses a smoothed first difference.

## Usage

``` r
find_saturation_point(x, y, threshold = 0.01)
```

## Arguments

- x:

  Numeric vector of x-values (e.g. N).

- y:

  Numeric vector of y-values (e.g. S_AB).

- threshold:

  Minimum absolute change required to continue adding genes. Default
  `0.01`.

## Value

An integer index into `x` where saturation is reached.

## Examples

``` r
x <- seq(10, 100, by = 10)
y <- c(0.5, 0.3, 0.15, 0.08, 0.051, 0.049, 0.048, 0.047, 0.046, 0.046)
idx <- find_saturation_point(x, y, threshold = 0.01)
x[idx]
#> [1] 60
```
