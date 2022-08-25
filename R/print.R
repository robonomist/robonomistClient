
## robonomist_search

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_search <- function(x, ...) {
  if (nrow(x) > 0) "Robonomist Database search results"
}

#' @export
#' @importFrom pillar tbl_format_footer
tbl_format_footer.robonomist_search <- function(x, setup, ...) {
  if (nrow(x) == 0) {
    cli::cli_alert_danger("No matches found.")
    NULL
  } else {
    NextMethod()
  }
}

## #' @export
## #' @importFrom pillar ctl_new_pillar pillar_component new_pillar_component new_pillar_shaft_simple
## ctl_new_pillar.robonomist_search <- function(controller, x, width, ..., title = NULL) {
##   if (title == "id") {
##     extent <- pillar::get_max_extent(x)
##     y <- new_pillar_component(
##       list(pillar::new_pillar_shaft_simple(crayon::cyan(x))),
##       width = extent, min_width = min(extent, 40L))
##   } else {
##     y <- pillar_component(new_pillar_shaft_simple(x, min_width = 30L))
##   }
##   pillar::new_pillar(list(
##     title = pillar_component(pillar::new_pillar_title(title)),
##     data = y
##   ))
## }

#' @export
print.robonomist_search <- function(x, n = 30, ...) {
  NextMethod(n = n)
}


## robonomist_datasources

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_datasources <- function(x, ...) {
  "Robonomist Server Datasources"
}

#' @export
#' @importFrom pillar ctl_new_pillar pillar_component new_pillar_component
ctl_new_pillar.robonomist_datasources <- function(controller, x, width, ..., title = NULL) {
  if (!is.null(title) && title == "dataset") {
    extent <- pillar::get_max_extent(x)
    y <- new_pillar_component(
      list(pillar::new_pillar_shaft_simple(crayon::blue(x))),
      width = extent, min_width = min(extent, 40L))
  } else {
    y <- pillar_component(pillar::new_pillar_shaft_simple(x, min_width = 30L))
  }
  pillar::new_pillar(list(
            title = pillar_component(pillar::new_pillar_title(title)),
            data = y
          ))
}

#' @export
print.robonomist_datasources <- function(x, n = 50, ...) {
  NextMethod(n = n)
}


## robonomist_data

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_data <- function(x, ...) {
  default_header <- NextMethod()
  c("Robonomist id" = crayon::cyan(attr(x, "robonomist_id")),
    "Title" = attr(x, "robonomist_title"),
    "Vintage" = if(is.na(default_header["Last updated"]))
      as.character(attr(x, "robonomist_vintage")),
    default_header)
}

## px

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.px <- function(x, ...) {
  header <- NextMethod()
  lang <- attr(x, "output_language") %||% 1L
  ## if (is.null(lang)) lang <- 1L
  c("Last updated" = as.character(attr(x, "last-updated")[[lang]][[1]]),
    "Next update" = as.character(attr(x, "next-update")),
    header)
}

## eurostat

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.eurostat <- function(x, ...) {
  header <- NextMethod()
  tf <- if (!is.null(y <- attr(x, "time_frame_code"))) {
    paste(y, collapse = "-")
  }
  c(`Time frame` = tf, header)
}


