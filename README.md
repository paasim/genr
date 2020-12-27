# genr

[![R build status](https://github.com/paasim/genr/workflows/R-CMD-check/badge.svg)](https://github.com/paasim/genr/actions)
[![Coverage Status](https://img.shields.io/codecov/c/github/paasim/genr/master.svg)](https://codecov.io/github/paasim/genr?branch=master)

A small package for generating tibbles.

## Example

``` r
library(genr)
# A tibble with 42 rows and one character, one date and one integer column
gen_tbl(42, "cDi")
```
