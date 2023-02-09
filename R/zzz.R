.onLoad <- function(libname, pkgname) {

  cli_alert_success(
    "Loaded {.pkg robonomistClient} {utils::packageVersion('robonomistClient')}",
    class = "packageStartupMessage"
  )

  hostname <- getOption("robonomist.server", Sys.getenv("ROBONOMIST_SERVER"))
  access_token <- getOption("robonomist.access.token", Sys.getenv("ROBONOMIST_ACCESS_TOKEN"))

  if (nzchar(hostname)) {
    set_robonomist_server(hostname, access_token)
  } else if ("robonomistServer" %in% rownames(utils::installed.packages())) {
    ## Cannot check `requireNamespace("robonomistServer", quietly = TRUE)` as it would cause cyclic namespace dependency error when installing a new client on top of robonomistServer.
    cli_alert_success(
      "Using local {.pkg robonomistServer} {utils::packageVersion('robonomistServer')}",
      class = "packageStartupMessage"
    )
  } else if (interactive()) {
    please_set_server()
  }

  options(robonomist.client.cache.max.age = 15)

  invisible(NULL)

}
