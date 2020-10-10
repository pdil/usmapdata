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
#'
#' @return A data frame of US map coordinates divided by the desired \code{regions}.
#'
#' @examples
#' str(us_map())
#'
#' df <- us_map(regions = "counties")
#' west_coast <- us_map(include = c("CA", "OR", "WA"))
#'
#' south_atl_excl_FL <- us_map(include = .south_atlantic, exclude = "FL")
#' @export
us_map <- function(regions = c("states", "state", "counties", "county"),
                   include = c(),
                   exclude = c()) {

  regions_ <- match.arg(regions)

  if (regions_ == "state") regions_ <- "states"
  else if (regions_ == "county") regions_ <- "counties"

  df <- utils::read.csv(system.file("extdata", paste0("us_", regions_, ".csv"), package = "usmapdata"),
                        colClasses = col_classes(regions_),
                        stringsAsFactors = FALSE)

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

  df
}

#' Map data column classes
#'
#' @keywords internal
col_classes <- function(regions) {
  result <- c("numeric", "numeric", "integer", "logical", "integer", rep("character", 4))

  if (regions %in% c("county", "counties")) {
    result <- c(result, "character")    # add extra column for county name
  }

  result
}
