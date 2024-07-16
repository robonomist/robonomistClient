#' Explore data by listing distinct categorical values and summarizing other variables
#'
#' @description
#' The `ogle` function provides a quick overview of the contents within a tibble,
#' specifically targeting the exploration of categorical variables by listing their
#' distinct values and summarizing other variable types. This function is useful for
#' preliminary data exploration before proceeding with more specific data filtering or analysis.
#'
#' @param .data A tibble to explore.
#' @param ... <'data-masking'> Additional arguments, specifying the variables to be
#'            included in the exploration. When no variables are specified, all
#'            variables in the tibble are explored.
#'
#' @return A list where each element corresponds to a variable in the tibble.
#'         For character and factor variables, it returns their distinct values.
#'         For variables that meet a summary condition (as defined by `robonomistClient:::is_summary`),
#'         a statistical summary is returned.
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

#' Print all filtering criteria for categorical variables of a tibble
#'
#' @description
#' This function generates and prints a filtering criteria string for categorical variables
#' in a tibble. If running in an interactive session and the `clipr` package is installed,
#' the generated filter string will also be copied to the clipboard for easy pasting into
#' scripts or reports. This is particularly useful for quickly generating filter conditions
#' for subsequent data manipulation tasks.
#'
#' @param .data A tibble containing the data.
#' @param ... <'data-masking'> Optional variables to specify which categorical variables
#'            to include in the filter printout. If omitted, filter criteria for all
#'            categorical variables will be generated and printed.
#'
#' @return The function prints the filtering criteria to the console and, if applicable,
#'         copies it to the clipboard. It returns the original tibble invisibly for further
#'         chaining of functions.
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
