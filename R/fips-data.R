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
  as_sf = TRUE
) {
  regions <- match.arg(regions)

  map_data <- usmapdata::us_map(regions)
  sf::st_geometry(map_data) <- NULL
  map_data
}
