#' robonomist_id class
#'
#' robonomist_id objects are character vectors composed dataset and table names which are separated by "/".
#'
#' @param x character vector, Dataset name, or complete id string if `table` is NULL.
#' @param table character, Table name.
#' @export
robonomist_id <- function(x = character(), table = NULL) {
  x <- vec_cast(x, character())
  if (!is.null(table)) {
    l <- vec_recycle_common(x, table)
    x <- paste0(l[[1]], "/", l[[2]])
  }
  x <- enc2utf8(x)
  validate_robonomist_id(x)
  new_robonomist_id(x)
}

#' @describeIn robonomist_id Constructor for robonomist_id class
#'
#' @export
new_robonomist_id <- function(x = character()) {
  vec_assert(x, character())
  new_vctr(x, class = "robonomist_id")
}

validate_robonomist_id <- function(x) {
  if (all(x == "__NA__") || all(x == "NA")) {
    ## Workaround for inline tables in Rmd's
    return()
  }
  stopifnot(
    nchar(x) > 2,
    !grepl("(\u00a7| |#)", x),
    grepl("/", x)
  )
}

#' @export
vec_ptype_abbr.robonomist_id <- function(x, ...) {
  "r_id"
}

#' @export
vec_ptype2.robonomist_id.robonomist_id <- function(x, y, ...) new_robonomist_id()
#' @export
vec_ptype2.robonomist_id.character <- function(x, y, ...) new_robonomist_id()
#' @export
vec_ptype2.character.robonomist_id <- function(x, y, ...) new_robonomist_id()

#' @export
vec_cast.robonomist_id.robonomist_id <- function(x, to, ...) x
#' @export
vec_cast.robonomist_id.character <- function(x, to, ...) robonomist_id(x)
#' @export
vec_cast.character.robonomist_id <- function(x, to, ...) vec_data(x)

#' @export
vec_ptype2.list.robonomist_id <- function(x, y, ...) list()
#' @export
vec_cast.list.robonomist_id <- function(x, to, ...) {
  x <- vec_cast(x, character())
  i <- regexpr("/", x)
  list(
    dataset = substr(x, 1L, i - 1L),
    table = substr(x, i + 1L, nchar(x))
  )
}
#' @export
vec_ptype2.robonomist_id.list <- function(x, y, ...) list()
#' @export
vec_cast.robonomist_id.list <- function(x, to, ...) {
  robonomist_id(x$dataset, x$table)
}
#' @export
as.list.robonomist_id <- function(x, ...) {
  vec_cast(x, list())
}

#' Cast object into a robonomist id
#'
#' @param x object to be cast
#' @export
as_robonomist_id <- function(x) {
  vec_cast(x, robonomist_id())
}

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.robonomist_id <- function(x, ...) {
  out <-
    paste0(
      crayon::blue(robonomist_dataset(x)), "/",
      crayon::cyan(robonomist_table(x))
    )
  extent <- pillar::get_max_extent(out)
  pillar::new_pillar_shaft_simple(out,
    align = "left",
    width = extent, min_width = min(extent, 40L)
  )
}

#' @describeIn robonomist_id Extract dataset component from robonomist_id
#' @export
robonomist_dataset <- function(x) {
  x <- vec_cast(x, character())
  i <- regexpr("/", x)
  substr(x, 1L, i - 1L)
}

#' @describeIn robonomist_id Extract table component from robonomist_id
#' @export
robonomist_table <- function(x) {
  x <- vec_cast(x, character())
  i <- regexpr("/", x)
  substr(x, i + 1L, nchar(x))
}

#' Extract components of robonomist_id with $-operator
#'
#' @param x robonomist_id
#' @param ... for compatibility
#' @export
`$.robonomist_id` <- function(x, ...) {
  switch(list(...)[[1]],
    table = robonomist_table(x),
    dataset = robonomist_dataset(x),
    stop('$ operator can extract only "table" or "dataset" from robonomist_id')
  )
}
