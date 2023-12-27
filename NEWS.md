# usmapdata 0.2.0

### Improvements
* Update map data to use [2022 shape files](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.2022.html#list-tab-1883739534).
* Begin process of upgrading map data to use GeoPackage files instead of csv.
  * Previously the files were created using now-retired packages `rgdal`, `rgeos`, and `maptools`.
  * The new files can be accessed by passing `as_sf = TRUE` to the `us_map()` and `fips_data()` functions.
  * Once the upgrade is complete, this parameter will be removed and the new functionality will be the default.
  * The new map files are smaller in size while maintaining the same resolution.
  * The format of the data also allows for easier manipulation in the future using the `sf` package.
* Add scripts to perform automated map data updates, see [Issue #5](https://github.com/pdil/usmapdata/issues/5).
  * The scripts will check for new shapefiles from the US Census Bureau twice a year and automatically update the data.
  * The scripts can also be run manually as needed.
  * Once data is updated a new `usmapdata` release will be created.

# usmapdata 0.1.2
Released Monday, December 11, 2023.

* Add `fips_data` function to load raw FIPS data from included csv files.
    * `fips_data()`, `fips_data("state")`, or `fips_data("states")` load state FIPS codes
    * `fips_data("county")` or `fips_data("counties")` load county FIPS codes

# usmapdata 0.1.1
Released Saturday, October 21, 2023.

* Update package author email and website.

# usmapdata 0.1.0
Released Wednesday, February 2, 2022.

* First release

### Main features

* Contains the `us_map` function and associated data extracted from the `usmap` package
* Will allow future removal of data from `usmap` package so file size can be reduced greatly.
