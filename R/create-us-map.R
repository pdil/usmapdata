
#' Internal map creation tools
#'
#' @description
#' `create_us_map()` creates the modified shapefiles used by the
#' \link[usmap]{usmap} package.
#'
#' `ea_crs()` returns the US National Atlas Equal Area coordinate reference system
#' (CRS) used by this package and `usmap`.
#'
#' `transform2D()` computes a two dimensional affine transformation matrix
#' for the provided rotation angle and scale factor.
#'
#' `transform_alaska()` applies the appropriate transform for the Alaska polygons.
#'
#' `transform_hawaii()` applies the appropriate transform for the Hawaii polygons.
#'
#' `compute_centroids()` computes the modified centroids for each state or
#' county polygon using a center-of-mass technique on the largest polygon in
#' the region.
#'
#' `alaska_bbox()` returns the bounding box of Alaska pre-transformation.
#'
#' `hawaii_bbox()` returns the bounding box of Hawaii pre-transformation.
#'
#' @note
#' Using these functions externally is not recommended since they make certain
#' undocumented assumptions that may not work with all inputs.
#'
#' It is strongly recommend that the \link[usmap]{usmap} package is used
#' directly.
#'
#' In some cases where the raw data is required, the \link{us_map} and
#' \link{centroid_labels} functions located in this package can be used instead.
#'
#' @references {
#'  Gert (2017). “How to calculate
#'  polygon centroids in R (for
#'  non-contiguous shapes).”
#'  <https://gis.stackexchange.com/a/265475>.
#'
#'  Rudis B (2014). “Moving The Earth
#'  (well, Alaska & Hawaii) With R.”
#'  <https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/>.
#' }
#'
#' @keywords internal
create_us_map <- function(
  type = c("states", "counties"),
  input_file,
  output_file
) {
  # check for dplyr
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("`dplyr` must be installed to use `create_us_map()`.
         Use: install.packages(\"dplyr\") and try again.")
  }

  type <- match.arg(type)

  # import map file
  us <- sf::read_sf(input_file)

  # ea: US National Atlas Equal Area
  us_ea <- sf::st_transform(us, ea_crs())

  # FIPS code for Alaska = 02
  alaska <- transform_alaska(us_ea[us_ea$STATEFP == "02", ])

  # FIPS code for Hawaii = 15
  hawaii <- transform_hawaii(us_ea[us_ea$STATEFP == "15", ])

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
  us_ea <- dplyr::select(us_ea, dplyr::all_of(cols))

  # rename remaining columns
  new_cols <- c()
  if (type == "states") {
    new_cols <- c(fips = "GEOID", abbr = "STUSPS", full = "NAME")
  } else if (type == "counties") {
    new_cols <- c(fips = "GEOID", abbr = "STUSPS", full = "STATE_NAME", county = "NAMELSAD")
  }
  us_ea <- dplyr::rename(us_ea, dplyr::all_of(new_cols))

  # sort output
  if (type == "states") {
    us_ea <- dplyr::arrange(us_ea, .data$abbr)
  } else if (type == "counties") {
    us_ea <- dplyr::arrange(us_ea, .data$abbr, .data$county)
  }

  # export modified shape file
  sf::st_write(us_ea, output_file, quiet = TRUE, append = FALSE)

  # compute centroids
  centroids <- compute_centroids(us_ea)

  # determine centroids file path
  centroids_output_file <- file.path(
    dirname(output_file),
    paste0(
      tools::file_path_sans_ext(basename(output_file)),
      "_centroids.",
      tools::file_ext(output_file)
    )
  )

  # export centroids
  sf::st_write(centroids, centroids_output_file, quiet = TRUE, append = FALSE)
}

#' @rdname create_us_map
#' @keywords internal
ea_crs <- function() {
  sf::st_crs(9311)  # US National Atlas Equal Area coordinate reference system
}

#' @rdname create_us_map
#' @keywords internal
transform2D <- function(angle = 0, scale = 1) {
  r <- angle * pi / 180
  matrix(c(scale * cos(r), scale * sin(r),
           -scale * sin(r), scale * cos(r)), 2, 2)
}

#' @rdname create_us_map
#' @keywords internal
transform_alaska <- function(alaska) {
  sf::st_geometry(alaska) <- sf::st_geometry(alaska) * transform2D(-50, 1 / 2)
  sf::st_geometry(alaska) <- sf::st_geometry(alaska) + c(3e5, -2e6)
  sf::st_crs(alaska) <- ea_crs()

  alaska
}

#' @rdname create_us_map
#' @keywords internal
transform_hawaii <- function(hawaii) {
  sf::st_geometry(hawaii) <- sf::st_geometry(hawaii) * transform2D(-35)
  sf::st_geometry(hawaii) <- sf::st_geometry(hawaii) + c(3.6e6, 1.8e6)
  sf::st_crs(hawaii) <- ea_crs()

  hawaii
}

#' @rdname create_us_map
#' @keywords internal
compute_centroids <- function(polygons, iterations = 3, initial_width_step = 10) {
  if (iterations < 1) {
    stop("`iterations` must be greater than or equal to 1.")
  }

  if (initial_width_step < 1) {
    stop("`initial_width_step` must be greater than or equal to 1.")
  }

  new_polygons <- sf::st_as_sf(polygons)

  # Iterate through each provided polygon
  for (i in seq_len(nrow(polygons))) {
    width <- -initial_width_step
    area <- as.numeric(sf::st_area(polygons[i, ]))
    current_polygon <- polygons[i, ]

    isEmpty <- FALSE
    for (j in 1:iterations) {
      # Stop if buffer polygon becomes empty
      if (!isEmpty) {
        buffer <- sf::st_buffer(current_polygon, dist = width)

        # Repeatedly increase buffer size until non-empty if needed
        subtract_width <- width / 20
        while (sf::st_is_empty(buffer)) {
          width <- width - subtract_width
          buffer <- sf::st_buffer(current_polygon, dist = width)
          isEmpty <- TRUE
        }

        new_area <- as.numeric(sf::st_area(buffer))

        # Determine width needed to reduce area to 1/4 of current
        # for next iteration
        slope <- (new_area - area) / width
        width <- (area / 4 - area) / slope

        # Set values for next iteration
        area <- new_area
        current_polygon <- buffer
      }
    }

    # Determine biggest polygon in case of multiple polygons
    d <- sf::st_geometry(current_polygon)

    if (length(d) > 1) {
      biggest_area <- sf::st_area(d[1, ])

      which_polygon <- 1
      for (k in 2:length(d)) {
        if (sf::st_area(d[k, ]) > biggest_area) {
          biggest_area <- sf::st_area(d[k, ])
          which_polygon <- k
        }
      }

      current_polygon <- d[which_polygon, ]
    }

    # Replace existing polygon with new polygon
    new_polygons[i, ] <- current_polygon
  }

  # Return centroids of newly computed polygons
  sf::st_agr(new_polygons) <- "constant"
  sf::st_centroid(new_polygons)
}

#' @rdname create_us_map
#' @keywords internal
alaska_bbox <- function() {
  sf::st_as_sfc(
    sf::st_bbox(
      c(
        xmin = -4377000,
        xmax = -1519000,
        ymin = 1466000,
        ymax = 3914000
      ),
      crs = ea_crs()
    )
  )
}

#' @rdname create_us_map
#' @keywords internal
hawaii_bbox <- function() {
  sf::st_as_sfc(
    sf::st_bbox(
      c(
        xmin = -5750000,
        xmax = -5450000,
        ymin = -1050000,
        ymax = -441000
      ),
      crs = ea_crs()
    )
  )
}
