# usmapdata 0.3.0

* Update map data to use [2023 shape files](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.2023.html#list-tab-1883739534).

# usmapdata 0.2.2
Released Friday, March 8, 2024.

### Improvements
* Improve language in `DESCRIPTION` and minor documentation, see [Issue #19](https://github.com/pdil/usmapdata/issues/19).

### Bug Fixes
* `alaska_bbox()` and `hawaii_bbox()` now output correct `sf` type (`sfc polygon`).

# usmapdata 0.2.1
Released Sunday, February 4, 2024.

This update continues the `sf` migration by setting the `as_sf` parameter to default to the behavior of `TRUE`. This parameter no longer has any effect, as explained below. The next phase will involve updating `usmap` to no longer make use of this parameter, in which case it can be completely removed.

### Removed

* The `as_sf` parameter is now deprecated and no longer has any effect.
  * As part of this removal, the default behavior for `us_map()`, `centroid_labels()`, and `fips_data()` is equivalent to `as_sf = TRUE` which is to return their data as an `sf` object (see `0.2.0` release notes for more details).
  * This parameter will be completely removed in a future version but continues to exist for compatibility reasons.
* Legacy `.csv` files containing mapping and FIPS data have been removed, greatly reducing package size.

# usmapdata 0.2.0
Released Friday, January 12, 2024.

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
