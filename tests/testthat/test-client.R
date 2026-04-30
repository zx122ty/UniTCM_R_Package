test_that("unitcm_request builds correct URL with query params", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      # Capture the built request for inspection
      structure(list(url = req$url, headers = req$headers, body = req$body),
                class = "httr2_response")
    },
    resp_body_json = function(resp, ...) list(items = list(), total = 0L),
    resp_status = function(resp) 200L,
    .package = "httr2"
  )

  result <- unitcm_request("/herbs", query = list(q = "ginseng", page = 1L))
  expect_type(result, "list")
})

test_that("NULL query params are filtered out", {
  query <- list(q = "test", page = NULL, empty = NULL, size = 20)
  filtered <- Filter(Negate(is.null), query)
  expect_equal(length(filtered), 2L)
  expect_equal(filtered$q, "test")
  expect_equal(filtered$size, 20)
})

test_that("is_transient_status identifies transient codes", {
  mock_resp <- function(status) {
    structure(list(status_code = status), class = "httr2_response")
  }
  local_mocked_bindings(
    resp_status = function(resp) resp$status_code,
    .package = "httr2"
  )

  expect_true(unitcm:::is_transient_status(mock_resp(429L)))
  expect_true(unitcm:::is_transient_status(mock_resp(503L)))
  expect_false(unitcm:::is_transient_status(mock_resp(200L)))
  expect_false(unitcm:::is_transient_status(mock_resp(404L)))
})

test_that("unitcm_error_body extracts detail from JSON", {
  mock_resp <- structure(
    list(status_code = 404L, body = charToRaw('{"detail":"Herb not found"}')),
    class = "httr2_response"
  )
  local_mocked_bindings(
    resp_status = function(resp) resp$status_code,
    resp_body_json = function(resp, ...) list(detail = "Herb not found"),
    .package = "httr2"
  )

  msg <- unitcm_error_body(mock_resp)
  expect_match(msg, "not found")
  expect_match(msg, "Herb not found")
})

test_that("unitcm_error_body handles 429 and 500", {
  local_mocked_bindings(
    resp_body_json = function(resp, ...) list(),
    .package = "httr2"
  )

  mock_429 <- structure(list(status_code = 429L), class = "httr2_response")
  local_mocked_bindings(resp_status = function(resp) 429L, .package = "httr2")
  expect_match(unitcm_error_body(mock_429), "Rate limit")

  local_mocked_bindings(resp_status = function(resp) 500L, .package = "httr2")
  mock_500 <- structure(list(status_code = 500L), class = "httr2_response")
  expect_match(unitcm_error_body(mock_500), "server error")
})
