pkgname <- "usmap"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('usmap')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("dot-east_north_central")
### * dot-east_north_central

flush(stderr()); flush(stdout())

### Name: .east_north_central
### Title: East North Central census division
### Aliases: .east_north_central
### Keywords: datasets

### ** Examples

plot_usmap(include = .east_north_central, labels = TRUE)



cleanEx()
nameEx("dot-east_south_central")
### * dot-east_south_central

flush(stderr()); flush(stdout())

### Name: .east_south_central
### Title: East South Central census division
### Aliases: .east_south_central
### Keywords: datasets

### ** Examples

plot_usmap(include = .east_south_central, labels = TRUE)



cleanEx()
nameEx("dot-mid_atlantic")
### * dot-mid_atlantic

flush(stderr()); flush(stdout())

### Name: .mid_atlantic
### Title: Mid-Atlantic census division
### Aliases: .mid_atlantic
### Keywords: datasets

### ** Examples

plot_usmap(include = .mid_atlantic, labels = TRUE)



cleanEx()
nameEx("dot-midwest_region")
### * dot-midwest_region

flush(stderr()); flush(stdout())

### Name: .midwest_region
### Title: Midwest census region
### Aliases: .midwest_region
### Keywords: datasets

### ** Examples

plot_usmap(include = .midwest_region, labels = TRUE)



cleanEx()
nameEx("dot-mountain")
### * dot-mountain

flush(stderr()); flush(stdout())

### Name: .mountain
### Title: Mountain census division
### Aliases: .mountain
### Keywords: datasets

### ** Examples

plot_usmap(include = .mountain, labels = TRUE)



cleanEx()
nameEx("dot-new_england")
### * dot-new_england

flush(stderr()); flush(stdout())

### Name: .new_england
### Title: New England census division
### Aliases: .new_england
### Keywords: datasets

### ** Examples

plot_usmap(include = .new_england, labels = TRUE)



cleanEx()
nameEx("dot-north_central_region")
### * dot-north_central_region

flush(stderr()); flush(stdout())

### Name: .north_central_region
### Title: North-Central census region
### Aliases: .north_central_region
### Keywords: datasets

### ** Examples

plot_usmap(include = .north_central_region, labels = TRUE)



cleanEx()
nameEx("dot-northeast_region")
### * dot-northeast_region

flush(stderr()); flush(stdout())

### Name: .northeast_region
### Title: Northeast census region
### Aliases: .northeast_region
### Keywords: datasets

### ** Examples

plot_usmap(include = .northeast_region, labels = TRUE)



cleanEx()
nameEx("dot-pacific")
### * dot-pacific

flush(stderr()); flush(stdout())

### Name: .pacific
### Title: Pacific census division
### Aliases: .pacific
### Keywords: datasets

### ** Examples

plot_usmap(include = .pacific, labels = TRUE)



cleanEx()
nameEx("dot-south_atlantic")
### * dot-south_atlantic

flush(stderr()); flush(stdout())

### Name: .south_atlantic
### Title: South Atlantic census division
### Aliases: .south_atlantic
### Keywords: datasets

### ** Examples

plot_usmap(include = .south_atlantic, labels = TRUE)



cleanEx()
nameEx("dot-south_region")
### * dot-south_region

flush(stderr()); flush(stdout())

### Name: .south_region
### Title: South census region
### Aliases: .south_region
### Keywords: datasets

### ** Examples

plot_usmap(include = .midwest_region, labels = TRUE)



cleanEx()
nameEx("dot-west_north_central")
### * dot-west_north_central

flush(stderr()); flush(stdout())

### Name: .west_north_central
### Title: West North Central census division
### Aliases: .west_north_central
### Keywords: datasets

### ** Examples

plot_usmap(include = .west_north_central, labels = TRUE)



cleanEx()
nameEx("dot-west_region")
### * dot-west_region

flush(stderr()); flush(stdout())

