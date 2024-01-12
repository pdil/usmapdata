
## Test environments
* local macOS install, R 4.3.0

#### On Github Actions
* macOS-latest (release), R 4.3.0
* windows-latest (release), R 4.3.0
* ubuntu-latest (oldrel, devel, release), R 4.3.0

## R CMD check results

0 errors | 0 warnings | 1 notes

* `extdata` contains the state and county map data frames
which are vital to the function of this package. The size of this
data will be greatly reduced in an upcoming future update of
`usmapdata` (reduced to ~1-2 MB). It is currently this size for
compatability with the current version of `usmap` which relies
on the old data format. Once `usmap` is updated another update
to this package will be released which removes the large data
files.

Here is the ```R CMD check``` output:
```
❯ checking installed package size ... NOTE
    installed size is  8.5Mb
    sub-directories of 1Mb or more:
      extdata   8.4Mb
```

## Downstream dependencies

I have also run R CMD check on downstream dependencies of usmapdata:

* usmap
