#' Quickly explore categorical and summary variables in a tibble
#'
#' @description
#' Provides a concise overview of a tibble by listing unique values for categorical variables and summary statistics for numeric or date/time variables. Useful for initial data exploration before filtering or analysis.
#'
#' @param .data A tibble to explore.
#' @param ... <'data-masking'> Optional. Variables to include in the exploration. If omitted, all variables are explored.
#'
#' @return A list: for character and factor variables, their unique values; for numeric and date/time variables, a summary.
#'
#' @examples
#' \dontrun{
#' data("sotkanet/4") %>% ogle()
#' data("sotkanet/4") %>% ogle(region)
#' }
#' @export
ogle <- function(.data, ...) {
  if (length(rlang::ensyms(...))) .data <- select(.data, ...)
  r <- lapply(.data, function(x) {
    if (is_cat(x)) {
      unique(x)
    } else if (is_summary(x)) {
      try(summary(x))
    }
  })
  print(r)
  invisible(r)
}

#' @keywords internal
is_cat <- function(x) {
  is.character(x) | is.factor(x)
}

#' @keywords internal
is_summary <- function(x) {
  lubridate::is.Date(x) |
    lubridate::is.POSIXct(x) |
      lubridate::is.POSIXlt(x) |
      is.numeric(x)
}

#' Print filter criteria for categorical variables in a tibble
#'
#' @description
#' Generates and prints a filter expression for the categorical variables in a tibble.
#' If run interactively and the `clipr` package is available, the filter expression is also copied to the clipboard for easy use in scripts or reports. This helps quickly create filter conditions for further data analysis.
#'
#' @param .data A tibble containing the data.
#' @param ... <'data-masking'> Optional. Variables to include in the filter expression. If omitted, all categorical variables are used.
#'
#' @return Invisibly returns the original tibble. The filter expression is printed to the console and, if possible, copied to the clipboard.
#'
#' @examples
#' \dontrun{
#' data("sotkanet/4") %>% print_filter(region_category, gender)
#' }
#' @export
print_filter <- function(.data, ...) {
  y <- dplyr::select(.data, where(is_cat))
  if (length(rlang::ensyms(...))) y <- select(y, ...)
  categories <-
    purrr::imap(y, function(x, name) {
      values <- paste0('    "', unique(x), '"', collapse = ",\n")
      paste0(rlang::expr_deparse(sym(name)), " %in% c(\n", values, "\n  )")
    })
  text <- paste0("filter(\n", paste0("  ", categories, collapse = ",\n"), "\n)\n")
  if (interactive() && requireNamespace("clipr")) clipr::write_clip(text)
  cat(text)
  invisible(.data)
}
