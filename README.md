# 🗺 usmapdata

[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fpdil%2Fusmapdata%2Fbadge%3Fref%3Dmaster&style=popout&label=build)](https://actions-badge.atrox.dev/pdil/usmapdata/goto?ref=master) [![codecov](https://codecov.io/gh/pdil/usmapdata/branch/master/graph/badge.svg)](https://app.codecov.io/gh/pdil/usmapdata)

You might be looking for the `usmap` package: [CRAN](https://cran.r-project.org/package=usmap) | [Github](https://github.com/pdil/usmap) | [Website](https://usmap.dev)

## Purpose

`usmapdata` is a container package for the map data frame used in the [`usmap`](https://github.com/pdil/usmap) package. This data has been extracted to keep `usmap` small and easier to maintain, while allowing the ability to keep the US map data frame updated as often as possible (independently of `usmap` updates).

This package and repository will only contain functions and data relevant to the actual map data frame used to draw the map in the `usmap` package. All other functions, including FIPS and mapping convenience functions, will be contained in the `usmap` [repository](https://github.com/pdil/usmap).

## Shape Files
The shape files that we use to plot the maps in R are located in the `data-raw` folder. For more information refer to the [US Census Bureau](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html). Maps at both the state and county levels are included for convenience (zip code maps may be included in the future).

### Updating Shape Files
The [Cartographic Boundary Files](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html) are used for mapping in `usmap`, specifically the 1:20m scale files. This low resolution allows for small file sizes while still allowing enough detail for simple choropleths. The file description can be read [here](https://www.census.gov/programs-surveys/geography/technical-documentation/naming-convention/cartographic-boundary-file.html).

<details>
    <summary>Follow these steps to update the files used within the project (click to expand)</summary>
    <br>
    <ol>
        <li>Go to https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html and select the most recent year available.</li>
        <li>In the <strong>Cartographic Boundary Files by Geography</strong> section, download the following files to the <code>data-raw</code> folder:</li>
        <ul>
            <li>Counties 1 : 20,000,000 (national) shapefile</li>
            <li>States 1 : 20,000,000 (national) shapefile</li>
        </ul>
        <li>Refer to the <a href="https://www.census.gov/programs-surveys/geography/technical-documentation/county-changes.2020.html">county changes documentation</a> and make any relevant updates to <code>county-fips.csv</code></li>
        <li>Delete the folders from older years (e.g. <code>cb_2017_us_county_20m</code>)</li>
        <li>Run <code>create-map-df.R</code></li>
        <li>Run <code>format-map-df.R</code></li>
        <li>Copy the following files to <code>inst/extdata</code>:</li>
        <ul>
            <li><code>us_counties_centroids.csv</code></li>
            <li><code>us_counties.csv</code></li>
            <li><code>us_states_centroids.csv</code></li>
            <li><code>us_states.csv</code></li>
            <li><code>county_fips.csv</code> (if changed)</li>
        </ul>
    </ol>
    </code>
    After applying these changes, <a href=https://github.com/pdil/usmapdata/compare>open a pull request</a> and await review.
</details>

## Installation
This package should only be installed if you intend to manipulate the US mapping data frame, which contains coordinates to draw the US state and county boundaries. If you're interested in plotting data on a US map, use the [`usmap`](https://github.com/pdil/usmap) package.

To install from CRAN _(recommended)_, run the following code in an R console:
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
`usmap` uses an [Albers equal-area conic projection](https://en.wikipedia.org/wiki/Albers_projection), with arguments as follows:

<details>
    <summary><code>usmap::usmap_crs()</code></summary>

    ```
    #> Coordinate Reference System:
    #> Deprecated Proj.4 representation:
    #>  +proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0 +ellps=sphere
    #> +units=m +no_defs 
    #> WKT2 2019 representation:
    #> PROJCRS["unknown",
    #>     BASEGEOGCRS["unknown",
    #>         DATUM["unknown",
    #>             ELLIPSOID["Normal Sphere (r=6370997)",6370997,0,
    #>                 LENGTHUNIT["metre",1,
    #>                     ID["EPSG",9001]]]],
    #>         PRIMEM["Greenwich",0,
    #>             ANGLEUNIT["degree",0.0174532925199433],
    #>             ID["EPSG",8901]]],
    #>     CONVERSION["unknown",
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
    #>         AXIS["(E)",east,
    #>             ORDER[1],
    #>             LENGTHUNIT["metre",1,
    #>                 ID["EPSG",9001]]],
    #>         AXIS["(N)",north,
    #>             ORDER[2],
    #>             LENGTHUNIT["metre",1,
    #>                 ID["EPSG",9001]]]] 
    ```
</details>

This is the same projection used by the [US National Atlas](https://epsg.io/2163).

To obtain the projection used by `usmap`, use `usmap_crs()`.

Alternatively, the CRS ([coordinate reference system](https://www.nceas.ucsb.edu/sites/default/files/2020-04/OverviewCoordinateReferenceSystems.pdf)) can be created manually with the following command:
```r
sp::CRS(paste("+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0",
              "+a=6370997 +b=6370997 +units=m +no_defs"))
```

## Acknowledgments
The code used to generate the map files was based on this blog post by [Bob Rudis](https://github.com/hrbrmstr):    
[Moving The Earth (well, Alaska & Hawaii) With R](https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/)
