# Find the elbow (knee) point in a curve

Implements a simplified Kneedle algorithm to detect the point of maximum
curvature in a 2-D curve. Useful for choosing the optimal number of
top-ranked genes (top-N) in a separation-sweep: the elbow is where
adding more genes yields diminishing returns.

## Usage

``` r
find_elbow(x, y)
```

## Arguments

- x:

  Numeric vector of x-values (e.g. N, the number of top genes).

- y:

  Numeric vector of y-values (e.g. S_AB scores).

## Value

An integer index into `x` and `y` where the elbow is detected. Returns
`1L` if the inputs are too short (\< 3 points).

## Examples

``` r
x <- seq(10, 100, by = 10)
y <- c(0.5, 0.3, 0.15, 0.08, 0.05, 0.03, 0.02, 0.018, 0.015, 0.014)
idx <- find_elbow(x, y)
x[idx]  # optimal N
#> [1] 10
```
