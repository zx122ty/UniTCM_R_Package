test_that("set/get/clear token lifecycle works", {
  withr::local_envvar(UNITCM_TOKEN = "")
  clear_unitcm_token()

  expect_null(get_unitcm_token())

  set_unitcm_token("test-token-123")
  expect_equal(get_unitcm_token(), "test-token-123")

  clear_unitcm_token()
  expect_null(get_unitcm_token())
})

test_that("get_unitcm_token falls back to env var", {
  clear_unitcm_token()
  withr::local_envvar(UNITCM_TOKEN = "env-token-456")
  expect_equal(get_unitcm_token(), "env-token-456")
})

test_that("session token takes priority over env var", {
  withr::local_envvar(UNITCM_TOKEN = "env-token")
  set_unitcm_token("session-token")
  expect_equal(get_unitcm_token(), "session-token")
  clear_unitcm_token()
})

test_that("set/get base URL works", {
  old <- get_base_url()
  set_base_url("https://custom.example.com/api")
  expect_equal(get_base_url(), "https://custom.example.com/api")
  set_base_url(old)
})

test_that("get_base_url returns default when unset", {
  .unitcm_env <- unitcm:::.unitcm_env
  old <- .unitcm_env$base_url
  .unitcm_env$base_url <- NULL
  withr::local_envvar(UNITCM_BASE_URL = "")
  withr::local_options(unitcm.base_url = NULL)
  expect_equal(get_base_url(), "http://localhost:8000/api/v1")
  .unitcm_env$base_url <- old
})
