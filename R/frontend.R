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
#' Some datasources (e.g. datasets "ecb" & "tulli") do not allow downloading full data tables, nor is it always preferred due to the large large size of table. For these datasources the user must provide a download filter via the `dl_filter` argument. When the argument is left as `NULL`, the  `data` function will return a list of variables and potential values. This list can be used to construct a suitable download filter.
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
#' ## Return information on the data table structure
#' data("ecb/AME")
#' ## Example of download filter
#' data("ecb/AME", dl_filter = list(ame_ref_area = "FIN"))
#'
#' data(
#'   "ecb/FM",
#'   dl_filter = list(
#'     freq = "M",
#'     provider_fm_id = "EURIBOR1YD_"
#'   )
#' )
#' data("ecb/FM", dl_filter = "M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA")
#'
#' data("tulli/uljas_cpa2008",
#'   dl_filter = list(
#'     "Tavaraluokitus CPA2008_2" = "*A-X",
#'     "Aika" = c("201505", "201506"),
#'     "Maa" = "=ALL",
#'     "Suunta" = "=FIRST 1",
#'     "Indikaattorit" = "=FIRST 1"
#'   )
#' )
#' }
#' @rdname data
#  Workaround: pkgdown interprets `data` function as a dataset, so the "a" in data is a homoglyph.
#' @usage dаta(
#'   pattern = "",
#'   dl_filter = NULL,
#'   labels = getOption("robonomistClient.labels"),
#'   lang = NULL,
#'   na.rm = FALSE,
#'   tidy_time = getOption("robonomistClient.tidy_time"),
#'   ...
#'  )
#' @export
data <- function(pattern = "",
                 dl_filter = NULL,
                 labels = getOption("robonomistClient.labels"),
                 lang = NULL,
                 na.rm = FALSE,
                 tidy_time = getOption("robonomistClient.tidy_time"),
                 ...) {
  pattern <- as.character(pattern)
  stopifnot(is.null(lang) || is.character(lang))
  stopifnot(is.null(tidy_time) || is.logical(tidy_time))
  args <- c(as.list(environment()), list(...)) |> purrr::compact()
  do_request("data", args)
}

#' Get data for table id
#'
#' @description
#' `data_get()` returns data without performing searching or pattern filters. In production code it is better to use `data_get()` instead of `data()` as it slightly faster and does not depend on the search mechanism.  `data_get()` will result in error, if no match exists.
#'
#' @param id, string, Exact robonomist_id
#' @rdname data
#' @export
data_get <- function(id,
                     dl_filter = NULL,
                     labels = getOption("robonomistClient.labels"),
                     lang = NULL,
                     na.rm = FALSE,
                     tidy_time = getOption("robonomistClient.tidy_time"),
                     ...) {
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


#' Vintage of a table, i.e. POSIXct-class datetime of the latest update
#'
#' @description
#' The vintage indicates the time when the table of was last updated, if this information is provided by the datasource, which is not allways the case. If that time of the last update is not available, the vintage will be the time of last scheduled an update for the data table. In such cases the vintage might change without any actual changes in the data, as we have reloaded the data to check if there has been any changes.
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
#' @param lang, Two-letter language code, e.g. "en" or "sv".
#' @return List of metadata
#'
#' @export
data_metadata <- function(id, lang = NULL) {
  do_request("metadata", as.list(environment()))
}

#' List available datasources
#'
#' @param lang, Two-letter language code, e.g. "en" or "sv".
#' @param available_only, If TRUE (default), then list only those datasources which are available for the current subscription.
#' @export
datasources <- function(lang = NULL, available_only = TRUE) {
  ds <-
    if (protocol_version() >= package_version("2.9.11")) {
      do_request("datasources", list(lang = lang))
    } else {
      do_request("datasources", list())
    }
  if (available_only) {
    ds <- ds[ds$available, ]
  }
  ds
}

#' Structured menu of available datasources and data tables
#'
#' @param datasource, character, Datasource name
#' @param lang, Two-letter language code, e.g. "en" or "sv".
#' @return Nested list of datasource_menu and datasource_menu_item objects
#' @export
datasource_menu <- function(datasource = NULL, lang = NULL) {
  do_request("datasource_menu", as.list(environment()))
}

#' @keywords internal
do_request <- function(fun, args) {
  switch(server_mode(),
    remote = connection$send(fun, args),
    local = do.call(fun, args, envir = robonomistServer::database),
    unavailable = {
      please_set_server()
      stop("Robonomist Data Server unavailable.", call. = FALSE)
    }
  )
}
