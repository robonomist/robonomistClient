#' @importFrom qs qdeserialize qserialize
#' @importFrom websocket WebSocket
#' @importFrom R6 R6Class
RobonomistConnection <- R6::R6Class(
  "RobonomistConnection",

  public = list(

    hostname = NULL,
    access_token = NULL,

    set = function(hostname = getOption("robonomist.server"),
                   access_token = getOption("robonomist.access.token")) {

      if (!is.character(hostname) || !nzchar(hostname)) {
        please_set_server()
        cli_abort("Missing hostname")
      }

      self$hostname <- hostname
      self$access_token <- access_token

      url <- if (grepl("wss?://", hostname)) {
        hostname
      } else {
        paste0("ws://", hostname)
      }

      user_agent <-
        paste0("R/robonomistClient/", utils::packageVersion("robonomistClient"))

      private$ws <- websocket::WebSocket$new(
        url,
        headers = list(
          Authorization = paste("bearer", access_token),
          User_Agent = user_agent),
        autoConnect = FALSE,
        accessLogChannels = "none",
        errorLogChannels = "none",
        maxMessageSize = 1024^3
      )

      private$ws$onMessage(function(event) {
        msg <- qdeserialize(event$data)
        if (inherits(msg, "cli_message")) {
          cli:::cli_server_default(msg)
        } else if (inherits(msg, "warning")) {
          cli_warn(iconv(conditionMessage(msg), "UTF8"))
        } else if (inherits(msg, "error")) {
          private$error_flag <- TRUE
          error_msg <- iconv(conditionMessage(msg), "UTF8")
          cli_alert(paste("Request failed in server error:\n", error_msg))
        } else {
          private$cache$data <- msg
        }
      })

      private$ws$onClose(function(event) {
        if (!is.null(private$heart_beat_loop))
          later::destroy_loop(private$heart_beat_loop)
        if (event$reason != "")
          cli_alert_warning("Client disconnected with code {event$code} and reason {event$reason}")
      })

      private$ws$onError(function(event) {
        cli_abort("Client failed to connect: {event$message}")
      })

      invisible(NULL)
    },

    establish_connection = function() {

      if (is.null(private$ws)) {
        hostname <- getOption("robonomist.server")
        if (!is.character(hostname) || !nzchar(hostname)) {
          self$set(hostname, getOption("robonomist.access.token"))
        } else {
          please_set_server()
          cli_abort("Connection not set.")
        }
      }

      ## Wait for transition
      if (private$state() %in% c("Closing", "Connecting")) {
        while (private$state() %in% c("Closing", "Connecting")) {
          later::run_now(timeoutSecs = 1)
        }
      }
      ## Reset closed connection
      if (private$state() == "Closed") {
        self$set(self$hostname, self$access_token)
      }
      ## Connect
      if (private$state() == "Pre-connecting") {
        for (attempt in 1:3) {
          self$connect()
          if (private$state() == "Open") break
          sleep <- 5 * attempt
          cli_alert_warning("Failed to connect. Retrying in {sleep} seconds.")
          self$set(self$hostname, self$access_token)
          Sys.sleep(sleep)
        }
      }
      if (private$state() != "Open") {
        cli_abort("Failed to establish connection")
      }
      invisible(NULL)
    },

    connect = function() {

      cli_progress_step("Connecting to {.pkg robonomistServer} at {self$hostname}")
      private$ws$connect()

      while (private$state() == "Connecting") {
        later::run_now(timeoutSecs = 1)
      }
      if ((private$state() == "Open")) {
        private$.server_version <-
          self$send(fun = 'server_version', args = list(), message = FALSE) |>
          gsub("[^0-9.]", "", x = _) |>
          package_version()
        cli_progress_step("Connected successfully to robonomistServer {private$.server_version}")
        private$heart_beat_start()
      }
    },

    disconnect = function() {
      if (!is.null(private$ws)) {
        if (private$state() == "Open") {
          private$ws$close()
          cli_alert_success("{.pkg robonomistClient} disconnected successfully")
        }
      }
      private$.server_version <- NULL
      invisible(TRUE)
    },

    send = function(fun, args, message = TRUE) {
      self$establish_connection()

      if (message) cli_progress_step("Requesting {fun}", spinner = TRUE)

      payload <- list(fun = fun, args = args)

      private$cache$wait_for_data(key = payload, {
        private$ws$send(qserialize(payload, preset = "balanced"))
        later::run_now()
        while (is.null(private$cache$data)) {
          if(private$state() != "Open") {
            cli_abort("Connection was lost!")
          }
          if(private$error_flag) {
            private$error_flag <- FALSE
            stop("Request failed", call. = FALSE)
          }
          if (message) cli_progress_update()
          later::run_now(timeoutSecs = 1)
        }
      })
      private$cache$data
    },

    server_version = function() {
      if (is.null(private$.server_version)) {
        self$establish_connection()
      }
      private$.server_version
    }
  ),

  private = list(
    ws = NULL,
    cache = Cache$new(),
    .server_version = NULL,
    error_flag = FALSE,
    state = function() {
      if (is.null(private$ws)) {
        "Unset"
      } else {
        attr(private$ws$readyState(), "description")
      }
    },
    heart_beat_loop = NULL,
    heart_beat_start = function() {
      private$heart_beat_loop <- later::create_loop()
      private$heart_beat()
    },
    heart_beat = function(interval = 600) {
      private$ws$send("Stayin' Alive")
      later::later(private$heart_beat, interval, loop = private$heart_beat_loop)
    }
  )
)

connection <- RobonomistConnection$new()

please_set_server <- function() {
  cli_alert_info(
    "Please set the Robonomist Data Server's {.emph hostname} and {.emph access token}. There are 3 ways to do this:"
  )
  cli_ol(c(
    "Use function {.fn set_robonomist_server}. For example:\n {.code set_robonomist_server(hostname = \"myhost.com\", access_token =\"xyz\")}",
    "Set R's global options  `robonomist.server` and `robonomist.access.token` with the {.fn options} function before loading the {.pkg robonomistClient} package.",
    "Set the environment variables `ROBONOMIST_SERVER` and `ROBONOMIST_ACCESS_TOKEN` before loading R or the {.pkg robonomistClient} package."
  ))
}
