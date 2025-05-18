
## Test environments
* local macOS install, R 4.4.3

#### On Github Actions
* macOS-latest (release), R 4.4.3
* windows-latest (release), R 4.4.3
* ubuntu-latest (oldrel, devel, release), R 4.4.3

## R CMD check results

0 errors | 0 warnings | 1 notes

* `extdata` contains the state and county map data
which are vital to the function of this package. Multiple years
of data are included due to significant changes in 2021/2022.
Here is the ```R CMD check``` output:
```
❯ checking installed package size ... NOTE
    installed size is  9.8Mb
    sub-directories of 1Mb or more:
      extdata   9.7Mb
```

## Downstream dependencies

I have also run R CMD check on downstream dependencies of usmapdata:

* usmap
