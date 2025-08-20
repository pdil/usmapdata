# Test harness script to verify map creation functions work as intended.

# Run from within usmapdata.Rproj
devtools::load_all(getwd()) # load local developer build of usmapdata

usmapdata:::create_us_map(
  type = "states",
  input_file = "data-raw/shapefiles/2024/cb_2024_us_state_20m.shp",
  output_dir = "data-raw/test-harness",
  output_file = "us_states.gpkg"
)

file_path <- system.file("data-raw/test-harness/us_states.gpkg", package = "usmapdata")
df <- sf::read_sf(file_path, as_tibble = FALSE)

ggplot2::ggplot(data = df) +
  ggplot2::geom_sf(color = "black", fill = "white")
