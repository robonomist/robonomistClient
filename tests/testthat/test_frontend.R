test_that("Frontend works locally", {
  options(robonomist.server = NULL)
  id <- "StatFin/asu/asas/statfin_asas_pxt_115a.px"
  expect_type(data_vintage(id), "character")
  expect_type(data_metadata(id), "list")
  expect_s3_class(data_search(id), "robonomist_search")
  expect_s3_class(datasources(), "robonomist_datasources")
  expect_s3_class(data_get(id), "robonomist_data")
  expect_s3_class(data(id), "robonomist_data")
})

test_that("Frontend works remotely", {
  set_robonomist_server(Sys.getenv("ROBONOMIST_TEST_SERVER"))
  id <- "StatFin/asu/asas/statfin_asas_pxt_115a.px"
  expect_type(data_vintage(id), "character")
  expect_type(data_metadata(id), "list")
  expect_s3_class(data_search(id), "robonomist_search")
  expect_s3_class(datasources(), "robonomist_datasources")
  expect_s3_class(data_get(id), "robonomist_data")
  expect_s3_class(data(id), "robonomist_data")
})

