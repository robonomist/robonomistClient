## test_that("Frontend works locally", {
##   set_robonomist_server(NULL)
##   id <- "StatFin/asu/asas/statfin_asas_pxt_115a.px"
##   expect_type(data_vintage(id), "character")
##   expect_type(data_metadata(id), "list")
##   expect_s3_class(data_search(id), "robonomist_search")
##   expect_s3_class(datasources(), "robonomist_datasources")
##   expect_s3_class(data_get(id), "robonomist_data")
##   expect_s3_class(data(id), "robonomist_data")
## })


test_that("Frontend works remotely", {
  skip_if(Sys.getenv("ROBONOMIST_TEST_SERVER") == "",
          "Test server not configured.")
  cat(Sys.getenv("ROBONOMIST_TEST_SERVER"), "\n")
  set_robonomist_server(Sys.getenv("ROBONOMIST_TEST_SERVER"),
                        Sys.getenv("ROBONOMIST_TEST_ACCESS_TOKEN"))
  id <- "StatFin/asu/asas/statfin_asas_pxt_115a.px"
  expect_type(data_vintage(id), "character")
  expect_type(data_metadata(id), "list")
  expect_s3_class(data_search(id), "robonomist_search")
  expect_s3_class(datasources(), "robonomist_datasources")
  expect_s3_class(data_get(id), "robonomist_data")
  expect_s3_class(data(id), "robonomist_data")
  expect_s3_class(data("tidy/jali"), "robonomist_data")
  expect_s3_class(data("tidy/devel_echo", args = list(x = "hei")), "robonomist_data")
  expect_s3_class(data("wb/#1"), "robonomist_data")
  expect_s3_class(data("oecd/#1"), "robonomist_data")
  expect_s3_class(data("eurostat/#2"), "robonomist_data")
})

test_that("OECDv2 api works", {
  skip_if(is.null(getOption("robonomist.server")), "Test server not configured.")
  expect_s3_class(y <- data("oecd/QNA"), "tbl_lazy_oecd")
  expect_s3_class(y <- data_get("oecd/QNA"), "tbl_lazy_oecd")
  expect_s3_class(print(y), "tbl_lazy_oecd")
  expect_s3_class({y <-
                     filter(y, Country == "Finland",
                            grepl("Gross domestic prod", Subject),
                               Frequency=="Quarterly") %>%
                     filter(format(time, "%Y") > "2019")}, "tbl_lazy_oecd")
  expect_s3_class(print(y), "tbl_lazy_oecd")
  expect_s3_class(distinct(y, Subject), "tbl_df")
  expect_s3_class(collect(y), "tbl_df")

})

