
test_that("state FIPS codes load correctly", {
  fips <- fips_data()
  state_fips <- fips_data("state")
  states_fips <- fips_data("states")

  expect_identical(fips, state_fips)
  expect_identical(fips, states_fips)
  expect_identical(state_fips, states_fips)

  expect_equal(length(fips), 3)
  expect_equal(length(fips[[1]]), 52)

  expect_equal(fips[[1, "abbr"]], "AK")
  expect_equal(fips[[1, "fips"]], "02")
  expect_equal(fips[[1, "full"]], "Alaska")

  expect_equal(fips[[52, "abbr"]], "WY")
  expect_equal(fips[[52, "fips"]], "56")
  expect_equal(fips[[52, "full"]], "Wyoming")
})

test_that("county FIPS codes load correctly", {
  county_fips <- fips_data("county")
  counties_fips <- fips_data("counties")

  expect_identical(county_fips, counties_fips)

  expect_equal(length(county_fips), 4)
  expect_equal(length(county_fips[[1]]), 3222)

  expect_equal(county_fips[[1, "full"]], "Alaska")
  expect_equal(county_fips[[1, "abbr"]], "AK")
  expect_equal(county_fips[[1, "county"]], "Aleutians East Borough")
  expect_equal(county_fips[[1, "fips"]], "02013")

  expect_equal(county_fips[[3222, "full"]], "Wyoming")
  expect_equal(county_fips[[3222, "abbr"]], "WY")
  expect_equal(county_fips[[3222, "county"]], "Weston County")
  expect_equal(county_fips[[3222, "fips"]], "56045")
})
