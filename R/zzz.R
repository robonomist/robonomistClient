.onLoad <- function(libname, pkgname) {

  cli::cli_alert_success("Loaded {.pkg robonomistClient} {packageVersion('robonomistClient')}")

  hostname <- Sys.getenv("ROBONOMIST_SERVER")
  access_token <- Sys.getenv("ROBONOMIST_ACCESS_TOKEN")
  if (nzchar(hostname)) {
    set_robonomist_server(hostname, access_token)
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
  cli::cli_alert_info("Please set the Robonomist Data Server's hostname and access token with {.fn set_robonomist_server}, e.g. {.code set_robonomist_server(hostname = \"myhost.com\", access_token =\"xyz\")}. Alternatively set the environment variables `ROBONOMIST_SERVER` and `ROBONOMIST_ACCESS_TOKEN` before loading the {.pkg robonomistClient} package.")
}
