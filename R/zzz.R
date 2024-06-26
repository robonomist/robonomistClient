.onLoad <- function(libname, pkgname) {
  rlang::inform(
    cli::format_inline(
      "Loaded {.pkg robonomistClient} {utils::packageVersion('robonomistClient')}"
    ),
    class = "packageStartupMessage"
  )

  options(
    robonomist.server =
      getOption("robonomist.server", Sys.getenv("ROBONOMIST_SERVER")),
    robonomist.access.token =
      getOption("robonomist.access.token", Sys.getenv("ROBONOMIST_ACCESS_TOKEN")),
    robonomist.client.cache.max.age = 15
  )

  set_robonomist_server()

  invisible(NULL)
}

is_robonomist_server_installed <- function() {
  is_installed <- getOption("robonomist.server.installed")
  if (is.null(is_installed)) {
    is_installed <-
      tryCatch(is.character(find.package("robonomistServer")), error = function(e) FALSE)
    options(robonomist.server.installed = is_installed)
  }
  is_installed
}

#' Set the hostname of Robonomist Data Server
#'
#' @param hostname character, Set the hostname in format "data.example.com". To use secure websocket, also set the protocol, e.g. "wss://data.example.com".
#' @param access_token, character, Bearer token
#'
#' @export
set_robonomist_server <- function(hostname = getOption("robonomist.server"),
                                  access_token = getOption("robonomist.access.token")) {
  hostname <- hostname %||% ""
  options(robonomist.server = hostname)
  options(robonomist.access.token = access_token)
  switch(server_mode(),
    remote = {
      cli_progress_step("Set to connect {hostname}")
      connection$set(hostname, access_token)
    },
    local = {
      server_version <- utils::packageVersion("robonomistServer")
      options(robonomist.protocol.version = server_version)
      ## Cannot check `requireNamespace("robonomistServer", quietly = TRUE)` as
      ## it would cause a cyclic namespace dependency error when installing
      ## a new client on top of robonomistServer.
      rlang::inform(
        cli::format_inline(
          "Using local {.pkg robonomistServer} {server_version}"
        ),
        class = "packageStartupMessage"
      )
    },
    unavalable = {
      if (interactive()) {
        please_set_server()
      }
    }
  )
  invisible(NULL)
}

#' Disconnect from Robonomist Data Server
#'
#' @export
disconnect <- function() {
  connection$disconnect()
}

#' @keywords internal
server_mode <- function() {
  if (nzchar(getOption("robonomist.server", ""))) {
    "remote"
  } else if (is_robonomist_server_installed()) {
    "local"
  } else {
    "unavailable"
  }
}

#' @keywords internal
protocol_version <- function() {
  switch(server_mode(),
    remote = connection$server_version(),
    local = getOption("robonomist.protocol.version")
  )
}
