.onLoad <- function(libname, pkgname) {

  . <- Sys.getenv("ROBONOMIST_SERVER")
  if (nzchar(.)) options(robonomist.server = .)

  invisible(NULL)

}
