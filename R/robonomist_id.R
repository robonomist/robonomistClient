

new_robonomist_id <- function(x = character()) {
  vec_assert(x, character())
  new_vctr(x, class = "robonomist_id")
}

validate_robonomist_id <- function(x) {
  stopifnot(
    nchar(x) > 2,
    !grepl("(§| |#)", x),
    grepl("/", x)
  )
}

robonomist_id <- function(x = character()) {
  validate_robonomist_id(x)
  new_robonomist_id(enc2utf8(x))
}

#' @export
print.robonomist_id <- function(x, ...) {
  print(unclass(x))
  invisible(x)
}

#' @export
format.robonomist_id <- function(x, ...) {
  x <- vec_data(x)
  i <- regexpr("/", x)
  paste0(
    crayon::blue(substr(x, 1L, i)),
    crayon::cyan(substr(x, i + 1L, nchar(x)))
  )
}

#' @export
vec_ptype_abbr.robonomist_id <- function(x, ...) {
  "robonomist_id"
}

#' @export
vec_ptype2.robonomist_id.character <- function(x, y, ...) new_robonomist_id()
#' @export
vec_ptype2.character.robonomist_id <- function(x, y, ...) new_robonomist_id()
#' @export
vec_cast.robonomist_id.character <- function(x, to, ...) robonomist_id(x)
#' @export
vec_cast.character.robonomist_id <- function(x, to, ...) vec_data(x)


## tibble(id = rep(robonomist_id("aa/aa1"), 10))
