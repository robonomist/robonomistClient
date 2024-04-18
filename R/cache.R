#' @importFrom rlang hash
Cache <- R6::R6Class(
  "Cache",
  public = list(
    wait_for_data = function(key, expr) {
      new_hash <- hash(key)
      age <- difftime(Sys.time(), self$time, units = "secs")
      stale <- age > getOption("robonomist.client.cache.max.age")
      if (stale || new_hash != self$hash) {
        self$data <- NULL
        force(expr)
        self$hash <- new_hash
        self$time <- Sys.time()
      } else {
        cli_alert_info("Object retrieved from client cache (valid until {self$time + getOption('robonomist.client.cache.max.age')}).")
      }
      NULL
    },
    data = NULL,
    hash = "",
    time = Sys.time()
  )
)
