#' @importFrom vctrs vec_ptype_abbr
#' @export
vec_ptype_abbr.collect <- function(x, ...) {
  "collect"
}

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.collect <- function(x, ...) {
  out <- format(x)
  pillar::new_pillar_shaft_simple(out, align = "right", min_width = 9)
}

#' @export
dimnames.tbl_lazy_api <- function(x) {
  list(NULL, x$vars)
}

#' @export
dim.tbl_lazy_api <- function(x) {
  c(prod(unlist(lapply(x$x, nrow), use.names = FALSE)), length(x$ns))
}


#' @export
distinct.tbl_lazy_api <- function(.data, ..., .keep_all = FALSE) {
  if (rlang::dots_n(...) > 0) {
    if (.keep_all) {
      stop(
        "Can only find distinct value of specified columns if .keep_all is FALSE",
        call. = FALSE
      )
    }
    dots <- ensyms(...)
    data_context <- purrr::map2(.data$x, .data$var_types, ~.x[[.y]])
    if("time" %in% as.character(dots))
      data_context$time <- unique(data_context$time)
    with(tidyr::expand_grid(!!!dots), data = data_context)
  } else {
    .data
  }
}


#' @export
collect.tbl_lazy_api <- function(x, ...) {
  data_get(x$src, dl_filter = x)
}

#' @export
as.data.frame.tbl_lazy_api <- function(x, ...) {
  collect(x)
}

#' @export
select.tbl_lazy_api <- function(.data, ...) {
  dplyr::select(collect(.data), ...)
}

#' @export
relocate.tbl_lazy_api <- function(.data, ...) {
  dplyr::relocate(collect(.data), ...)
}

#' @export
rename.tbl_lazy_api <- function(.data, ...) {
  dplyr::rename(collect(.data), ...)
}

#' @export
summarise.tbl_lazy_api <- function(.data, ...) {
  dplyr::select(collect(.data), ...)
}

#' @export
group_by.tbl_lazy_api <- function(.data, ...) {
  dplyr::group_by(collect(.data), ...)
}

#' @export
transmute.tbl_lazy_api <- function(.data, ...) {
  dplyr::transmute(collect(.data), ...)
}

#' @export
mutate.tbl_lazy_api <- function(.data, ...) {
  dplyr::mutate(collect(.data), ...)
}

#' @export
arrange.tbl_lazy_api <- function(.data, ...) {
  dplyr::arrange(collect(.data), ...)
}

## #' @export
## names.tbl_lazy_api <- function(x) x$vars

#' @export
`names<-.tbl_lazy_api` <- function(x, value) {
  y <- collect(x)
  `names<-`(y, c(value, names(y)[-(1:length(value))]))
}

