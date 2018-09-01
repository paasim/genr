library(tibble)
library(purrr)
context("tbl_gen")
test_that("tbl_gen produces a tibble as expected", {
  # c = character, i = integer, d = double, l = logical, D = date.
  n <- 42L
  cols <- "ccidlD"
  tbl1 <- gen_tbl(n, cols)
  tbl_types <- tibble(V1 = character(0),
                      V2 = character(0),
                      V3 = integer(0),
                      V4 = double(0),
                      V5 = logical(0),
                      V6 = as.Date(1, origin = "0000-01-01")[0])
  expect_identical(tbl1[0, ], tbl_types)
  expect_true(nrow(tbl1) == n)
  na <- map_lgl(tbl1, ~any(is.na(.x)))
  expect_false(any(na))
})
