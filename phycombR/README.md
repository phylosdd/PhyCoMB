# R utilities for use with PhyCoMB

## To install as a user:

```R
devtools::install_github("phylosdd/PhyCoMB", subdir = "phycombR")
```

## To work as a developer:

```R
devtools::document() # generate .Rd files in man/
devtools::install()  # make available via library("phycombR")
# or this if necessary:
withr::with_libpaths("~/R_libs/", devtools::install_local())
devtools::check()
devtools::test()     # but still need to set up testthat
```
