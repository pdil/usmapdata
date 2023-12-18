🗺️ Updated map data based on latest shapefiles from the US Census Bureau's [cartographic boundary files][1]. Review the changes and fix any issues before merging.

### ✅ Review Checklist
- [ ] Ensure all checks and tests pass
- [ ] Load current branch with `devtools::install_github("usmapdata", "${{ env.branch_name }}")` and test `usmap`
- [ ] Perform visual smoke test of all plotting features to ensure consistency

### 📝 Post-merge Steps
- Update data file changelog in [`usmap/README.md`][2]
- Update [`usmapdata/NEWS.md`][3] with changes before next release

[1]: https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html
[2]: https://github.com/pdil/usmap/blob/master/README.md
[3]: https://github.com/pdil/usmapdata/blob/master/NEWS.md
