do_request <- function(fun, args) {

  if (is.null(getOption("robonomist.server"))) {
    if(suppressWarnings(require(robonomistServer))) {
      cli::cli_process_start("Processing request...")
      on.exit(cli::cli_process_done())
      do.call(fun, args, env = robonomistServer::database)
    } else {
      please_set_server()
      stop("Robonomist Data Server unavailable.", call. = FALSE)
    }
  } else {
    connection$send(fun, args)
  }
}

#' Set the hostname of Robonomist Data Server
#'
#' @param hostname character, Set the hostname in format "data.example.com". To use secure websocket, also set the protocol, e.g. "wss://data.example.com".
#' @param access_token, character, Bearer token
#'
#' @export
set_robonomist_server <- function(hostname = getOption("robonomist.server"),
                                  access_token = getOption("robonomist.access.token")) {
  options(robonomist.server = hostname)
  options(robonomist.access.token = access_token)
  if (!is.null(hostname)) {
    for (i in 1:3) {
      connection$connect()
      if (connection$open) break
      Sys.sleep(5)
    }
  }
}

#' Disconnect from Robonomist Data Server
#'
#' @export
disconnect <- function() {
  connection$finalize()
}

RobonomistConnection <- R6::R6Class(
  "RobonomistConnection",

  public = list(

    open = FALSE,

    connect = function(hostname = getOption("robonomist.server"),
                       access_token = getOption("robonomist.access.token")) {

      if(!is.null(hostname)) {
        cli::cli_alert_success("Connecting to {.pkg robonomistServer} at {hostname}")
      } else {
        please_set_server()
        stop("Missing hostname", call. = FALSE)
      }

      private$databuffer_reset()
      private$close_ws()

      if (grepl("wss?://", hostname)) {
        url <- hostname
      } else {
        url <- paste0("ws://", hostname)
      }

      private$ws <- websocket::WebSocket$new(
        url,
        headers = list(
          Authorization = paste("bearer", access_token),
          User_Agent = paste0("R/robonomistClient/", utils::packageVersion("robonomistClient"))),
        autoConnect = FALSE,
        maxMessageSize = 1024^3
      )

      private$ws$onMessage(function(event) {
        msg <- qs::qdeserialize(event$data)
        if(inherits(msg, "cli_message")) {
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
      if ((private$ws$readyState() == 1L)) {
        server_version <- self$send('server_version', list())
        cli::cli_alert_success("Connected successfully to {server_version}")
        if (server_version >= "0.4.11") {
          private$heart_beat_loop <- later::create_loop()
          private$heart_beat()
        }
        self$open <- TRUE
      }
    },

    send = function(fun, args) {
      spinner <- cli::make_spinner(template = "{spin} Processing request...")
      on.exit(spinner$finish())
      spinner$spin()
      payload <- list(fun = fun, args = args)
      hash <- digest::digest(payload)
      if(hash != private$databuffer_hash) {
        private$databuffer_reset()
        spinner$spin()
        private$ws$send(qs::qserialize(payload, preset = "balanced"))
        later::run_now()
        while (is.null(private$databuffer)) {
          if(private$ws$readyState() != 1L) stop("Request failed", call. = FALSE)
          spinner$spin()
          later::run_now(timeoutSecs = 1)
        }
        private$databuffer_hash <- hash
      }
      if(inherits(private$databuffer, "error"))
        stop("Request failed in error:\n",
             iconv(conditionMessage(private$databuffer), "UTF8"),
             call. = FALSE)
      private$databuffer
    },

    finalize = function() {
      if (!is.null(private$heart_beat_loop))
        later::destroy_loop(private$heart_beat_loop)
      self$open <- FALSE
      private$close_ws()
      cli::cli_alert_success("{.pkg robonomistClient} disconnected from successfully")
    }

  ),

  private = list(
    ws = NULL,
    close_ws = function() {
      if(!is.null(private$ws)) try(private$ws$close(), silent = TRUE)
      private$ws <- NULL
    },
    databuffer = NULL,
    databuffer_hash = "",
    databuffer_reset = function() {
      private$databuffer <- NULL
      private$databuffer_hash <- ""
    },
    heart_beat_loop = NULL,
    heart_beat = function(interval = 1800) {
      private$ws$send("Stayin' Alive")
      later::later(private$heart_beat, interval, loop = private$heart_beat_loop)
    }
  )
)

connection <- RobonomistConnection$new()

please_set_server <- function() {
  cli::cli_alert_info(
    "Please set the Robonomist Data Server's {.emph hostname} and {.emph access token}. There are 3 ways to do this:"
  )
  cli::cli_ol(c(
    "Use function {.fn set_robonomist_server}. For example:\n {.code set_robonomist_server(hostname = \"myhost.com\", access_token =\"xyz\")}",
    "Set R's global options  `robonomist.server` and `robonomist.access.token` with the {.fn options} function before loading the {.pkg robonomistClient} package.",
    "Set the environment variables `ROBONOMIST_SERVER` and `ROBONOMIST_ACCESS_TOKEN` before loading R or the {.pkg robonomistClient} package."
  ))
}
