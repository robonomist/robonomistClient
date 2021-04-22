do_request <- function(fun, args) {
  spinner <- cli::make_spinner(template = "{spin} Processing request...")
  on.exit(spinner$finish())
  spinner$spin()

  if (is.null(getOption("robonomist.server"))) {
    if(suppressWarnings(require(robonomistServer))) {
      do.call(fun, args, env = robonomistServer::database)
    } else {
      please_set_server()
      stop("Robonomist Data Server unavailable.", call. = FALSE)
    }
  } else {
    payload <- list(fun = fun, args = args)
    assign("data_buffer", NULL, envir = .globals)
    spinner$spin()
    .globals$ws$send(fst::compress_fst(serialize(payload, NULL), compression = 20))
    later::run_now()
    while (is.null(.globals$data_buffer)) {
      if(.globals$ws$readyState() != 1L) stop("Request failed", call. = FALSE)
      spinner$spin()
      later::run_now(timeoutSecs = 1)
    }
    .globals$data_buffer
  }
}

#' Set the hostname of Robonomist Data server
#'
#' @param hostname character, Set the hostname in format "data.hostname.com"
#' @param access_token, character, Bearer token
#'
#' @export
set_robonomist_server <- function(hostname = getOption("robonomist.server"),
                                  access_token = getOption("robonomist.access.token")) {
  options(robonomist.server = hostname)
  options(robonomist.access.token = access_token)
  if(!is.null(hostname)) {
    cli::cli_alert_success("Set to {.pkg robonomistServer} at {hostname}")
    connect_websocket()
    while (.globals$ws$readyState() == 0L) {
      later::run_now(timeoutSecs = 1)
    }
    cli::cli_alert_success("Connected successfully to {do_request('server_version', list())}")
  }
}

.globals = new.env(parent = emptyenv())

connect_websocket <- function() {
  ws <- .globals$ws
  if(!is.null(ws)) try(ws$stop(), silent = TRUE)

  ws <- websocket::WebSocket$new(
    paste0("ws://", getOption("robonomist.server")),
    headers = list(
      Authorization = paste("bearer", getOption("robonomist.access.token")),
      User_Agent = paste0("R/robonomistClient/", packageVersion("robonomistClient"))),
    autoConnect = FALSE,
    maxMessageSize = 256 * 1024 * 1024
  )

  ws$onOpen(function(event) {
    ## cli::cli_alert("Connection opened")
  })

  ws$onMessage(function(event) {
    payload <- unserialize(fst::decompress_fst(event$data))
    if(inherits(payload, c("cli_message", "condition"))) {
      cli:::cli_server_default(payload)
    } else {
      assign("data_buffer", payload, envir = .globals)
    }
  })
  ws$onClose(function(event) {
    cat("Client disconnected with code ", event$code,
        " and reason ", event$reason, "\n", sep = "")
  })
  ws$onError(function(event) {
    cat("Client failed to connect: ", event$message, "\n")
    stop()
  })
  ws$connect()

  assign("data_buffer", NULL, envir = .globals)
  assign("ws", ws, envir = .globals)
}


