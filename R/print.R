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
    character()
  } else {
    NextMethod()
  }
}

#' @export
print.robonomist_search <- function(x, n = getOption("robonomistClient.search_print_n", 30), ...) {
  NextMethod(n = n)
}


## robonomist_datasources

#' Create a robonomist_datasources object for tidy printing
#' @param x A data.frame with columns `id`, `title`, and `langugages`
#' @keywords internal
as_robonomist_datasources <- function(x) {
  class(x$dataset) <- c("robonomist_dataset_id", class(x$dataset))
  class(x$title) <- c("robonomist_datasource_title", class(x$title))
  class(x$languages) <- c("robonomist_languages", class(x$languages))
  class(x) <- c("robonomist_datasources", class(x))
  x
}


#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_datasources <- function(x, ...) {
  "Robonomist Server Datasources"
}

#' @export
print.robonomist_datasources <- function(x, n = getOption("robonomistClient.datasources_print_n", 30), ...) {
  NextMethod(n = n)
}

#' @importFrom pillar get_max_extent new_pillar_shaft_simple
#' @export
pillar_shaft.robonomist_dataset_id <- function(x, ...) {
  out <- crayon::blue(x)
  extent <- get_max_extent(out)
  new_pillar_shaft_simple(
    out,
    align = "left",
    width = extent, min_width = min(extent, 15L)
  )
}

#' @export
vec_ptype_abbr.robonomist_dataset_id <- function(x, ...) {
  "r_dataset"
}

#' @export
pillar_shaft.robonomist_datasource_title <- function(x, ...) {
  extent <- get_max_extent(x)
  new_pillar_shaft_simple(
    x,
    align = "left",
    width = extent, min_width = min(extent, 40L)
  )
}

#' @export
vec_ptype_abbr.robonomist_datasource_title <- function(x, ...) {
  "chr"
}

#' @export
pillar_shaft.robonomist_languages <- function(x, ...) {
  out <- lapply(x, paste, collapse = ",") |> unlist()
  pillar::new_pillar_shaft_simple(out)
}

#' @export
vec_ptype_abbr.robonomist_languages <- function(x, ...) {
  "iso2"
}
