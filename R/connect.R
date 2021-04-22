do_request <- function(fun, args) {

  if (is.null(getOption("robonomist.server"))) {
    if(suppressWarnings(require(robonomistServer))) {
      cli::cli_process_start("Processing request...")
      do.call(fun, args, env = robonomistServer::database)
      cli::cli_process_done()
    } else {
      connection$please_set_server()
      stop("Robonomist Data Server unavailable.", call. = FALSE)
    }
  } else {
    connection$send(fun, args)
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
  connection$connect()
}

RobonomistConnection <- R6::R6Class(
  "RobonomistConnection",

  public = list(

    connect = function(hostname = getOption("robonomist.server"),
                       access_token = getOption("robonomist.access.token"),
                       protocol = "ws") {

      if(!is.null(hostname)) {
        cli::cli_alert_success("Connecting to {.pkg robonomistServer} at {hostname}")
      } else {
        stop(private$connection_info)
      }

      self$finalize()

      private$ws <- websocket::WebSocket$new(
        paste0(protocol, "://", hostname),
        headers = list(
          Authorization = paste("bearer", access_token),
          User_Agent = paste0("R/robonomistClient/", utils::packageVersion("robonomistClient"))),
        autoConnect = FALSE,
        maxMessageSize = 256 * 1024 * 1024
      )

      private$ws$onOpen(function(event) {
        ## cli::cli_alert("Connection opened")
      })

      private$ws$onMessage(function(event) {
        msg <- unserialize(fst::decompress_fst(event$data))
        if(inherits(msg, c("cli_message", "condition"))) {
          cli:::cli_server_default(msg)
        } else {
          private$databuffer <- msg
        }
      })

      private$ws$onClose(function(event) {
        cat("Client disconnected with code ", event$code,
            " and reason ", event$reason, "\n", sep = "")
      })

      private$ws$onError(function(event) {
        cat("Client failed to connect: ", event$message, "\n")
        stop()
      })

      private$ws$connect()

      while (private$ws$readyState() == 0L) {
        later::run_now(timeoutSecs = 1)
      }
      version <- self$send('server_version', list())
      cli::cli_alert_success("Connected successfully to {version}")
    },

    send = function(fun, args) {
      spinner <- cli::make_spinner(template = "{spin} Processing request...")
      on.exit(spinner$finish())
      spinner$spin()
      payload <- list(fun = fun, args = args)
      hash <- digest::digest(payload)
      if(hash != private$databuffer_hash) {
        private$databuffer <- NULL
        spinner$spin()
        private$ws$send(fst::compress_fst(serialize(payload, NULL), compression = 20))
        later::run_now()
        while (is.null(private$databuffer)) {
          if(private$ws$readyState() != 1L) stop("Request failed", call. = FALSE)
          spinner$spin()
          later::run_now(timeoutSecs = 1)
        }
        private$databuffer_hash <- hash
      }
      private$databuffer
    },

    please_set_server = function() {
      cli::cli_alert_info(private$connection_info)
    },

    finalize = function() {
      if(!is.null(private$ws)) try(private$ws$stop(), silent = TRUE)
      private$databuffer <- NULL
      private$databuffer_hash <- ""
    }

  ),

  private = list(
    ws = NULL,
    databuffer = NULL,
    databuffer_hash = "",
    connection_info = "Please set the Robonomist Data Server's hostname and access token with {.fn set_robonomist_server}, e.g. {.code set_robonomist_server(hostname = \"myhost.com\", access_token =\"xyz\")}. Alternatively set the environment variables `ROBONOMIST_SERVER` and `ROBONOMIST_ACCESS_TOKEN` before loading the {.pkg robonomistClient} package."
  )

)

connection <- RobonomistConnection$new()
