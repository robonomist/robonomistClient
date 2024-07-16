
test_that("Frontend works remotely", {
  skip_if(getOption("robonomist.skip.server.test", FALSE), "Test server not configured.")
  id <- "StatFin/asas/statfin_asas_pxt_115a.px"
  expect_s3_class(data_vintage(id), "POSIXct")
  expect_type(data_metadata(id), "list")
  expect_s3_class(data_search(id), "robonomist_search")
  expect_s3_class(data(), "robonomist_search")
  expect_s3_class(data("flknglknglnd"), "robonomist_search")
  expect_s3_class(datasources(), "robonomist_datasources")
  expect_output(print(datasources()))
  expect_s3_class(data_get(id), "robonomist_data")
  withr::with_options(
    list(robonomistClient.tidy_time = TRUE),
    {
      expect_s3_class(d <- data_get(id), "robonomist_data")
      expect_s3_class(d$time, "Date")
    }
  )
  expect_s3_class(data(id), "robonomist_data")
  withr::with_options(
    list(robonomistClient.tidy_time = TRUE), {
    expect_s3_class(d <- data(id), "robonomist_data")
    expect_s3_class(d$time, "Date")
  })
  expect_s3_class(data("tidy/jali"), "robonomist_data")
  expect_s3_class(data("tidy/devel_echo", args = list(x = "hei")), "robonomist_data")
  expect_s3_class(data("wb/#1"), "robonomist_data")
  expect_s3_class(data("oecd/#1"), "robonomist_data")
  expect_s3_class(data("eurostat/#2"), "robonomist_data")
  expect_s3_class(datasource_menu("StatFin"), "datasource_menu")
  expect_s3_class(datasource_menu("StatFin", lang = "sv"), "datasource_menu")
  expect_s3_class(datasource_menu(), "datasource_menu")
})

test_that("reconnect", {
  skip_if(getOption("robonomist.skip.server.test", FALSE), "Test server not configured.")
  expect_s3_class(data(), "tbl_df")
  expect_true(disconnect())
  expect_s3_class(data(), "tbl_df")
})
