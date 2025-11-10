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
#' @param pattern Character. Search query or table id, possibly followed by a \code{§}-filter.
#' @param dl_filter List or named vector. The download filter is passed to datasource download functions to filter data before download. See Details.
#' @param labels Logical. If FALSE, then variable values are returned as codes instead of labels.
#' @param lang Two-letter language code, e.g. "en" or "sv".
#' @param na.rm Logical. If TRUE, and supported by the datasource, missing values are removed from the returned data frame upon retrieval.
#' @param tidy_time Logical. If TRUE, the time dimension is parsed into Date class and renamed `time`. If NULL, the datasource specific default will be used.
#' @param ... Other arguments passed to datasource download functions.
#'
#' @examples
#'
#' # Search for datasets matching pattern:
#' data("consumer indicator")
#'
#' ## Limit your search to a specific dataset by providing
#' ## the dataset name and a slash as prefix:
#' data("ec/ consumer indicator")
#'
#' ## Download data by providing exact table id:
#' data("ec/consumer")
#'
#' ## With time series based datasets you can retrieve the time series
#' ## using the source's id:
#' data("ecb/FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA")
#'
#' ## Alternatively, you can copy the full URL from the source's website:
#' data("https://data.ecb.europa.eu/data/datasets/FM/FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA")
#'
#' ## Most time series datasets also support wildcards. For example,
#' ## in case of ECB, you can leave a part of the series id unspecified:
#' data("ecb/FM.M.U2.EUR.RT.MM..HSTA")
#'
#' ## If the data table too large to download in full, you may need to
#' ## provide a download filter. First get the available variables and values:
#' data("ecb/AME") |> str()
#'
#' ## Then provide a suitable filter to download data:
#' data("ecb/AME", dl_filter = list(ame_ref_area = "FIN"))
#'
#' ## Another example with Finish Customs dataset:
#' data("tulli/uljas_cpa2008",
#'   dl_filter = list(
#'     "Tavaraluokitus CPA2008_2" = "*A-X",
#'     "Aika" = c("201505", "201506"),
#'     "Maa" = "=ALL",
#'     "Suunta" = "=FIRST 1",
#'     "Indikaattorit" = "=FIRST 1"
#'   )
#' )
#'
#' ## Using §-filter to filter data after download:
#' data("ec/consumer§Fin§Confidence")
#'
#' ## Using §-filter with start date:
#' data("ec/consumer§Fin§Confidence§2020-01-01")
#'
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
  do_request("data", args) |> signal_data_get()
}

#' Get data for table id
#'
#' @description
#'
#' `data_get()` returns data for a given table id without performing searching, url parsing or pattern filters, and is prefered in programmatic use-cases where robustness and speed are important. `data_get()` will result in error, if no match exists.
#'
#' @param id, Character. Exact table id. If multiple ids are provided as a character vector, they are bound row-wise into a single data frame.
#' @export
#' @rdname data
data_get <- function(id,
                     dl_filter = NULL,
                     labels = getOption("robonomistClient.labels"),
                     lang = NULL,
                     na.rm = FALSE,
                     tidy_time = getOption("robonomistClient.tidy_time"),
                     ...) {
  args <- c(as.list(environment()), list(...)) |> purrr::compact()
  do_request("get", args) |> signal_data_get()
}

#' Search for data
#'
#' @description
#' `data_search()` performs a search and returns a list of matching data tables without downloading any data.
#'
#' @rdname data
#' @export
data_search <- function(pattern = "") {
  do_request("search", as.list(environment()))
}


#' Vintage of a data table
#'
#' @description
#'
#' `data_vintage()` returns the latest update time of the specified data tables for the purpose of monitoring data freshness.
#'
#' The vintage indicates the time when the table of was last updated at the source, if such information is provided by the datasource. If the source does not provide vintage information, the vintage will be the time new data was last queried from the source.
#'
#' @param id Character vector, Exact table ids
#' @return Named vector of POSIXct-class datetimes indicating the vintage of each table.
#'
#' @export
data_vintage <- function(id) {
  do_request("vintage", as.list(environment()))
}

#' Metadata of table
#'
#' @description
#'
#' `data_metadata()` returns metadata information about a specific data table. The returned metadata structure depends on the datasource.
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
  as_robonomist_datasources(ds)
}

#' Structured menu of available datasources and data tables
#'
#' @param datasource, Character, Datasource name
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
