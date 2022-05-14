test_that("Conditions work", {
  expect_message(data("tidy/devel_echo", args = "cli_alert"))
  expect_warning(data("tidy/devel_echo", args = "warning"))
  expect_error(data("tidy/devel_echo", args = "error"))
})
