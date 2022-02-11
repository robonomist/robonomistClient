#' Search and get data from Robonomist Data Server
#'
#' @description
#' `data()` is a convenience function that searches the database and returns
#' 1. search results if multiple matching tables are found, and
#' 1. data if only one match is found.
#'
#' @details # `§`-filter
#' The `data()` function allows for a special \code{§}-filter. When the pattern matches a single table and the function returns a data frame, the \code{§}-filter can be used to subset rows of data frame. The tibble is filterd by sequence of regular expressions separated by section sign \code{§}. The regular expression are applied to data frame's variables sequentially.
#'
#' If the last variable is a date, it is used as a start date filter.
#'
#' @details # Download filter
#' Some datasources (e.g. ECB & Tulli) do not allow downloading full data tables, nor is it always preferred due to large table size. For these datasources the user must provide a download filter via the `dl_filter` argument. When the argument is left as `NULL`, the  `data` function will return a list of variables and potential values. This list can be used to construct a suitable download filter.
#'
#' Generally, `dl_filter` should be named list where names are variable names and values character vectors of selected values (see Examples). Alternatively, some datasources allow for a dot-separated string to define a download filter.
#'
#' @param pattern string, Search query or table id, possibly followed by a \code{§}-filter.
#' @param dl_filter list or named vector passed to datasource download functions for filtering incoming data. Supported by tulli, OECD and ECB.
#' @param labels logical, Some datasources can return labelled or coded data.
#' @param lang Two-letter language code, e.g. "en" or "sv".
#' @param na.rm Px-file based datasources return a table with a combination of all categories. Missing values can be filtered when reading the file to improve preformance.
#' @param tidy_time logical, If TRUE, the time dimension is parsed into Date class and renamed `time`. If NULL, the datasource specific default will be used.
#' @param ... Datasource-specific arguments. TODO
#'
#' @examples
#' \dontrun{
#'  ## Return information on the data table structure
#'  data("ecb/AME")
#'  ## Example of download filter
#'  data("ecb/AME", dl_filter = list(ame_ref_area = "FIN"))
#'
#'  data(
#'    "ecb/FM",
#'    dl_filter = list(freq = "M",
#'                     provider_fm_id = "EURIBOR1YD_")
#'  )
#'  data("ecb/FM", dl_filter = "M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA")
#'
#'  data("tulli/uljas_cpa2008",
#'       dl_filter = list("Tavaraluokitus CPA2008_2" = "*A-X",
#'                        "Aika" = c("201505", "201506"),
#'                        "Maa" = "=ALL",
#'                        "Suunta" = "=FIRST 1",
#'                        "Indikaattorit" = "=FIRST 1"))
#' }
#'
#' @export
data <- function(pattern = "", dl_filter = NULL, labels = TRUE,
                 lang = NULL, na.rm = FALSE, tidy_time = NULL, ...) {
  pattern <- as.character(pattern)
  stopifnot(is.null(lang) || is.character(lang))
  stopifnot(is.null(tidy_time) || is.logical(tidy_time))
  args <- c(as.list(environment()), list(...)) |> purrr::compact()
  do_request("data", args)
}

#' Get data for table id
#'
#' @description
#' `data_get()` returns data without performing searching or pattern filters. It will fail, if no match exists.
#'
#' @param id string, Exact table id
#' @rdname data
#' @export
data_get <- function(id, dl_filter = NULL, labels = TRUE, lang = NULL, na.rm = FALSE, tidy_time = NULL, ...) {
  args <- c(as.list(environment()), list(...)) |> purrr::compact()
  do_request("get", args)
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
    do.call(fun, args, envir = robonomistServer::database)
  } else {
    please_set_server()
    stop("Robonomist Data Server unavailable.", call. = FALSE)
  }
}