### Name: .west_region
### Title: West census region
### Aliases: .west_region
### Keywords: datasets

### ** Examples

plot_usmap(include = .midwest_region, labels = TRUE)



cleanEx()
nameEx("dot-west_south_central")
### * dot-west_south_central

flush(stderr()); flush(stdout())

### Name: .west_south_central
### Title: West South Central census division
### Aliases: .west_south_central
### Keywords: datasets

### ** Examples

plot_usmap(include = .west_south_central, labels = TRUE)



cleanEx()
nameEx("fips")
### * fips

flush(stderr()); flush(stdout())

### Name: fips
### Title: Retrieve FIPS code for either a US state or county
### Aliases: fips

### ** Examples

fips()

fips("NJ")
fips("California")

fips(c("AK", "CA", "UT"))

fips("CA", county = "orange")
fips(state = "AL", county = "autauga")
fips(state = "Alabama", county = "Autauga County")



cleanEx()
nameEx("fips_info")
### * fips_info

flush(stderr()); flush(stdout())

### Name: fips_info
### Title: Retrieve states or counties using FIPS codes
### Aliases: fips_info fips_info.numeric fips_info.character

### ** Examples

fips_info(2)
fips_info("2")
fips_info(c("02", "03", "04"))

fips_info(2016)
fips_info(c("02016", "02017"), sortAndRemoveDuplicates = TRUE)




cleanEx()
nameEx("map_with_data")
### * map_with_data

flush(stderr()); flush(stdout())

### Name: map_with_data
### Title: Join county or state level data to US map data
### Aliases: map_with_data

### ** Examples

state_data <- data.frame(fips = c("01", "02", "04"), values = c(1, 5, 8))
df <- map_with_data(state_data, na = 0)

state_data <- data.frame(state = c("AK", "CA", "Utah"), values = c(6, 9, 3))
df <- map_with_data(state_data, na = 0)




cleanEx()
nameEx("plot_usmap")
### * plot_usmap

flush(stderr()); flush(stdout())

### Name: plot_usmap
### Title: Conveniently plot basic US map
### Aliases: plot_usmap

### ** Examples

plot_usmap()
plot_usmap(regions = "states")
plot_usmap(regions = "counties")
plot_usmap(regions = "state")
plot_usmap(regions = "county")

# Output is ggplot object so it can be extended
# with any number of ggplot layers
library(ggplot2)
plot_usmap(include = c("CA", "NV", "ID", "OR", "WA")) +
  labs(title = "Western States")

# Color maps with data
plot_usmap(data = statepop, values = "pop_2022")

# Include labels on map (e.g. state abbreviations)
plot_usmap(data = statepop, values = "pop_2022", labels = TRUE)
# Choose color for labels
plot_usmap(data = statepop, values = "pop_2022", labels = TRUE, label_color = "white")




cleanEx()
nameEx("us_map")
### * us_map

flush(stderr()); flush(stdout())

### Name: us_map
### Title: Retrieve US map data
### Aliases: us_map

### ** Examples

str(us_map())

df <- us_map(regions = "counties")
west_coast <- us_map(include = c("CA", "OR", "WA"))

south_atl_excl_FL <- us_map(include = .south_atlantic, exclude = "FL")



cleanEx()
nameEx("usmap_transform")
### * usmap_transform

flush(stderr()); flush(stdout())

### Name: usmap_transform
### Title: Convert spatial data to usmap projection
### Aliases: usmap_transform usmap_transform.sf usmap_transform.data.frame

### ** Examples

data <- data.frame(
  lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
  lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31),
  pop = c(8398748, 2325502, 3990456, 2705994, 32113, 347397)
)

# Transform data
transformed_data <- usmap_transform(data)

# Plot transformed data on map
library(ggplot2)

plot_usmap() + geom_sf(
  data = transformed_data,
  aes(size = pop),
  color = "red", alpha = 0.5
)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
