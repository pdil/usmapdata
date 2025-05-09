#' usmapdata: Mapping Data for usmap Package
#'
#' @description
#' It is usually difficult or inconvenient to create US maps that
#'   include both Alaska and Hawaii in a convenient spot. All map
#'   data frames produced by this package use the US National Atlas Equal Area
#'   projection.
#'
#' @section Map data frames:
#' Alaska and Hawaii have been manually moved to a new location so that
#' their new coordinates place them to the bottom-left corner of
#' the map. These maps can be accessed by using the \code{\link{us_map}} function.
#'
#' The function provides the ability to retrieve maps with either
#' state borders or county borders using the \code{regions} parameter
#' for convenience.
#'
#' States (or counties) can be included such that all other states (or counties)
#' are excluded using the \code{include} parameter.
#'
#' @author Paolo Di Lorenzo \cr
#' \itemize{
#'   \item Email: \email{paolo@@dilorenzo.org}
#'   \item GitHub: \url{https://github.com/pdil/}
#' }
#'
#' @seealso
#' Helpful links:
#' \itemize{
#'   \item US Census Shapefiles \cr
#'     \url{https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html}
#'   \item Map Features \cr
#'     \url{https://en.wikipedia.org/wiki/Map_projection}
#'     \url{https://en.wikipedia.org/wiki/Equal-area_projection}
#'     \url{https://epsg.io/9311}
#' }
#'
#' @references {
#'  Rudis B (2014). “Moving The Earth
#'  (well, Alaska & Hawaii) With R.”
#'  <https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/>.
#' }
#'
#' @docType package
#' @name usmapdata
"_PACKAGE"

## usethis namespace: start
#' @importFrom rlang .data
## usethis namespace: end
NULL
