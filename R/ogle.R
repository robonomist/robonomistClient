#' List all distinct values of categorical variables and summarise other variables
#'
#' @description The `ogle` function can be helpful in exploring tibble before filtering them.
#'
#' @param .data A tibble
#' @param ... <'data-masking'> Optional variables to limit ogling. If omitted, all variables will be ogled.
#'
#' @return List of distinct values for character and factor variables
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

#' Print full filter for categorical variables of a tibble
#'
#' @description If `clipr` package is installed, the filter will be copied to clipboard.
#'
#' @param .data A tibble
#' @param ... <'data-masking'> Optional variables to limit the printout. If omitted, will print all variables.
#'
#' @examples
#' \dontrun{
#' data("sotkanet/4") %>% print_filter(region_category, gender)
#' }
#' @importFrom tidyselect where
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
  if(interactive() && requireNamespace("clipr")) clipr::write_clip(text)
  cat(text)
  invisible(.data)
}
