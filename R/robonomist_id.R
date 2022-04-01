#' @export
new_robonomist_id <- function(x = character()) {
  vec_assert(x, character())
  new_vctr(x, class = "robonomist_id")
}

validate_robonomist_id <- function(x) {
  stopifnot(
    nchar(x) > 2,
    !grepl("(§| |#)", x)#,
    ## grepl("^[a-zA-Z0-9_-]*$", x)
  )
}

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

#' @export
as_robonomist_id <- function(x) {
  vec_cast(x, robonomist_id())
}

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.robonomist_id <- function(x, ...) {
  l <- vec_cast(x, list())
  out <-
    paste0(
      crayon::blue(l$dataset), "/",
      crayon::cyan(l$table)
    )
  extent <- pillar::get_max_extent(out)
  pillar::new_pillar_shaft_simple(out, align = "left",
                                  width = extent, min_width = min(extent, 40L))
}

#' @export
robonomist_dataset <- function(x) {
  x <- vec_cast(x, character())
  i <- regexpr("/", x)
  substr(x, 1L, i - 1L)
}

#' @export
robonomist_table <- function(x) {
  x <- vec_cast(x, character())
  i <- regexpr("/", x)
  substr(x, i + 1L, nchar(x))
}

#' @export
`$.robonomist_id` <- function(x, ...) {
  switch(
    list(...)[[1]],
    table = robonomist_table(x),
    dataset = robonomist_dataset(x),
    stop('$ operator can extract only "table" or "dataset" from robonomist_id')
  )
}

