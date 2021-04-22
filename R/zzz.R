.onLoad <- function(libname, pkgname) {

  cli::cli_alert_success("Loaded {.pkg robonomistClient} {utils::packageVersion('robonomistClient')}")

  hostname <- Sys.getenv("ROBONOMIST_SERVER")
  access_token <- Sys.getenv("ROBONOMIST_ACCESS_TOKEN")
  if (nzchar(hostname)) {
    set_robonomist_server(hostname, access_token)
  } else if ("robonomistServer" %in% installed.packages()) {
    cli::cli_alert_success("Using local {.pkg robonomistServer} {utils::packageVersion('robonomistServer')}")
  } else {
    connection$please_set_server()
  }

  invisible(NULL)

}

.onUnload <- function(...) {
  if(!is.null(.globals$ws)) try(.globals$ws$close(), silent = TRUE)
}
