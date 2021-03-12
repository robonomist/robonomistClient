.onLoad <- function(libname, pkgname) {

  . <- Sys.getenv("ROBONOMIST_SERVER")
  if (nzchar(.)) options(robonomist.server = .)

  options(robonomist.protocol = "https")

  invisible(NULL)

}
