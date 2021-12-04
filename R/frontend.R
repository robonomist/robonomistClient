#' Vintage of table, i.e. datetime of the latest update
#'
#' @return named character vector. For original data tables the value will be a scalar. For tidy tables, 
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
#' @return List of metadata
#'
#' @export
data_metadata <- function(id, lang = NULL) {
  do_request("metadata", as.list(environment()))
}

#' Get data for table id
#'
#' Returns the objects without performing searching or pattern filters. Fails if no match exists.
#'
#' @param id string. Exact table id
#' @export
data_get <- function(id, dl_filter = NULL, labels = TRUE, lang = NULL, na.rm = FALSE, ...) {
  do_request("get", c(as.list(environment()), list(...)))
}

#' Search for data
#'
#' @return Vector of ids
#' @export
data_search <- function(pattern = "") {
  do_request("search", as.list(environment()))
}

#' List available datasources
#' 
#' @export
datasources <- function() {
  do_request("datasources", list())
}

#' Get data from Robonomist database
#'
#' @description Convenience api that searches when multiple table id matches are found and filters the table using the section pattern
#'
#' @param pattern string, A sequence of regular expressions separated by section sign \code{§}, which are used to filter the database. The first expression in the sequence is matched to a table id. The following expressions match to table variables in sequence. If the last variable is a date, it is used as start date filter.
#' @param dl_filter list or named vector passed to datasource download functions for filtering incoming data. Supported by tulli, OECD and ECB.
#' @param labels logical. Some datasources can return labelled or coded data.
#' @param lang Two-letter language code, e.g. "en" or "sv".
#' @param na.rm Px-file based datasources return a table with a combination of all categories. Missing values can be filtered when reading the file to improve preformance.
#'
#' @export
data <- function(pattern = "", dl_filter = NULL, labels = TRUE,
                  lang = NULL, na.rm = FALSE, ...) {
  do_request("data", c(as.list(environment()), list(...)))
}

