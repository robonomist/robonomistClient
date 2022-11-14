test_that("Conditions work", {
  skip_if(getOption("robonomist.skip.server.test", FALSE), "Test server not configured.")
  expect_message(data("tidy/devel_echo", args = "cli_alert", hash = Sys.time()))
  expect_message(data("tidy/devel_echo", args = "warning", hash = Sys.time()))
  expect_error(data("tidy/devel_echo", args = "error", hash = Sys.time()))
})
