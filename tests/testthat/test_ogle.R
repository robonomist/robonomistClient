
d <- data("StatFin/asu/asas/statfin_asas_pxt_115a.px")

expect_that("ogle() works", {
  expect_type(ogle(d), "list")
})

expect_that("print_filter() works", {
  expect_type(print_filter(d), "list")
})

