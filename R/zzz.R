.onLoad <- function(libname, pkgname) {

  cli::cli_alert_success("Loaded {.pkg robonomistClient} {packageVersion('robonomistClient')}")

  . <- Sys.getenv("ROBONOMIST_SERVER")
  if (nzchar(.)) {
    set_robonomist_server(.)
  } else if ("robonomistServer" %in% installed.packages()) {
    cli::cli_alert_success("Using local {.pkg robonomistServer} {packageVersion('robonomistServer')}")
  } else {
    please_set_server()
  }

  invisible(NULL)

}

.onUnload <- function(...) {
  if(!is.null(.globals$ws)) try(.globals$ws$close(), silent = TRUE)
}

please_set_server <- function() {
  cli::cli_alert_info("Please connect to a Robonomist Data Server by setting the hostname using `set_robonomist_server(\"myhost.com\")`. Alternatively set the environment variable `ROBONOMIST_SERVER` before loading the {.pkg robonomistClient} package.")
}
