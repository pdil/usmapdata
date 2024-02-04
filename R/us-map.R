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
#' @export
us_map <- function(
  regions = c("states", "state", "counties", "county"),
  include = c(),
  exclude = c(),
  as_sf = TRUE
) {
  regions <- match.arg(regions)

  if (regions == "state") regions <- "states"
  else if (regions == "county") regions <- "counties"

  df <- sf::read_sf(
    system.file("extdata", paste0("us_", regions, ".gpkg"),
                package = "usmapdata")
  )

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
#' @param regions The region breakdown for the map, can be one of
#'   (\code{"states"}, \code{"counties"}, as specified by the internal file names.
#'   The default is \code{"states"}.
#' @param as_sf Defunct, this parameter no longer has any effect and will be removed in
#'  the future.
#'
#' @return An `sf` data frame of state or county centroid labels and positions
#'   relative to the coordinates returned by the \code{us_map} function.
#'
#' @export
centroid_labels <- function(
  regions = c("states", "counties"),
  as_sf = TRUE
) {
  regions <- match.arg(regions)

  sf::read_sf(
    system.file("extdata", paste0("us_", regions, "_centroids.gpkg"),
                package = "usmapdata")
  )
}
