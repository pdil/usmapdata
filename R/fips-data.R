#' Retrieve state and county FIPS codes
#'
#' @inheritParams us_map
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
  as_sf = TRUE,
  data_year = NULL
) {
  regions <- match.arg(regions)

  map_data <- usmapdata::us_map(regions, data_year = data_year)
  sf::st_geometry(map_data) <- NULL
  map_data
}
