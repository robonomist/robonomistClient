#' @import dplyr
#' @export
print.tbl_lazy_oecd <- function(x, n = 10L, ...) {

  type <- c("code", "label")[x$labels+1]

  categories_n <- function(ns) {
    rns <- rev(ns)
    sel <- rep(1, length(ns))
    for(i in seq_along(rns)) {
      p <- prod(sel)
      if(p < n) {
        remaining  <- n %/% p + 1L
        sel[i] <- min(remaining, rns[i])
      }
    }
    rev(sel)
  }

  if("Frequency" %in% names(x$x)) {
    ## Filter out incompatible dates
    time_cols <-
      dplyr::inner_join(x$x$Frequency,
                 select(x$x$time, date_type, time),
                 by = c("code" = "date_type")) %>%
      dplyr::select(Frequency = type, time) %>%
      dplyr::arrange(time)
    not_time <- setdiff(names(x$x), c("Frequency", "time"))
    sel <- categories_n(
      c(x$ns[not_time], nrow(time_cols)))
    dims <- purrr::map2(x$x[not_time], sel[1:length(not_time)], ~.x[1:.y,][[type]])
    c(dims, time_cols)
    r <- tidyr::crossing(tidyr::expand_grid(!!!dims), time_cols)
  } else {
    sel <- categories_n(x$ns)
    types <- dplyr::case_when(names(x$x) == "time" ~ "time", TRUE ~ type)
    dims <- purrr::pmap(list(.x = x$x, .y = sel, .z = types),
                 function(.x, .y, .z) .x[1:.y, ][[.z]])
    r <- tidyr::expand_grid(!!!dims)
  }
  r <- dplyr::mutate(r, value = vctrs::new_vctr("??", class = "collect"))
  attr(r, "n_rows") <- prod(purrr::map_int(x$x, nrow))
  attr(r, "title") <- x$title
  attr(r, "robonomist_id") <- attr(x, "robonomist_id")
  class(r) <- c("robonomist_data", "lazy_oecd_printout", class(r))
  print(r, n = n)
  invisible(x)
}

#' @export
tbl_sum.lazy_oecd_printout <- function(x, ...) {
  c("OECD" = "Uncollected data structure",
    "Title" = attr(x, "title"))
}

#' @importFrom pillar tbl_format_footer style_subtle
#' @export
tbl_format_footer.lazy_oecd_printout <- function(x, setup, ...) {
  default_footer <- NextMethod()
  extra_info <-
    "# This data has not yet been collected from OECD api, and all rows might not be available. Please use `filter` to limit the number of rows under a million,  and use `collect` to retrieve actual data."
  c(default_footer, extra_info)
}

#' @export
dim.lazy_oecd_printout <- function(x) {
  c(attr(x, "n_rows"), length(x))
}


#' @export
filter.tbl_lazy_oecd <- function(.data, ..., .preserve = FALSE) {
  if (!identical(.preserve, FALSE)) {
    stop("`.preserve` is not supported on database backends", call. = FALSE)
  }
 #browser()
  dots <- quos(...)
  vars <- .data$vars

  getAST <- function(x) purrr::map_if(as.list(x), is.call, getAST)
  symbols <- purrr::map(rlang::exprs(...), ~as.character(purrr::keep(unlist(getAST(.x)), is.symbol)))
  filtered_vars <-
    purrr::map_chr(symbols, function(x) {
      i <- which(purrr::map_lgl(vars, ~any(x == .x)))
      if(length(i) != 1)
        stop("Filtering expressions must contain exactly one table variable.", call.=F)
      vars[i]
    })

  type <- c("code", "label")[.data$labels+1]
  type <- dplyr::case_when(filtered_vars == "time" ~ "time", TRUE ~ type)
  for(i in seq_along(filtered_vars)) {
    keep_rows <- rlang::eval_tidy(dots[[i]], purrr::map(.data$x, type[i]))
    .data$x[[filtered_vars[i]]] <- .data$x[[filtered_vars[i]]][keep_rows, ]
  }
  .data
}

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_oecd_data <- function(x, ...) {
  header <- NextMethod()
  y <- attr(x, "oecd_title", exact = FALSE)
  if (!is.null(y))
    header <- c(header, Title = unname(y))
}

