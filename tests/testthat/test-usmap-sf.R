#' Duplication of tests from test-usmap.R
#'
#' These tests ensure the outputs of the us_map.R functions
#' continue to work after the sf upgrade.
#'
#' When the upgrade is complete and the legacy files can be retired,
#' these tests will replace the ones in test-usmap.R.

states_map <- us_map(regions = "states", as_sf = TRUE)
counties_map <- us_map(regions = "counties", as_sf = TRUE)

test_that("structure of states df is correct", {
  expect_equal(length(unique(states_map$fips)), 51)
})

test_that("correct states are included", {
  include_abbr <- c("AK", "AL", "AZ")
  map_abbr <- us_map(regions = "states", include = include_abbr, as_sf = TRUE)

  include_full <- c("Alaska", "Alabama", "Arizona")
  map_full <- us_map(regions = "states", include = include_full, as_sf = TRUE)

  include_fips <- c("02", "01", "04")
  map_fips <- us_map(regions = "states", include = include_fips, as_sf = TRUE)

  expect_equal(length(unique(map_abbr$fips)), length(include_abbr))
  expect_equal(length(unique(map_full$fips)), length(include_full))
  expect_equal(length(unique(map_fips$fips)), length(include_fips))
})

test_that("correct states are excluded", {
  full_map <- us_map(regions = "states", as_sf = TRUE)

  exclude_abbr <- c("AK", "AL", "AZ")
  map_abbr <- us_map(regions = "states", exclude = exclude_abbr, as_sf = TRUE)

  exclude_full <- c("Alaska", "Alabama", "Arizona")
  map_full <- us_map(regions = "states", exclude = exclude_full, as_sf = TRUE)

  exclude_fips <- c("02", "01", "04")
  map_fips <- us_map(regions = "states", exclude = exclude_fips, as_sf = TRUE)

  expect_equal(length(unique(full_map$fips)) - length(unique(map_abbr$fips)), length(exclude_abbr))
  expect_equal(length(unique(full_map$fips)) - length(unique(map_full$fips)), length(exclude_full))
  expect_equal(length(unique(full_map$fips)) - length(unique(map_fips$fips)), length(exclude_fips))
})


test_that("structure of counties df is correct", {
  expect_equal(length(unique(counties_map$fips)), 3144)
})

test_that("correct counties are included", {
  include_fips <- c("34021", "34023", "34025")
  map_fips <- us_map(regions = "counties", include = include_fips, as_sf = TRUE)

  expect_equal(length(unique(map_fips$fips)), length(include_fips))
})

test_that("correct counties are excluded", {
  exclude_fips <- c("34021", "34023", "34025")
  map_fips <- us_map(regions = "counties", include = "NJ", exclude = exclude_fips, as_sf = TRUE)
  map_nj <- us_map(regions = "counties", include = "NJ", as_sf = TRUE)

  expect_equal(length(unique(map_nj$fips)) - length(unique(map_fips$fips)), (length(exclude_fips)))
})

test_that("singular regions value returns same data frames as plural", {
  state_map <- us_map(regions = "state", as_sf = TRUE)
  county_map <- us_map(regions = "county", as_sf = TRUE)

  expect_identical(states_map, state_map)
  expect_identical(counties_map, county_map)
})

test_that("error occurs for invalid region", {
  expect_error(us_map(regions = "cities", as_sf = TRUE))
})

test_that("centroid labels are loaded", {
  expect_equal(length(centroid_labels("states", as_sf = TRUE)[[1]]), 51)
  expect_equal(length(centroid_labels("counties", as_sf = TRUE)[[1]]), 3144)
})
