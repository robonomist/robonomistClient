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

#' Set the hostname of Robonomist Data server
#'
#' @param hostname character, Set the hostname in format "data.hostname.com"
#'
#' @export
set_robonomist_server <- function(hostname = getOption("robonomist.server")) {
  options(robonomist.server = hostname)
}
