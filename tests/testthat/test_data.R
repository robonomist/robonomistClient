ds <- datasources()

for(i in ds$dataset) {
  cat(i, "\n")
  test_that(paste("data() works on datasource", i), {
    skip_if(is.null(getOption("robonomist.server")), "Test server not configured.")
    n <- switch(i, konj = 10, dk = 2, no = 2, traficom = 4, tidy = 2, 1)
    ## skip_if(i == "konj") ## Too slow
    if(i %in% c("tulli", "ecb")) {
      expect_s3_class(data(paste0(i, "/#", n)), "list")
    } else {
      expect_s3_class(data(paste0(i, "/#", n)), "tbl")
    }
  })
}


