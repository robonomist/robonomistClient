`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}


#' Lock and Save Data Locally
#'
#' This function locks a given R object `x` by saving it to a file with a `.rdlock` extension.
#' If the file already exists (and `overwrite` is FALSE), the existing file is read and its contents returned.
#'
#' @importFrom rlang abort hash
#' @export
#'
#' @param x The R object to be locked and saved.
#' @param name Optional; the name to be used for the saved file.
#'             If NULL, a name is generated using the hash of the expression that defines `x`.
#'             If provided, it must be a single non-empty character string.
#' @param path Optional; the directory path where the data file is to be saved.
#'             Defaults to the value of the 'robonomistClient.datalock.path' option.
#'             If NULL, the file is saved in the current working directory.
#' @param overwrite Logical; whether to overwrite the existing data file.
#'                  Defaults to FALSE, meaning that if the file exists, it is read and returned
#'                  without overwriting.
#'
#' @return Returns the data `x` after saving or reading it from the file.
#'         If `overwrite` is TRUE, `x` is returned after saving.
#'         If `overwrite` is FALSE and the file exists, the contents of the file are returned.
#'         If the file does not exist, `x` is saved and then returned.
#'
#' @examples
#' x <- runif(1) |> datalock(name = "example", path = "fixed_data")
#' y <- runif(1) |> datalock(name = "example", path = "fixed_data")
#' identical(x, y)
#'
#' # This will save `y` to a file named "example.rdlock" in the "fixed_data" path.
#' # If the file "example.rdlock" already exists, `x` will to be evalated but read from the file.
#'
#' @note This function uses the 'hash' function from the 'rlang' package to generate a file name
#'       if no name is provided.
#' @importFrom rlang abort hash
#' @export
datalock <- function(x, name = NULL,
                     path = getOption("robonomistClient.datalock.path"),
                     overwrite = getOption("robonomistClient.datalock.overwrite", FALSE)) {
  if (is.null(name)) {
    name <- hash(rlang::enexpr(x))
  } else if (length(name) != 1L || !is.character(name)) {
    abort("`name` must be a character string.")
  }
  name <- paste0(name, ".rdlock")
  filename <-
    if (is.null(path)) {
      name
    } else {
      dir.create(path, showWarnings = FALSE, recursive = TRUE)
      file.path(path, name)
    }
  if (overwrite) {
    saveRDS(x, filename)
    return(x)
  }
  tryCatch(
    {
      suppressWarnings(readRDS(filename))
    },
    error = function(cnd) {
      saveRDS(x, filename)
      x
    }
  )
}
