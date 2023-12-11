#' Retrieve state and county FIPS codes
#'
#' @param regions The region breakdown for the map, can be one of
#'   (\code{"states"}, \code{"state"}, \code{"counties"}, \code{"county"}).
#'   The default is \code{"states"}.
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
fips_data <- function(regions = c("states", "state", "counties", "county")) {
  regions_ <- match.arg(regions)

  if (regions_ == "state" || regions_ == "states")
    utils::read.csv(
      system.file("extdata", "state_fips.csv", package = "usmapdata"),
      colClasses = rep("character", 3), stringsAsFactors = FALSE
    )
  else if (regions_ == "county" || regions_ == "counties")
    utils::read.csv(
      system.file("extdata", "county_fips.csv", package = "usmapdata"),
      colClasses = rep("character", 4), stringsAsFactors = FALSE
    )
}
