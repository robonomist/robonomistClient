#' @export
print.tbl_lazy_oecd <- function(x, n = 10L, ...) {

  categories_needed <- function(ns, n_target) {
    rns <- rev(ns)
    cpns <- cumprod(rns)
    sel <- rep(1, length(ns))
    for(i in seq_along(rns)) {
      if(cpns[i] < n_target) {
        sel[i] <- rns[i]
      } else {
        p <- cpns[i]/rns[i]
        sel[i] <- ceiling(n_target / p)
        break
      }
    }
    rev(sel)
  }

  has_time <- all(c("Frequency", "time") %in% names(x$x))

  if (has_time) {
    ## Filter out incompatible dates
    time_cols <-
      inner_join(x$x$Frequency,
                 select(x$x$time, date_type, time),
                 by = c("code" = "date_type")) |>
      select(x$var_types["Frequency"], time)
    not_time <- setdiff(names(x$x), c("Frequency", "time"))
    n_categories <- c(purrr::map_int(x$x[not_time], nrow), nrow(time_cols))
    sel <- categories_needed(n_categories, n)
    dims <- purrr::pmap(
      list(.x = x$x[not_time], .y = sel[1:length(not_time)], .z = x$var_types[not_time]),
      function(.x, .y, .z) .x[1:.y,][[.z]])
    r <- tidyr::crossing(tidyr::expand_grid(!!!dims), time_cols)
    n_rows <- prod(n_categories)
  } else {
    sel <- categories_needed(x$ns, n)
    dims <- purrr::pmap(list(.x = x$x, .y = sel, .z = x$var_types),
                 function(.x, .y, .z) .x[1:.y, ][[.z]])
    r <- tidyr::expand_grid(!!!dims)
    n_rows <- prod(purrr::map_int(x$x, nrow))
  }
  r <- mutate(r, value = vctrs::new_vctr("??", class = "collect"))
  if (has_time) r <- arrange(r, time)

  attr(r, "n_rows") <- n_rows
  attr(r, "title") <- x$title
  attr(r, "robonomist_id") <- attr(x, "robonomist_id")
  class(r) <- c("robonomist_data", "lazy_oecd_printout", class(r))
  print(r, n = min(n, length(r[[1]])))
  invisible(x)
}

#' @importFrom pillar tbl_sum
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

#' @importFrom dplyr filter
#' @export
filter.tbl_lazy_oecd <- function(.data, ..., .preserve = FALSE) {
  if (!identical(.preserve, FALSE)) {
    stop("`.preserve` is not supported on database backends", call. = FALSE)
  }
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

  data_context <- purrr::map2(.data$x, .data$var_types, ~.x[[.y]])
  .data$x <-
    purrr::imap(.data$x, function(x, y) {
      if(y %in% filtered_vars) {
        i <- match(y, filtered_vars)
        x[rlang::eval_tidy(dots[[i]], data_context), ]
      } else {
        x
      }
    })
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

