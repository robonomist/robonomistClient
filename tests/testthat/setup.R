start_test_server <- function(port) {
  callr::r_bg(function(port) {
    robonomistServer::data_server(port = port, access_token = "abc")
  }, args = list(port = port))
}

if(isTRUE(getOption("robonomist.test.local"))) {
  set_robonomist_server(NULL)
} else if(!is.null(getOption("robonomist.test.server"))) {
  set_robonomist_server(
    host = getOption("robonomist.test.server"),
    access_token = getOption("robonomist.test.access_token", "")
  )
} else if (requireNamespace("robonomistServer")) {
  port <- parallelly::freePort()
  rb <- start_test_server(port)
  withr::defer(rb$kill(), teardown_env())
  set_robonomist_server(
    host = paste0("127.0.0.1:", port),
    access_token = "abc"
  )
  Sys.sleep(30)
} else {
  op_skip_test <- options(robonomist.skip.server.test = TRUE)
  withr::defer(options(robonomist.skip.server.test = op_skip_test), teardown_env())
}

