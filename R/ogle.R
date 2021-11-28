#' List distinct values of categorical variables and summarise other variables of a tibble
#'
#' @param x A tibble
#' @return List of distinct values for character and factor variables
#' @export
ogle <- function(x) {
  r <- lapply(x, function(x) {
    if (is_cat(x)) {
      unique(x)
    } else if (is_summary(x)) {
      try(summary(x))
    }
  })
  print(r)
  invisible(r)
}

is_cat <- function(x) {
  is.character(x) | is.factor(x)
}
is_summary <- function(x) {
  lubridate::is.Date(x) |
    lubridate::is.POSIXct(x) |
      lubridate::is.POSIXlt(x) |
      is.numeric(x)
}


print_filter <- function(x) {
  y <- select(x, where(is_cat))
  categories <-
    purrr::imap(y, function(x, name) {
      values <- paste0('    "', unique(x), '"', collapse = ",\n")
      paste0(rlang::expr_deparse(sym(name)), " %in% c(\n", values, "\n  )")
    })
  cat(paste0("filter(\n", paste0("  ", categories, collapse = ",\n"), "\n)\n"))
  invisible(categories)
}
