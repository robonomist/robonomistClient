#' Search and get data from Robonomist Data Server
#'
#' @description
#' `data()` is a convenience function that searches the database and returns
#' 1. search results if multiple matching tables are found, and
#' 2. data if only one match is found.
#'
#' @details The `data()` function allows for a special \code{§}-filter. When the pattern matches a single table and the function returns a data frame, the \code{§}-filter can be used to subset rows of data frame. The tibble is filterd by sequence of regular expressions separated by section sign \code{§}. The regular expression are applied to data frame's variables sequentially.
#'
#' If the last variable is a date, it is used as a start date filter.
#'
#' @param pattern string, Search query or table id, possibly followed by a \code{§}-filter.
#' @param dl_filter list or named vector passed to datasource download functions for filtering incoming data. Supported by tulli, OECD and ECB.
#' @param labels logical, Some datasources can return labelled or coded data.
#' @param lang Two-letter language code, e.g. "en" or "sv".
#' @param na.rm Px-file based datasources return a table with a combination of all categories. Missing values can be filtered when reading the file to improve preformance.
#' @param ... Datasource-specific arguments. TODO 
#'
#' @export
data <- function(pattern = "", dl_filter = NULL, labels = TRUE,
                 lang = NULL, na.rm = FALSE, ...) {
  do_request("data", c(as.list(environment()), list(...)))
}

#' Get data for table id
#'
#' @description
#' `data_get()` returns data without performing searching or pattern filters. It will fail, if no match exists.
#'
#' @param id string, Exact table id
#' @rdname data
#' @export
data_get <- function(id, dl_filter = NULL, labels = TRUE, lang = NULL, na.rm = FALSE, ...) {
  do_request("get", c(as.list(environment()), list(...)))
}

#' Search for data
#'
#' @description
#' `data_search()` only performs a search and returns the results.
#'
#' @rdname data
#' @export
data_search <- function(pattern = "") {
  do_request("search", as.list(environment()))
}


#' Vintage of table, i.e. datetime of the latest update
#'
#' @param id string, Exact table id
#' @return named character vector. For original data tables the value will be a scalar.
#'
#' @export
data_vintage <- function(id) {
  do_request("vintage", as.list(environment()))
}

#' Metadata of table
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' The output of this function is likely to change. Currently works only with px-based tables.
#'
#' @param id, Exact table id
#' @param lang Two-letter language code, e.g. "en" or "sv".
#' @return List of metadata
#'
#' @export
data_metadata <- function(id, lang = NULL) {
  do_request("metadata", as.list(environment()))
}

#' List available datasources
#'
#' @export
datasources <- function() {
  do_request("datasources", list())
}

#' @keywords internal
do_request <- function(fun, args) {

  if (!is.null(getOption("robonomist.server"))) {
    connection$send(fun, args)
  } else if (requireNamespace("robonomistServer")) {
    cli_progress_step("Requesting {fun} locally")
    do.call(fun, args, env = robonomistServer::database)
  } else {
    please_set_server()
    stop("Robonomist Data Server unavailable.", call. = FALSE)
  }
}
