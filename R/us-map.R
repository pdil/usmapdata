#' Retrieve US map data
#'
#' @param regions The region breakdown for the map, can be one of
#'   (\code{"states"}, \code{"state"}, \code{"counties"}, \code{"county"}).
#'   The default is \code{"states"}.
#' @param include The regions to include in the resulting map. If \code{regions} is
#'  \code{"states"}/\code{"state"}, the value can be either a state name, abbreviation or FIPS code.
#'  For counties, the FIPS must be provided as there can be multiple counties with the
#'  same name. If states are provided in the county map, only counties in the included states
#'  will be returned.
#' @param exclude The regions to exclude in the resulting map. If \code{regions} is
#'  \code{"states"}/\code{"state"}, the value can be either a state name, abbreviation or FIPS code.
#'  For counties, the FIPS must be provided as there can be multiple counties with the
#'  same name. The regions listed in the \code{include} parameter are applied first and the
#'  \code{exclude} regions are then removed from the resulting map. Any excluded regions
#'  not present in the included regions will be ignored.
#' @param as_sf Defunct, this parameter no longer has any effect and will be removed in
#'  the future.
#' @param data_year The year for which to obtain map data.
#' If the value is \code{NULL}, the most recent year's data is used. If the
#' provided year is not found from the available map data sets, the next most
#' recent year's data is used. This can be used if an older data set is being
#' plotted on the US map so that the data matches the map more accurately.
#' Therefore, the provided value should match the year of the plotted data set.
#' The default is \code{NULL}, i.e. the most recent available year is used.
#'
#' @return An `sf` data frame of US map coordinates divided by the desired \code{regions}.
#'
#' @examples
#' str(us_map())
#'
#' df <- us_map(regions = "counties")
#' west_coast <- us_map(include = c("CA", "OR", "WA"))
#'
#' excl_west_coast <- us_map(exclude = c("CA", "OR", "WA"))
#'
#' ct_counties_as_of_2022 <- us_map(regions = "counties", include = "CT", data_year = 2022)
#'
#' @export
us_map <- function(
  regions = c("states", "state", "counties", "county"),
  include = c(),
  exclude = c(),
  as_sf = TRUE,
  data_year = NULL
) {
  regions <- match.arg(regions)
  if (regions == "state") regions <- "states"
  else if (regions == "county") regions <- "counties"

  map_year <- select_map_year(data_year)
  file_name <- paste0("us_", regions, ".gpkg")
  file_path <- system.file("extdata", map_year, file_name, package = "usmapdata")
  df <- sf::read_sf(file_path, as_tibble = FALSE)

  if (length(include) > 0) {
    df <- df[df$full %in% include |
               df$abbr %in% include |
               df$fips %in% include |
               substr(df$fips, 1, 2) %in% include, ]
  }

  if (length(exclude) > 0) {
    df <- df[!(df$full %in% exclude |
                 df$abbr %in% exclude |
                 df$fips %in% exclude |
                 substr(df$fips, 1, 2) %in% exclude), ]
  }

  df[order(df$abbr), ]
}

#' Retrieve centroid labels
#'
#' @inheritParams us_map
#'
#' @return An `sf` data frame of state or county centroid labels and positions
#'   relative to the coordinates returned by the \code{us_map} function.
#'
#' @export
centroid_labels <- function(
  regions = c("states", "state", "counties", "county"),
  as_sf = TRUE,
  data_year = NULL
) {
  regions <- match.arg(regions)
  if (regions == "state") regions <- "states"
  else if (regions == "county") regions <- "counties"

  map_year <- select_map_year(data_year)
  file_name <- paste0("us_", regions, "_centroids.gpkg")
  file_path <- system.file("extdata", map_year, file_name, package = "usmapdata")

  sf::read_sf(file_path, as_tibble = FALSE)
}

#' Years for which US map data is available
#'
#' @return A numeric vector of available map data years,
#' sorted in descending order.
#'
#' @examples
#' available_map_years()
#'
#' @export
available_map_years <- function() {
  sort(as.numeric(list.files(system.file("extdata", package = "usmapdata"))))
}

#' Select appropriate map data year from available years
#'
#' @param data_year The year for which to obtain \code{usmap} data.
#' If the value is \code{NULL}, the most recent year is returned. If the
#' provided year is not found from the available map data sets, the next most
#' recent available year is returned.
#'
#' @keywords internal
select_map_year <- function(data_year) {
  years <- available_map_years()

  if (is.null(data_year)) {
    max(years)
  } else if (!(data_year %in% years)) {
    warn <- function(provided, used) {
      warning(
        paste0(provided, " map data not available, using ", used, " instead.\n\n",
               "See available years with `usmapdata::available_map_years()`."),
        call. = FALSE
      )
    }

    years_greater <- years[years >= data_year]

    if (length(years_greater) == 0) {
      last_available <- max(years[years < data_year])
      warn(data_year, last_available)
      last_available
    } else {
      next_available <- min(years_greater)
      warn(data_year, next_available)
      next_available
    }
  } else {
    data_year
  }
}
