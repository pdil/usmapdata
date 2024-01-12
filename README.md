# 🗺 usmapdata

[![R-CMD check](https://github.com/pdil/usmapdata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pdil/usmapdata/actions/workflows/R-CMD-check.yaml) [![codecov](https://codecov.io/gh/pdil/usmapdata/branch/master/graph/badge.svg)](https://app.codecov.io/gh/pdil/usmapdata)

You might be looking for the `usmap` package: [CRAN](https://cran.r-project.org/package=usmap) | [GitHub](https://github.com/pdil/usmap) | [Website](https://usmap.dev)

## Purpose

`usmapdata` is a container package for the map data frame used in the [`usmap`](https://github.com/pdil/usmap) package. This data has been extracted to keep `usmap` small and easier to maintain, while allowing the ability to keep the US map data frame updated as often as possible (independently of `usmap` updates).

This package and repository will only contain functions and data relevant to the actual map and FIPS data used to draw the map in the `usmap` package. All other functions, including FIPS and mapping convenience functions, will be contained in the `usmap` [repository](https://github.com/pdil/usmap).

## Map Data
The map data files that we use to plot the maps in R are located in the `inst/extdata` folder. They are generated from shapefiles published by the [US Census Bureau](https://www.census.gov/). Data files for maps and FIPS codes at both the state and county levels are included.

The [Cartographic Boundary Files](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html) are used for mapping in `usmap`—specifically the 1:20m scale files. This low resolution allows for small file sizes while still allowing enough detail for simple choropleths. The file description can be read [here](https://www.census.gov/programs-surveys/geography/technical-documentation/naming-convention/cartographic-boundary-file.html).

Shapefiles are updated yearly by the US Census Bureau. This repository contains scripts which periodically check for new shapefiles and update the data in the package accordingly. For more details see the [`data-raw`](https://github.com/pdil/usmapdata/tree/master/data-raw) directory.

## Installation
This package should only be installed if you intend to manipulate the US mapping data frame, which contains coordinates to draw the US state and county boundaries. If you're interested in plotting data on a US map, use the [`usmap`](https://github.com/pdil/usmap) package.

📦 To install from CRAN (recommended), run the following code in an R console:
```r
install.packages("usmapdata")
```

### Developer Build
⚠️ The developer build may be unstable and not function correctly, use with caution.

To install the package from this repository, run the following code in an R console:
```r
# install.package("devtools")
devtools::install_github("pdil/usmapdata")
```
This method will provide the most recent developer build of `usmapdata`.

## Usage
To begin using `usmapdata`, import the package using the `library` command:
```r
library(usmapdata)
```

## Additional Information

### Coordinate System
`usmap` uses the [US National Atlas Equal Area](https://epsg.io/9311) coordinate system:

<details>
    <summary><code>sf::st_crs(9311)</code></summary>

    ```r
    #> Coordinate Reference System:
    #>   User input: EPSG:9311
    #>   wkt:
    #> PROJCRS["NAD27 / US National Atlas Equal Area",
    #>     BASEGEOGCRS["NAD27",
    #>         DATUM["North American Datum 1927",
    #>             ELLIPSOID["Clarke 1866",6378206.4,294.978698213898,
    #>                 LENGTHUNIT["metre",1]]],
    #>         PRIMEM["Greenwich",0,
    #>             ANGLEUNIT["degree",0.0174532925199433]],
    #>         ID["EPSG",4267]],
    #>     CONVERSION["US National Atlas Equal Area",
    #>         METHOD["Lambert Azimuthal Equal Area (Spherical)",
    #>             ID["EPSG",1027]],
    #>         PARAMETER["Latitude of natural origin",45,
    #>             ANGLEUNIT["degree",0.0174532925199433],
    #>             ID["EPSG",8801]],
    #>         PARAMETER["Longitude of natural origin",-100,
    #>             ANGLEUNIT["degree",0.0174532925199433],
    #>             ID["EPSG",8802]],
    #>         PARAMETER["False easting",0,
    #>             LENGTHUNIT["metre",1],
    #>             ID["EPSG",8806]],
    #>         PARAMETER["False northing",0,
    #>             LENGTHUNIT["metre",1],
    #>             ID["EPSG",8807]]],
    #>     CS[Cartesian,2],
    #>         AXIS["easting (X)",east,
    #>             ORDER[1],
    #>             LENGTHUNIT["metre",1]],
    #>         AXIS["northing (Y)",north,
    #>             ORDER[2],
    #>             LENGTHUNIT["metre",1]],
    #>     USAGE[
    #>         SCOPE["Statistical analysis."],
    #>         AREA["United States (USA) - onshore and offshore."],
    #>         BBOX[15.56,167.65,74.71,-65.69]],
    #>     ID["EPSG",9311]]
    ```
</details>

This [coordinate reference system (CRS)](https://www.nceas.ucsb.edu/sites/default/files/2020-04/OverviewCoordinateReferenceSystems.pdf) can also be obtained with `usmap::usmap_crs()`.

## Acknowledgments
The code used to generate the map files was based on this blog post by [Bob Rudis](https://github.com/hrbrmstr):
[Moving The Earth (well, Alaska & Hawaii) With R](https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/)
