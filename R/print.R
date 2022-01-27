
## robonomist_search

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_search <- function(x, ...) {
  cli::cli_h3("Robonomist Database search results"); NULL
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

#' @export
#' @importFrom pillar ctl_new_pillar pillar_component new_pillar_component new_pillar_shaft_simple
ctl_new_pillar.robonomist_search <- function(controller, x, width, ..., title = NULL) {
  if (title == "id") {
    extent <- pillar::get_max_extent(x)
    y <- new_pillar_component(
      list(pillar::new_pillar_shaft_simple(crayon::cyan(x))),
      width = extent, min_width = min(extent, 40L))
  } else {
    y <- pillar_component(new_pillar_shaft_simple(x, min_width = 30L))
  }
  pillar::new_pillar(list(
    title = pillar_component(pillar::new_pillar_title(title)),
    data = y
  ))
}

## robonomist_datasources

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_datasources <- function(x, ...) {
  cli::cli_h3("Robonomist Server Datasources"); NULL
}

#' @export
#' @importFrom pillar ctl_new_pillar pillar_component new_pillar_component
ctl_new_pillar.robonomist_datasources <- function(controller, x, width, ..., title = NULL) {
  if (title == "dataset") {
    extent <- pillar::get_max_extent(x)
    y <- new_pillar_component(
      list(pillar::new_pillar_shaft_simple(crayon::blue(x))),
      width = extent, min_width = min(extent, 40L))
  } else {
    y <- pillar_component(new_pillar_shaft_simple(x, min_width = 30L))
  }
  pillar::new_pillar(list(
            title = pillar_component(pillar::new_pillar_title(title)),
            data = y
          ))
}


## robonomist_data

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_data <- function(x, ...) {
  default_header <- NextMethod()
  c("Robonomist id" = crayon::cyan(attr(x, "robonomist_id")), default_header)
}

## px

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.px <- function(x, ...) {

  header <- NextMethod()

  lang <- attr(x, "output_language")
  if (is.null(lang)) lang <- 1L
  y <- attr(x, "description")[lang]
  z <- attr(x, "contents")[lang]
  if (!is.null(y)) {
    header <- c(header, Title = unname(y))
  } else if (!is.null(z)) {
    header <- c(header, Title = unname(z))
  }
  y <- attr(x, "last-updated")[[lang]][[1]]
  if (!is.null(y))
    header <- c(header, `Last updated` = as.character(y))

  y <- attr(x, "next-update")
  if (!is.null(y))
    header <- c(header, `Next update` = as.character(y))

  header
}

## eurostat

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.eurostat <- function(x, ...) {

  header <- NextMethod()

  c(header,
    Title = attr(x, "title"),
    `Last updated` = attr(x, "robonomist_vintage"),
    `Time frame` = if (!is.null(y <- attr(x, "time_frame_code"))) {
      paste(y, collapse = "-")
    }
    )
}


