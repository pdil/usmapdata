#' Duplication of tests from test-fips-data.R
#'
#' These tests ensure the outputs of the fips-data.R functions
#' continue to work after the sf upgrade.
#'
#' When the upgrade is complete and the legacy files can be retired,
#' these tests will replace the ones in test-fips-data.R.

test_that("state FIPS codes load correctly", {
  fips <- fips_data(as_sf = TRUE)
  state_fips <- fips_data("state", as_sf = TRUE)
  states_fips <- fips_data("states", as_sf = TRUE)

  expect_identical(fips, state_fips)
  expect_identical(fips, states_fips)
  expect_identical(state_fips, states_fips)

  expect_equal(length(fips), 3)
  expect_equal(length(fips[[1]]), 51)

  expect_equal(fips[[1, "abbr"]], "AK")
  expect_equal(fips[[1, "fips"]], "02")
  expect_equal(fips[[1, "full"]], "Alaska")

  expect_equal(fips[[51, "abbr"]], "WY")
  expect_equal(fips[[51, "fips"]], "56")
  expect_equal(fips[[51, "full"]], "Wyoming")
})

test_that("county FIPS codes load correctly", {
  county_fips <- fips_data("county", as_sf = TRUE)
  counties_fips <- fips_data("counties", as_sf = TRUE)

  expect_identical(county_fips, counties_fips)

  expect_equal(length(county_fips), 4)
  expect_equal(length(county_fips[[1]]), 3144)

  expect_equal(county_fips[[1, "full"]], "Alaska")
  expect_equal(county_fips[[1, "abbr"]], "AK")
  expect_equal(county_fips[[1, "county"]], "Aleutians East Borough")
  expect_equal(county_fips[[1, "fips"]], "02013")

  expect_equal(county_fips[[3144, "full"]], "Wyoming")
  expect_equal(county_fips[[3144, "abbr"]], "WY")
  expect_equal(county_fips[[3144, "county"]], "Weston County")
  expect_equal(county_fips[[3144, "fips"]], "56045")
})
