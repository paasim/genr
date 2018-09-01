library(tibble)
library(purrr)

context("gen_num")
test_that("generating numbers seems to work as expected", {
  n <- 13L
  integers <- gen_nat(n)
  expect_true(class(integers) == "integer")
  expect_true(length(integers) == n)
  expect_true(all(integers) >= 0L)
})

context("gen_lst")
test_that("generating from a discrete set seems to work as expected", {
  n <- 29L
  set <- letters
  generated_set <- gen_lst(set)(n)
  expect_true(class(generated_set) == class(set))
  expect_true(length(generated_set) == n)
  expect_true(all(generated_set %in% set))
})

context("tbl_gen")
test_that("tbl_gen produces a tibble as expected", {
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
