expand_tbl_lazy_oecd_v3 <- function(x) {
  opts <- x$options
  col_type <- if (opts$variable_labels) "name" else "id"
  value_type <- if (opts$labels) "name" else "id"
  time_type <- if (opts$tidy_time) "time" else if (labels) "name" else "id"
  tbl <-
    readr::read_delim(
      I(names(x$series) %||% x$observations),
      delim = ":",
      col_types = cols(.default = col_integer()),
      col_names = x$dimensions[[col_type]]
    )

  if (!is.null(x$series)) {
    tbl <-
      tbl |>
      dplyr::mutate(time = unname(x$series)) |>
      unnest(time) |>
      dplyr::mutate(time = x$series_dimension$values[[time_type]][time+1L])
  }

  col_names <- x$dimensions[[col_type]]
  tbl[col_names] <-
    purrr::imap(tbl[col_names], ~{
      i <- match(.y, x$dimensions[[col_type]])
      x$dimensions$values[[i]][[value_type]][.x+1L]
    })

  tbl$value <- vctrs::new_vctr("??", class = "collect")
  tbl
}


#' @export
print.tbl_lazy_oecd_v3 <- function(x, ...) {
  tbl <- expand_tbl_lazy_oecd_v3(x)
  class(tbl) <- c("tbl_lazy_oecd_v3_printout", "robonomist_data", class(tbl))
  attr(tbl, "title") <- x$title
  attr(tbl, "robonomist_id") <- x$id
  print(tbl, ...)
}

#' @importFrom pillar tbl_sum
#' @export
tbl_sum.tbl_lazy_oecd_v3_printout <- function(x, ...) {
  default_header <- NextMethod()
  c("Robonomist id" = crayon::cyan(attr(x, "robonomist_id")),
    "Title" = attr(x, "title"),
    "OECD_v3" = "Uncollected data structure",
    default_header )
}

#' @importFrom pillar tbl_format_footer style_subtle
#' @export
tbl_format_footer.tbl_lazy_oecd_v3_printout <- function(x, setup, ...) {
  default_footer <- NextMethod()
  extra_info <-
    "# This data has not yet been collected from OECD api, and all rows might not be available. Please use `filter()` to limit the number of rows under a million, and use `collect()` to retrieve actual data."
  c(default_footer, extra_info)
}

#' @importFrom dplyr filter
#' @export
filter.tbl_lazy_oecd_v3 <- function(.data, ..., .preserve = FALSE) {
  ## dots <- rlang::enexprs(...)
  .data$ops <- .data$ops |> append(
    list(function(.data) {
      filter(.data, ..., .preserve = .preserve)
    })
  )
  loc <- dplyr:::filter_rows(expand_tbl_lazy_oecd_v3(.data), ..., caller_env = rlang::caller_env())
  .data$series <-
    purrr::map2(.data$series, cumsum(purrr::map_int(unname(.data$series), length)), ~{
      i <- loc[(.y-length(.x)+1L):.y]
      if (any(i)) .x[i]
    }) |> purrr::compact()
  .data
}

#' @importFrom dplyr collect
#' @export
collect.tbl_lazy_oecd_v3 <- function(x, ...) {

  if (nrow(x) == 0) {
    cli::cli_inform("Requesting zero rows, nothing to collect.")
    tbl <- expand_tbl_lazy_oecd_v3(x)
    tbl$value <- double()
    return(tbl)
  }
  opts <- x$options
  col_type <- if (opts$variable_labels) "name" else "id"
  value_type <- if (opts$labels) "name" else "id"
  time_type <- if (opts$tidy_time) "time" else if (labels) "name" else "id"

  f_length <- function(values) sum(nchar(values)) + length(values) - 1L

  values <-
    readr::read_delim(
      I(names(x$series) %||% x$observations),
      delim = ":",
      col_types = cols(.default = col_integer()),
      col_names = x$dimensions[[col_type]]
    ) |>
    purrr::map(unique) |>
    purrr::imap_dfr(~{
      i <- match(.y, x$dimensions[[col_type]])
      dim <- x$dimensions$values[[i]]
      values <- if (nrow(dim) == length(.x)) "" else dim$id[.x+1L]
      list(
        values = list(values),
        nchar = f_length(values)
      )
    })

  query_limit <- 1000L - 39L - nchar(x$src$table)

  too_long <- function(values) {
    sum(values$nchar) + nrow(values) - 1L > query_limit
  }

  if (too_long(values)) {
    values <- values |>
      dplyr::mutate(
        values = purrr::map2(values, nchar, ~{if (.y > query_limit) "" else .x}),
        nchar  = purrr::map_int(values, f_length)
      )
  }

  while (too_long(values)) {
    i <- which.max(values$nchar)
    values <-
      values |>
      dplyr::mutate(
        values = imap(values, ~{if (.y == i) "" else .x}),
        nchar = map_int(values, f_length)
      )
  }

  string_filter <-
    values$values |>
    purrr::map_chr(~paste(.x, collapse = "+")) |>
    paste(collapse = ".")

  y <-
    data_get(
      id = x$src,
      dl_filter = string_filter,
      labels = x$options$labels,
      variable_labels = x$options$variable_labels,
      tidy_time = x$options$tidy_time,
      )

  ## Rerun ops in case extra data was received
  for(i in x$ops) y <- i(y)

  y
}

#' @export
dim.tbl_lazy_oecd_v3 <- function(x) {
  has_series <- is.null(x$series)
  c(
    if (has_series) length(x$observation) else sum(purrr::map_int(x$series, length)),
    length(x$dimensions$values) + if(has_series) 2L else 1L
  )
}

#' @export
dimnames.tbl_lazy_api <- function(x) {
  col_type <- if (x$options$variable_labels) "name" else "id"
  list(NULL, c(x$dimensions[[col_type]], "time", "value"))
}

#' @export
distinct.tbl_lazy_api <- function(.data, ..., .keep_all = FALSE) {
  expand_tbl_lazy_oecd_v3(.data) |>
    dplyr::distinct(..., .keep_all = .keep_all)
}
