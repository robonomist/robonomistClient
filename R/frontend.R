#' Vintage of table, i.e. datetime of the latest update
#'
#' @return character vector
#'
#' @export
data_vintage <- function(id) {
  do_request("vintage", as.list(environment()))
}

#' Metadata of table
#'
#' Currently works only with px-based tables
#' @param String, exact id of table
#' @return List of metadata
#'
#' @export
data_metadata <- function(id) {
  do_request("metadata", as.list(environment()))
}

#' Get data for table id
#'
#' @param id string. Table id
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
#' Convenience api that searches when multiple table id matches are found and filters the table using the section pattern
#'
#' @param pattern string. A sequence of regular expressions separated by section sign \code{§}, which are used to filter the database. The first expression in the sequence is matched to a table id. The following expressions match to table variables in sequence. If the last variable is a date, it is used as start date filter.
#' @param dl_filter list or named vector passed to datasource download functions for filtering incoming data. Supported by tulli, OECD and ECB.
#' @param labels logical. Some datasources can return labelled or coded data.
#' @param lang Still experimental
#' @param na.rm Px-file based datasources return a table with a combination of all categories. Missing values can be filtered when reading the file to improve preformance.
#'
#' @export
data <- function(pattern = "", dl_filter = NULL, labels = TRUE,
                  lang = NULL, na.rm = FALSE, ...) {
  do_request("data", c(as.list(environment()), list(...)))
}

user_agent <-
  httr::user_agent(paste0("R/robonomistClient/", packageVersion("robonomistClient")))

do_request <- function(fun, args) {
  cli::cli_process_start("Processing request...", on_exit = "done"); on.exit(cli::cli_status_clear())
  if (is.null(getOption("robonomist.server"))) {
    if(suppressWarnings(require(robonomistServer))) {
      do.call(fun, args, env = robonomistServer::database)
    } else {
      cli::cli_process_failed()
      cli::cli_alert_info("Please set the Robonomist Server hostname using `options(robonomist.server = \"myhost.com\")`. Alternatively set the environment variable `ROBONOMIST_SERVER` before loading the package.")
      stop("Robonomist server unavailable.", call. = FALSE)
    }
  } else {
    payload <- list(fun = fun, args = args)
    req <- httr::POST(
      paste0(getOption("robonomist.protocol"), "://", getOption("robonomist.server"), "/data_remote"),
      body = serialize(payload, NULL),
      encode = "raw",
      user_agent,
      httr::content_type("application/octet-stream"),
      httr::timeout(3600L))
    if(httr::http_error(req)) {
      cli::cli_process_failed()
      httr::stop_for_status(req, task = "request data from server")
    }
    unserialize(httr::content(req))
  }
}

