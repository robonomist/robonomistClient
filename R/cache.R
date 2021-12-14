Cache <- R6::R6Class(
  "Cache",
  public = list(
    wait_for_data = function(key, expr) {
      new_hash <- rlang::hash(key)
      if (new_hash != self$hash) {
        self$data <- NULL
        force(expr)
        self$hash <- new_hash
      }
      NULL
    },
    data = NULL,
    hash = ""
  )
)
