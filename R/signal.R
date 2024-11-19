#' Contructor for robonomist_data_get conditions
#'
#' @importFrom rlang cnd cnd_signal hash
#' @keywords internal
signal_data_get <- function(x) {
  if (inherits(x, "robonomist_data")) {
    cnd(
      id = attr(x, "robonomist_id"),
      vintage = attr(x, "robonomist_vintage"),
      title = attr(x, "robonomist_title"),
      language = attr(x, "robonomist_language"),
      class = c("robonomistClient_data_cnd", "robonomistClient_cnd")
    ) |> cnd_signal()
  }
  x
}

