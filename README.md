# 🗺 usmapdata

[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fpdil%2Fusmapdata%2Fbadge%3Fref%3Dmaster&style=popout&label=build)](https://actions-badge.atrox.dev/pdil/usmapdata/goto?ref=master) [![codecov](https://codecov.io/gh/pdil/usmapdata/branch/master/graph/badge.svg)](https://codecov.io/gh/pdil/usmapdata)

[under construction]

You might be looking for the `usmap` package: [CRAN](https://cran.r-project.org/package=usmap) | [Github](https://github.com/pdil/usmap) | [Website](https://usmap.dev)

## Purpose

`usmapdata` is a container package for the map data frame used in the [`usmap`](https://github.com/pdil/usmap) package. This data has been extracted to keep `usmap` small and easier to maintain, while allowing the ability to keep the US map data frame updated as often as possible (independently of `usmap` updates).

This package and repository will only contain functions and data relevant to the actual map data frame used to draw the map in the `usmap` package. All other functions, including FIPS and mapping convenience functions, will be contained in the `usmap` [repository](https://github.com/pdil/usmap).

## Shape Files
The shape files that we use to plot the maps in R are located in the `data-raw` folder. For more information refer to the [US Census Bureau](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html). Maps at both the state and county levels are included for convenience (zip code maps may be included in the future).

### Updating Shape Files
The [Cartographic Boundary Files](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html) are used for mapping in `usmap`, specifically the 1:20m scale files. This low resolution allows for small file sizes while still allowing enough detail for simple choropleths. The file description can be read [here](https://www.census.gov/programs-surveys/geography/technical-documentation/naming-convention/cartographic-boundary-file.html).

Follow these steps to update the files used within the project:
1. Go to https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html and select the most recent year available.
2. In the `Cartographic Boundary Files by Geography` section, download the following files to the `data-raw` folder:
* Counties 1 : 20,000,000 (national) shapefile
* States 1 : 20,000,000 (national) shapefile
3. Refer to the [county changes documentation](https://www.census.gov/programs-surveys/geography/technical-documentation/county-changes.2020.html) and make any relevant updates to `county-fips.csv`
4. Delete the folders from older years (e.g. `cb_2017_us_county_20m`)
5. Run `create-map-df.R`
6. Run `format-map-df.R`
7. Copy the following files to `inst/extdata`:
* `us_counties_centroids.csv`
* `us_counties.csv`
* `us_states_centroids.csv`
* `us_states.csv`
* `county_fips.csv` (if changed)

After applying these changes, [open a pull request](https://github.com/pdil/usmapdata/compare) and await review. 

## Installation
This package should only be installed if you intend to manipulate the US mapping data frame, which contains coordinates to draw the US state and county boundaries. If you're interested in plotting data on a US map, use the [`usmap`](https://github.com/pdil/usmap) package.

To install from CRAN _(coming soon)_, run the following code in an R console:
```r
install.packages("usmapdata")
```
To install the package from this repository, run the following code in an R console:
```r
# install.package("devtools")
devtools::install_github("pdil/usmapdata")
```
Installing using `devtools::install_github` will provide the most recent developer build of `usmapdata`.

⚠️ The developer build may be unstable and not function correctly, use with caution.

To begin using `usmapdata`, import the package using the `library` command:
```r
library(usmapdata)
```

## Additional Information

### Projection
`usmap` and `usmapdata` use an [Albers equal-area conic projection](https://en.wikipedia.org/wiki/Albers_projection), with arguments as follows:
```r
usmap::usmap_crs()
#> CRS arguments:
#>     +proj=laea +lat_0=45 +lon_0=-100 +x_0=0
#>     +y_0=0 +a=6370997 +b=6370997 +units=m
#>     +no_defs 
```

To obtain the projection used by `usmap` and `usmapdata`, use `usmap_crs()`.

Alternatively, the CRS ([coordinate reference system](https://www.nceas.ucsb.edu/sites/default/files/2020-04/OverviewCoordinateReferenceSystems.pdf)) can be created manually with the following command:
```r
sp::CRS("+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0
         +a=6370997 +b=6370997 +units=m +no_defs")
```
