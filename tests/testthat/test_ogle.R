

test_that("ogle() works", {
  d <- data("StatFin/asu/asas/statfin_asas_pxt_115a.px")
  expect_type(ogle(d), "list")
})

test_that("print_filter() works", {
  d <- data("StatFin/asu/asas/statfin_asas_pxt_115a.px")
  expect_type(print_filter(d), "list")
})

