#' Retrieve state and county FIPS codes
#'
#' @param regions The region breakdown for the map, can be one of
#'   (\code{"states"}, \code{"state"}, \code{"counties"}, \code{"county"}).
#'   The default is \code{"states"}.
#' @param as_sf Whether the output should be an \link[sf]{sf} object or not. If
#'  `FALSE` (the current default), the output will be a \link{data.frame}. This is a
#'  temporary parameter to be used only during the shape file format upgrade.
#'  It will be removed in the future once the upgrade is complete and the value
#'  will effectively be `TRUE`.
#'
#' @return A data frame of FIPS codes of the desired \code{regions}.
#'
#' @examples
#' str(fips_data())
#'
#' state_fips <- fips_data()
#' county_fips <- fips_data(regions = "counties")
#'
#' @export
fips_data <- function(
  regions = c("states", "state", "counties", "county"),
  as_sf = FALSE
) {
  regions <- match.arg(regions)

  if (as_sf) {
    map_data <- usmapdata::us_map(regions, as_sf = TRUE)
    sf::st_geometry(map_data) <- NULL
    map_data
  } else {
    if (regions == "state" || regions == "states")
      utils::read.csv(
        system.file("extdata", "legacy", "state_fips.csv", package = "usmapdata"),
        colClasses = rep("character", 3), stringsAsFactors = FALSE
      )
    else if (regions == "county" || regions == "counties")
      utils::read.csv(
        system.file("extdata", "legacy", "county_fips.csv", package = "usmapdata"),
        colClasses = rep("character", 4), stringsAsFactors = FALSE
      )
  }
}
