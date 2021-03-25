.onLoad <- function(libname, pkgname) {

  cli::cli_alert_success("Loaded {.pkg robonomistClient} {packageVersion('robonomistClient')}")

  . <- Sys.getenv("ROBONOMIST_SERVER")
  if (nzchar(.)) {
    options(robonomist.server = .)
    cli::cli_alert_success("Set to {.pkg robonomistServer} at {.}")
    cli::cli_alert_success("Connected successfully to {do_request('server_version', list())}")
  } else if ("robonomistServer" %in% installed.packages()) {
    cli::cli_alert_success("Using local {.pkg robonomistServer} {packageVersion('robonomistServer')}")
  } else {
    please_set_server()
  }

  options(robonomist.protocol = "http")

  invisible(NULL)

}

please_set_server <- function() {
  cli::cli_alert_info("Please set the Robonomist Data Server hostname using `set_robonomist_server(\"myhost.com\")`. Alternatively set the environment variable `ROBONOMIST_SERVER` before loading the package.")
}
