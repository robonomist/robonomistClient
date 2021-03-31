do_request <- function(fun, args) {
  sp <- cli::make_spinner(template = "{spin} Processing request...")
  on.exit(sp$finish())
  sp$spin()

  if (is.null(getOption("robonomist.server"))) {
    if(suppressWarnings(require(robonomistServer))) {
      do.call(fun, args, env = robonomistServer::database)
    } else {
      ## cli::cli_process_failed()
      please_set_server()
      stop("Robonomist Data Server unavailable.", call. = FALSE)
    }
  } else {
    payload <- list(fun = fun, args = args)
    assign("data_buffer", NULL, envir = .globals)
    sp$spin()
    .globals$ws$send(memCompress(serialize(payload, NULL)))
    later::run_now()
    while (is.null(.globals$data_buffer)) {
      if(.globals$ws$readyState() != 1L) stop("Request failed", call. = FALSE)
      sp$spin()
      later::run_now(timeoutSecs = 1)
    }
    .globals$data_buffer
  }
}

#' Set the hostname of Robonomist Data server
#'
#' @param hostname character, Set the hostname in format "data.hostname.com"
#'
#' @export
set_robonomist_server <- function(hostname = getOption("robonomist.server")) {
  options(robonomist.server = hostname)
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
      Cookie = "Xyz",
      User_Agent = paste0("R/robonomistClient/", packageVersion("robonomistClient"))),
    autoConnect = FALSE,
    maxMessageSize = 256 * 1024 * 1024
  )

  ws$onOpen(function(event) {
    ## cli::cli_alert("Connection opened")
  })

  ws$onMessage(function(event) {
    payload <- unserialize(memDecompress(event$data, "gzip"))
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


