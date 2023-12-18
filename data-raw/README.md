# 🤖 `usmapdata` Automated Updates

The scripts contained here are used to automatically update the map data files used by the [`usmap`](https://github.com/pdil/usmap) and [`usmapdata`](https://github.com/pdil/usmapdata) packages.

The scripts and configuration files contained here are used by the [`update-data.yml`](https://github.com/pdil/usmapdata/blob/master/.github/workflows/update-data.yml) GitHub Actions workflow which runs monthly on the first of each month. When the workflow finds new map shapefiles, it will automatically create a pull request with the processed map data files and send a push notification to the package maintainer. Once the pull request is tested and merged, a new release for `usmapdata` will be deployed.

## File Descriptions

The purpose of the files in this folder are as follows:

* `scripts/config.ini`: parameters used by `shapefiles.py` script to download shapefiles. `current_year` is the year of the data currently existing in the package.
* `scripts/pushover.py`: sends [Pushover](https://pushover.net) notifications to the package maintainer
* `scripts/requirements.txt`: Python dependencies for the scripts used by the workflow
* `scripts/shapefiles.py`: checks for and downloads the files specified by `config.ini` to the `shapefiles/` directory
* `scripts/update-data-pr-body.md`: The template used for the body of the pull request opened by the workflow once files have been updated.
* `shapefiles/`: contains the raw shapefiles downloaded by the workflow for the current year

The final processed map data files are located in `inst/extdata` so they can be used from within the R package.