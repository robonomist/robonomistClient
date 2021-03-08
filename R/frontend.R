
#' @export
data_vintage <- function(id) {
  do_request("vintage", as.list(environment()))
}

#' @export
data_metadata <- function(id) {
  do_request("metadata", as.list(environment()))
}

#' @export
data_get <- function(id, dl_filter = NULL, labels = TRUE, lang = NULL, na.rm = FALSE, ...) {
  do_request("get", c(as.list(environment()), list(...)))
}

#' @export
data_search <- function(pattern = "", print_max = 20, verbose = FALSE) {
  do_request("search", as.list(environment()))
}

#' @export
data <- function(section_pattern = "", print_max = 15, dl_filter = NULL, labels = TRUE,
                  lang = NULL, na.rm = FALSE, ...) {
  do_request("data", c(as.list(environment()), list(...)))
}


do_request <- function(fun, args) {
  if (is.null(getOption("robonomis.server"))) {
    do.call(fun, args, env = robonomistServer::database)
  } else {
    payload <- list(fun = fun, args = args)
    httr::POST(paste0("http://", getOption("robonomist.server"), "/data_remote"),
               body = serialize(payload, NULL),
               encode = "raw",
               httr::content_type("application/octet-stream")) %>%
      httr::content() %>%
        unserialize()
  }
}



