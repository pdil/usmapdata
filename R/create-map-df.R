
#' Create `usmap` shape files
#'
#' Internal function to create the modified shape files used by the
#' \link{usmap} package. Using this function externally is not recommended
#' since it makes certain undocumented assumptions that may not work
#' with all inputs.
#'
#' It is strongly recommend that the \link{usmap} package is used
#' directly.
#'
#' In some cases where the raw data is required, the \link{us_map}
#' function located in this package can be used instead.
#'
#' @importFrom dplyr %>%
#' @keywords internal
create_us_map <- function(
  type = c("states", "counties"),
  input_file,
  output_file
) {
  type <- match.arg(type)

  # import map shape file
  us <- sf::read_sf(input_file)

  # ea: US National Atlas Equal Area
  ea_crs <- sf::st_crs(9311)
  us_ea <- sf::st_transform(us, ea_crs)

  # FIPS code for Alaska = 02
  alaska <- us_ea[us_ea$STATEFP == "02", ]
  sf::st_geometry(alaska) <- sf::st_geometry(alaska) * transform(-50, 1 / 2)
  sf::st_geometry(alaska) <- sf::st_geometry(alaska) + c(3e5, -2e6)
  sf::st_crs(alaska) <- ea_crs

  # FIPS code for Hawaii = 15
  hawaii <- us_ea[us_ea$STATEFP == "15", ]
  sf::st_geometry(hawaii) <- sf::st_geometry(hawaii) * transform(-35)
  sf::st_geometry(hawaii) <- sf::st_geometry(hawaii) + c(3.6e6, 1.8e6)
  sf::st_crs(hawaii) <- ea_crs

  # keep only US states (i.e. remove territories, minor outlying islands, etc.)
  # also remove Alaska (02) and Hawaii (15) so that we can add in shifted one
  us_ea <- us_ea[!us_ea$STATEFP %in% c(as.character(57:80), "02", "15"), ]
  us_ea <- rbind(us_ea, alaska, hawaii)

  # delete unused columns
  cols <- c()
  if (type == "states") {
    cols <- c("GEOID", "STUSPS", "NAME")
  } else if (type == "counties") {
    cols <- c("GEOID", "STUSPS", "STATE_NAME", "NAMELSAD")
  }
  us_ea <- us_ea %>% dplyr::select(dplyr::all_of(cols))

  # rename remaining columns
  new_cols <- c()
  if (type == "states") {
    new_cols <- c(fips = "GEOID", abbr = "STUSPS", full = "NAME")
  } else if (type == "counties") {
    new_cols <- c(fips = "GEOID", abbr = "STUSPS", full = "STATE_NAME", county = "NAMELSAD")
  }
  us_ea <- us_ea %>% dplyr::rename(dplyr::all_of(new_cols))

  # sort output
  if (type == "states") {
    us_ea <- us_ea %>% dplyr::arrange(abbr)
  } else if (type == "counties") {
    us_ea <- us_ea %>% dplyr::arrange(abbr, county)
  }

  # export modified shape file
  sf::st_write(us_ea, output_file, append = FALSE)
}

#' @keywords internal
transform <- function(angle = 0, scale = 1) {
  r <- angle * pi / 180
  matrix(c(scale * cos(r), scale * sin(r),
           -scale * sin(r), scale * cos(r)), 2, 2)
}

#' @keywords internal
scale <- function(s) {
  matrix(c(s, 0, 0, s), 2, 2)
}
