
<!-- README.md is generated from README.Rmd. Please edit that file -->

# avallecam

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/avallecam)](https://cran.r-project.org/package=avallecam)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4014183.svg)](https://doi.org/10.5281/zenodo.4014183)
<!-- badges: end -->

Personal library for custom R functions.

## Installation

<!-- You can install the released version of avallecam from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("avallecam") -->

<!-- ``` -->

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("avallecam/avallecam")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(avallecam)
## basic example code
```

## Main functionalities

Check the [reference
page](https://avallecam.github.io/avallecam/reference/index.html) for
examples.

### to make my life -just a little bit more- easy

  - `adorn_ame`: adorn a
    [`tabyl`](https://cran.r-project.org/web/packages/janitor/vignettes/janitor.html#tabyl---a-better-version-of-table)
    with totals on margins, percentages and N on values in only one
    function\!
  - `print_inf`: make a quick(er) `print(n=Inf)`
  - `read_lastfile`: read the last file in a folder (ideal for workflows
    with daily inputs and updates)

### spatial data management

  - `read_gpx`: read GPX extension formats
  - `st_coordinates_tidy`: a tidy alternative to `sf::st_coordinates`.
    it retrieve coordinates within the original sf/data.frame object.
  - `sf_as_ppp`: integrates point geometry dataset and a boundary to
    create a ppp for spatstat analysis. [clink here for more
    information](https://github.com/r-spatial/sf/issues/1233).
  - `tibble_as_raster`: transform a x,y,z tibble to a raster.

### movement data management

  - `sum_range_h`: custom function to calculate amount of hours between
    to reported times
  - `get_distance_m`: generates a distance output between two set of
    points within a tibble and flexible with `dplyr::group_by` and
    `purrr::pmap`
