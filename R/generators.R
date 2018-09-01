# generate numbers with cauchy distribution
gen_dbl <- partial(rcauchy, scale = 3)
gen_int <- compose(as.integer, round, gen_dbl)
gen_nat <- compose(abs, gen_int)

# generate elements from discrete set
gen_lst <- function(x) partial(sample, x = x, replace = TRUE)
gen_lgl <- gen_lst(c(FALSE, TRUE))

# generate words and character vectors
gen_word <- compose(partial(paste0, collapse = ""), gen_lst(letters))
gen_chr <- compose(partial(map_chr, .f = gen_word), gen_lst(9))

# generate dates
gen_date <- compose(partial(as.Date, origin = "2000-01-01"), gen_nat)

# a map from characters to generators
type_map <- list(c = gen_chr, d = gen_dbl, D = gen_date,
                 i = gen_int, l = gen_lgl, n = gen_nat)

# splits a string into list of characters
str_to_chr <- compose(flatten_chr, partial(strsplit, split = ""))
# map the types-string into a list of corresponding generator-functions
process_types <- compose(partial(map, .f = ~type_map[[.x]]), str_to_chr)

#' Generate a tibble
#'
#' Generates a tibble of \code{n} rows with user-specified column types.
#'
#' @param n The number of rows in the tibble.
#' @param types The types for the columns in the data. The representation
#'  follows the convention specified in the \code{readr}-package and the types
#'  available are c = character, i = integer, d = double, l = logical, D = date.
#
#' @examples
#' \donttest{
#' # A tibble with 42 rows and one character, one date and one integer column
#' gen_tbl(42, "cDi")
#' }
#'
#' @return A tibble with \code{n} rows and \code{nchar(types)} columns.
#'
#' @export
gen_tbl <- function(n, types) gen_tbl_cust(n, process_types(types))

#' Generate a tibble
#'
#' Generates a tibble of \code{n} rows with user-specified columns.
#'
#' @param n The number of rows in the tibble.
#' @param gens A list of functions that take a single argument \code{n} and
#'  which are used to generate the columns.
#
#' @examples
#' \donttest{
#' # A tibble with 7 rows and one column with logical values
#' gen_tbl_cust(7, list(function(n) sample(c(FALSE, TRUE), n, replace = TRUE)))
#' }
#'
#' @return A tibble with \code{n} rows and \code{length(gens)} columns.
#'
#' @export
gen_tbl_cust <- function(n, gens) invoke_map_dfc(gens, n)
