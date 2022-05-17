ds <- datasources()

for(i in ds$dataset) {
  cat(i, "\n")
  test_that(paste("data() works on datasource", i), {
    skip_if(getOption("robonomist.skip.server.test", FALSE), "Test server not configured.")
    n <- switch(i, konj = 35, dk = 2, no = 2, traficom = 4, tidy = 2,
                se = 10, unctad = 2, eia = 16, 1)
    if(i %in% c("tulli", "ecb", "bundesbank")) {
      expect_s3_class(data(paste0(i, "/#", n)), "list")
    } else {
      expect_s3_class(data(paste0(i, "/#", n)), "tbl")
    }
  })
}
