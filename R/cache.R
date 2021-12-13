Cache <- R6::R6Class(
  "Cache",
  public = list(
    wait_for_data = function(key, expr) {
      new_hash <- rlang::hash(key)
      if (new_hash != private$hash) {
        private$.data <- NULL
        expr
        private$hash <- new_hash
      }
      private$.data
    }
  ),
  active = list(
    data = function(value) {
      if (missing(value)) {
        private$.data
      } else if (inherits(value, "error")) {
        cli_abort("Request failed in server error:\n",
                  iconv(conditionMessage(private$databuffer), "UTF8"))
      } else {
        private$.data <- value
      }
    }
  ),
  private = list(
    .data = NULL,
    hash = ""
  )
)
