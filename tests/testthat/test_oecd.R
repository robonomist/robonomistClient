## test_that("OECDv2 api works", {
##   skip_if(
##     getOption("robonomist.skip.server.test", FALSE),
##     "Test server not configured."
##   )
##   expect_s3_class(y <- data("oecd/QNA"), "tbl_lazy_oecd")
##   expect_s3_class(y <- data_get("oecd/QNA"), "tbl_lazy_oecd")
##   expect_s3_class(print(y), "tbl_lazy_oecd") |> expect_output()
##   expect_s3_class(
##     {
##       y <-
##         dplyr::filter(
##           y, Country == "Finland",
##           grepl("Gross domestic prod", Subject),
##           Frequency == "Quarterly"
##         ) |>
##         dplyr::filter(format(time, "%Y") > "2019")
##     },
##     "tbl_lazy_oecd"
##   )
##   expect_s3_class(print(y), "tbl_lazy_oecd") |> expect_output()
##   expect_s3_class(distinct(y, Subject), "tbl_df")
##   expect_s3_class(collect(y), "tbl_df")
## })

## test_that("OECDv3 api works", {
##   skip_if(
##     getOption("robonomist.skip.server.test", FALSE),
##     "Test server not configured."
##   )
##   expect_s3_class(y <- data("oecd3/QNA"), "tbl_lazy_oecd_v3")
##   expect_s3_class(y <- data_get("oecd3/QNA"), "tbl_lazy_oecd_v3")
##   expect_s3_class(print(y), "tbl_lazy_oecd_v3_printout") |> expect_output()
##   expect_s3_class(
##     {
##       y <-
##         dplyr::filter(
##           y, Country == "Finland",
##           grepl("Gross domestic prod", Subject),
##           Frequency == "Quarterly"
##         ) |>
##         dplyr::filter(format(time, "%Y") > "2019")
##     },
##     "tbl_lazy_oecd_v3"
##   )
##   expect_s3_class(print(y), "tbl_lazy_oecd_v3_printout") |> expect_output()
##   expect_s3_class(distinct(y, Subject), "tbl_df")
##   expect_s3_class(collect(y), "tbl_df")
## })
