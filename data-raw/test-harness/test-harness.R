# Test harness script to verify map creation functions work as intended.

# Run from within usmapdata.Rproj
devtools::load_all(getwd()) # load local developer build of usmapdata

usmapdata:::create_us_map(
  type = "counties",
  input_file = "data-raw/shapefiles/2024/cb_2024_us_county_20m.shp",
  output_dir = "data-raw/test-harness",
  output_file = "us_counties.gpkg"
)

file_path <- system.file("data-raw/test-harness/us_counties.gpkg", package = "usmapdata")
df <- sf::read_sf(file_path, as_tibble = FALSE)

ggplot2::ggplot(data = df[df$abbr == "PR", ]) +
  ggplot2::geom_sf(color = "black", fill = "white")

perform_transform <- function(data, ...) {
  data <- sf::st_as_sf(as.data.frame(data), coords = c("lon", "lat"))
  data_sf <- sf::st_as_sf(data, ...)

  if (is.na(sf::st_crs(data_sf))) {
    crs <- list(...)[["crs"]]
    if (is.null(crs)) crs <- sf::st_crs(4326)
    sf::st_crs(data_sf) <- crs
  }

  # Transform to canonical projection
  transformed <- sf::st_transform(data_sf, usmap::usmap_crs())
  sf::st_agr(transformed) <- "constant"

  # Transform Alaska points
  ak_bbox <- usmapdata:::alaska_bbox()
  alaska <- sf::st_intersection(transformed, ak_bbox)
  alaska <- usmapdata:::transform_alaska(alaska)

  # Transform Hawaii points
  hi_bbox <- usmapdata:::hawaii_bbox()
  hawaii <- sf::st_intersection(transformed, hi_bbox)
  hawaii <- usmapdata:::transform_hawaii(hawaii)

  # Transform Hawaii points
  pr_bbox <- usmapdata:::puerto_rico_bbox()
  puerto_rico <- sf::st_intersection(transformed, pr_bbox)
  puerto_rico <- usmapdata:::transform_puerto_rico(puerto_rico)

  # Re-combine all points
  transformed_excl_ak <- sf::st_difference(transformed, ak_bbox)
  sf::st_agr(transformed_excl_ak) <- "constant"

  transformed_excl_ak_hi <- sf::st_difference(transformed_excl_ak, hi_bbox)
  sf::st_agr(transformed_excl_ak_hi) <- "constant"

  transformed_excl_ak_hi_pr <- sf::st_difference(transformed_excl_ak_hi, pr_bbox)
  sf::st_agr(transformed_excl_ak_hi_pr) <- "constant"

  rbind(transformed_excl_ak_hi_pr, alaska, hawaii, puerto_rico)
}

data <- data.frame(
  lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86, -66.104),
  lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31, 18.466),
  pop = c(8398748, 2325502, 3990456, 2705994, 32113, 347397, 347052)
)

transformed_data <- perform_transform(data)

library(ggplot2)
ggplot(data = df) +
  geom_sf(color = "black", fill = "white") +
  geom_sf(
    data = transformed_data,
    aes(size = pop),
    color = "red", alpha = 0.5
  ) + usmap:::theme_map()

# delete map files
unlink(Sys.glob("data-raw/test-harness/*.gpkg"))
