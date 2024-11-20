#' @export
#' @importFrom tibble tbl_sum
tbl_sum.robonomist_data <- function(x, ...) {
  default_header <- NextMethod()
  c(
    "Robonomist id" = crayon::cyan(attr(x, "robonomist_id")),
    "Title" = attr(x, "robonomist_title"),
    "Vintage" = if (is.na(default_header["Last updated"])) {
      as.character(attr(x, "robonomist_vintage"))
    },
    default_header
  )
}

## px

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.px <- function(x, ...) {
  header <- NextMethod()
  lang <- attr(x, "output_language") %||% 1L
  ## if (is.null(lang)) lang <- 1L
  c(
    "Last updated" = as.character(attr(x, "last-updated")[[lang]][[1]]),
    "Next update" = as.character(attr(x, "next-update")),
    header
  )
}

## eurostat

#' @export
#' @importFrom tibble tbl_sum
tbl_sum.eurostat <- function(x, ...) {
  header <- NextMethod()
  tf <- if (!is.null(y <- attr(x, "time_frame_code"))) {
    paste(y, collapse = "-")
  }
  c(`Time frame` = tf, header)
}

## validate_robonomist_data <- function(x) {
##   stopifnot(
##     is_tibble(x),
##     vec_size(attr(x, "robonomist_id")) == 1,
##     vec_size(attr(x, "robonomist_title")) == 1,
##     vec_size(attr(x, "robonomist_vintage")) == 1
##   ##   all(
##   ##     !is.na(strptime(field(x, "vintage"), "%F %T")) |
##   ##       !is.na(strptime(field(x, "vintage"), "%F")) |
##   ##        field(x, "hash")
##   ##   )
##   )
##   x
## }

## ## @export
## robonomist_data <- function(x = new_data_frame(),
##                             id = new_robonomist_id(),
##                             title = character(),
##                             vintage = new_datetime()
##                             ) {
##   x <- as_tibble(x, .name_repair = "minimal")
##   ## x <- vec_cast(x, new_data_frame())
##   id <- vec_cast(id, new_robonomist_id())
##   vintage <- vec_cast(vintage, new_datetime())
##   title <- vec_cast(title, character())
##   new_robonomist_data(x, id, title, vintage) |>
##     validate_robonomist_data()
## }

## #' @export
## format.robonomist_vintage <- function(x, ...) {
##   out <- character(vec_size(x))
##   d <- field(x, "date_only")
##   out[d] <- as.character(field(x, "x")[d], format = "%F", tz = "UTC")
##   out[!d] <- as.character(field(x, "x")[!d], format = "%F %T", tz = "UTC")
##   out
## }

## ## Character

## #' @export
## vec_ptype2.robonomist_vintage.robonomist_vintage <- function(x, y, ...) new_robonomist_vintage()
## #' @export
## vec_ptype2.robonomist_vintage.character <- function(x, y, ...) new_robonomist_vintage()
## #' @export
## vec_ptype2.character.robonomist_vintage <- function(x, y, ...) new_robonomist_vintage()

## #' @export
## vec_cast.robonomist_vintage.robonomist_vintage <- function(x, to, ...) x
## #' @export
## vec_cast.robonomist_vintage.character <- function(x, to, tz = "", ...) {
##   dates <- as.POSIXct(x, "%F", tz = tz)
##   times <- as.POSIXct(x, "%F %T", tz = tz)
##   timesT <- as.POSIXct(x, "%FT%T", tz = tz)
##   x <- dplyr::coalesce(dates, times, timesT)
##   date_only <- !is.na(dates)
##   robonomist_vintage(x, date_only)
## }
## #' @export
## vec_cast.character.robonomist_vintage <- function(x, to, ...) vec_data(x)

## ## Date

## #' @export
## vec_ptype2.robonomist_vintage.Date <- function(x, y, ...) new_robonomist_vintage()
## #' @export
## vec_ptype2.Date.robonomist_vintage <- function(x, y, ...) new_robonomist_vintage()

## #' @export
## vec_cast.Date.robonomist_vintage <- function(x, to, ...) {
  
## }

## #' @export
## vec_cast.robonomist_vintage.Date <- function(x, to, ...) {
##   format(Sys.Date(), format = "%F %T")
## }




## ## POSIXt

## #' @export
## vec_ptype2.robonomist_vintage.POSIXt <- function(x, y, ...) new_robonomist_vintage()
## #' @export
## vec_ptype2.POSIXt.robonomist_vintage <- function(x, y, ...) new_robonomist_vintage()

