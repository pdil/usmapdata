
## Test environments
* local macOS install, R 4.0.3

#### On Github Actions
* macOS-latest (release), R 4.1.2
* windows-latest (release), R 4.1.2
* ubuntu-latest (oldrel, devel, release), R 4.1.2

## R CMD check results

0 errors | 0 warnings | 1 notes

* `extdata` contains the state and county map data frames
which are vital to the function of this package. The data
is unlikely to change often (at most once per year). 
Here is the ```R CMD check``` output:
```
> checking installed package size ... NOTE
    installed size is  6.7Mb
    sub-directories of 1Mb or more:
      extdata   6.6Mb
```

## Downstream dependencies

This is a new release, so there are no reverse dependencies.
