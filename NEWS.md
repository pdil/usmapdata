# usmapdata 0.5.0

* Add [2024 shape files](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.2024.html#list-tab-1883739534).

# usmapdata 0.4.0
Released Thursday, March 6, 2025.

### New Features
* Add `data_year` parameter to `us_map()`, see [Issue #34](https://github.com/pdil/usmapdata/issues/34).
  * Allows user to select the year for which to plot US map.
  * This will allow the user to match the map that is provided to the data they are using.
  * To start with, 2021, 2022, and 2023 maps are included.
  * Going forward, each year will be added to the package and previous years can be accessed with this parameter.
  * If the value provided via `data_year` is not available, the package will select the next year for which data exists.
    * For example, if data sets 2022 and 2023 are available and the user calls `us_map(data_year = 2019)`, 2022 will be used.
    * A warning is presented when this occurs to alert the user.
  * Further reading on the impetus for this change: [major changes made to Connecticut counties in 2023](https://www.ctinsider.com/projects/2023/ct-planning-regions/).
  * The old Connecticut counties are available in the 2021 data, 2022 and forward use the new planning regions.

### Improvements
* Improve python script and GitHub Actions workflow that download and process map shapefiles to be more flexible and support new `data_year` feature listed above.
* `centroid_labels()` now accepts `"state"` and `"county"` as inputs for the `regions` parameter like `us_map()` and `fips_data()`.
* Update package author email.

# usmapdata 0.3.0
Released Friday, May 15, 2024.

* Update map data to use [2023 shape files](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.2023.html#list-tab-1883739534).

# usmapdata 0.2.2
Released Friday, March 8, 2024.

### Improvements
* Improve language in `DESCRIPTION` and minor documentation, see [Issue #19](https://github.com/pdil/usmapdata/issues/19).

### Bug Fixes
* `alaska_bbox()` and `hawaii_bbox()` now output correct `sf` type (`sfc_POLYGON`).

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
