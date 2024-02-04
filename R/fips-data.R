#' Retrieve state and county FIPS codes
#'
#' @param regions The region breakdown for the map, can be one of
#'   (\code{"states"}, \code{"state"}, \code{"counties"}, \code{"county"}).
#'   The default is \code{"states"}.
#' @param as_sf Defunct, this parameter no longer has any effect and will be removed in
#'  the future.
#'
#' @return An data frame of FIPS codes of the desired \code{regions}.
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
