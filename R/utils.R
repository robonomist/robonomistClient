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


#' Parse and Retrieve Data from URL
#'
#' The `fetch_data_from_url()` function is designed to facilitate easy access to data by parsing a copied URL from websites of various datasources. It forms a query to the database and retrieves the data in R using the `robonomistclient` package.
#'
#' Currently supported sites:
#'
#' - [OECD Data Explorer](https://data-explorer.oecd.org/)
#' - [Eurostat Data Explorer](https://ec.europa.eu/eurostat/databrowser/explore/all/all_themes)
#' - [ECB Data Portal](https://data.ecb.europa.eu/)
#' - [World Bank](https://data.worldbank.org/)
#' - [Fred Economic Data](https://fred.stlouisfed.org/)
#' - [Bank of International Settlements, BIS](https://data.bis.org/)
#' - [Databases of Statistics Finland](https://stat.fi/tup/tilastotietokannat/index.html)
#' - [Database of Finnish Centre for Pensions](https://tilastot.etk.fi/pxweb/en/ETK)
#' - [Statistics Sweden](https://www.statistikdatabasen.scb.se/pxweb/sv/ssd/)
#'
#' @param url A character string representing the URL copied from the datasource's website when a particular dataset is selected.
#' @param get A logical value indicating whether to execute the query and return the data (`TRUE`, default) or just return the query string (`FALSE`).
#' @return If `get` is `TRUE`, the function returns the queried data. If `get` is `FALSE`, it returns the query string.
#' @examples
#' # Example usage:
#' url <- "https://data-explorer.oecd.org/vis?tm=sna&pg=0&fs[0]=Measure%2C0%7CAquaculture%20production%23AQUA_PD%23&fc=Measure&snb=1&vw=tb&df[ds]=dsDisseminateFinalDMZ&df[id]=DSD_FISH_PROD%40DF_FISH_AQUA&df[ag]=OECD.TAD.ARP&df[vs]=1.0&pd=2010%2C&dq=.A.._T.T&ly[rw]=REF_AREA&ly[cl]=TIME_PERIOD&to[TIME_PERIOD]=false"
#' fetch_data_from_url(url)
#' fetch_data_from_url(url, get = FALSE)
#' # StatFin
#' fetch_data_from_url("https://statfin.stat.fi/PxWeb/pxweb/fi/StatFin/StatFin__aku/statfin_aku_pxt_12ea.px/")
#'
#' # Eurostat fetch_data_from_url("https://ec.europa.eu/eurostat/databrowser/view/cens_hnmga/default/table?lang=en&category=cens.cens_hn.cens_hnstr")
#'
#' # ECB
#' fetch_data_from_url("https://data.ecb.europa.eu/data/datasets/ICP/ICP.M.U2.N.000000.4.ANR")
#'
#' # World bank
#' fetch_data_from_url("https://data.worldbank.org/indicator/SH.DYN.MORT?locations=1W&start=1990&view=chart")
#'
#' # Fred
#' fetch_data_from_url("https://fred.stlouisfed.org/series/FPCPITOTLZGUSA")
#'
#' # BIS
#' fetch_data_from_url("https://data.bis.org/topics/RPP/BIS,WS_SPP,1.0/Q.5R.N.628")
#'
#' # SCB
#' fetch_data_from_url("https://www.statistikdatabasen.scb.se/pxweb/sv/ssd/START__EN__EN0302/SSDArGasavtal/")
#'
#' @importFrom httr parse_url
#' @importFrom glue glue
#' @importFrom stringr str_extract str_replace str_replace_all str_split str_split_1 str_match
#' @export
fetch_data_from_url <- function(url, get = TRUE) {
  parsed_url <- parse_url(url)
  query <-
    if (parsed_url$hostname == "data-explorer.oecd.org" &&
      parsed_url$path == "vis") {
      id <- parsed_url$query$`df[id]`
      robonomist_id <- paste0("oecd/", id)
      dl_filter <- parsed_url$query$dq
      glue('data_get("{robonomist_id}", dl_filter = "{dl_filter}")')
    } else if (parsed_url$hostname %in% c(
      "statfin.stat.fi",
      "pxdata.stat.fi",
      "vero2.stat.fi",
      "tieliikenneonnettomuudet.stat.fi",
      "trafi2.stat.fi",
      "tilastot.etk.fi"
    )) {
      id <- str_extract(parsed_url$path, "[^/]*/[^/]*\\.px") |>
        str_replace("Maahanmuuttajat_ja_kotoutuminen", "maakoto") |>
        str_replace("TraFi", "traficom") |>
        str_replace("ETK", "etk") |>
        str_replace_all("__", "/")
      glue('data_get("{id}")')
    } else if (parsed_url$hostname == "kototietokanta.stat.fi") {
      id <- stringr::str_extract(parsed_url$path, "[^/]*/[^/]*\\.px") |>
        str_replace("Kototietokanta", "koto") |>
        str_replace_all("__", "/")
      glue('data_get("{id}")')
    } else if (parsed_url$hostname == "ec.europa.eu") {
      id <- paste0(
        "eurostat/",
        str_match(parsed_url$path, "eurostat/databrowser/view/([^/]+)")[, 2]
      )
      glue('data_get("{id}")')
    } else if (parsed_url$hostname == "data.ecb.europa.eu") {
      if (parsed_url$query$filterSequence == "dataset") {
        id <- paste0("ecb/", basename(parsed_url$path))
        glue('data_get("{id}")')
      } else {
        y <- str_split(basename(parsed_url$path), "\\.", n = 2L)[[1]]
        robonomist_id <- paste0("ecb/", y[1])
        dl_filter <- y[2]
        glue('data_get("{robonomist_id}", dl_filter = "{dl_filter}")')
      }
    } else if (parsed_url$hostname == "data.worldbank.org") {
      robonomist_id <- paste0("wb/", basename(parsed_url$path))
      glue('data_get("{robonomist_id}")')
    } else if (parsed_url$hostname == "fred.stlouisfed.org") {
      robonomist_id <- paste0("fred/", basename(parsed_url$path))
      glue('data_get("{robonomist_id}")')
    } else if (parsed_url$hostname == "data.bis.org") {
      y <- parsed_url$path |>
        str_extract("[^/]*/[^/]*$") |>
        str_split_1("/")
      robonomist_id <- paste0("bis/", str_split_1(y[1], ",")[2])
      dl_filter <- y[2]
      glue('data_get("{robonomist_id}", dl_filter = "{dl_filter}")')
    } else if (parsed_url$hostname == "www.statistikdatabasen.scb.se") {
      id <-
        str_match(parsed_url$path, "ssd/START__([^/]*/[^/]*)")[,2] |>
        str_replace_all("__", "/")
      robonomist_id <- paste0("se/", id)
      glue('data_get("{robonomist_id}")')
    } else {
      stop("Unknown url!")
    }
  if (get) {
    cat(query, "\n")
    eval(parse(text = query))
  } else {
    query
  }
}
