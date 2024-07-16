n1 <- rlang::hash(Sys.time())
n2 <- rlang::hash(Sys.time() + 1)
withr::defer(
  {
    unlink(paste0(n1, ".rdlock"))
    unlink(paste0(n2, ".rdlock"))
  },
  teardown_env()
)

test_that("dataloc work", {
  expect_identical(datalock(Sys.time()), datalock(Sys.time()))
  expect_identical(datalock(Sys.time(), name = n1), datalock(Sys.time(), name = n1))
  expect_identical(datalock(Sys.time(), name = n2), datalock(1, name = n2))
})


