
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Hi there 👋

## I’m a geneticist skilled in health data science

-   🏗️ I opportunistically take **data** problems to learn new **tools**
    in the route to solve them, satisfy my own expectations and
    **motivate** myself :)
-   🌱 Highly interested in interdisciplinary, **open** and reproducible
    research, also learning how to **teach** effectively in our current
    remote-land.

### NOW

-   💻 Freelancer;
-   ✨ Crafted last [serosurvey](https://github.com/avallecam/serosurvey)
    :package:;
-   ⭐ Here some slides for the last [useR! conf
    2021](https://github.com/avallecam/serosurvey-user21);
-   🧻 Currently working on writing my thesis and some applications

### BIO

-   🏠 I am a computationally-oriented **Geneticist** formally trained in
    “quantitative” **Epidemiological research**
-   📜 I did my [MSc](https://github.com/avallecam/movmal) at the
    **Universidad Peruana Cayetano Heredia** (2018)
-   📜 I did my [BSc](https://github.com/avallecam/abnomic) at the
    **Universidad Nacional Mayor de San Marcos** (2015)
-   ⚙️ I use `R` daily
-   💬 Ping me about **applied biostatistics**, **data science
    education**, and **epidemiological reproducible research**
-   🌍 I’ trying to be active within the **R Community**
-   📫 Reach me: [avallecam@gmail.com](avallecam@gmail.com)
-   🐤 Twitt me: [`@avallecam`](https://twitter.com/avallecam)

### R :package: projects

-   💚 [serosurvey](https://github.com/avallecam/serosurvey)
-   🚧 [incidenceflow](https://github.com/avallecam/incidenceflow)
-   💚 [covid19viz](https://github.com/avallecam/covid19viz)
-   💚 [epichannel](https://github.com/avallecam/epichannel)
-   💚 [epitidy](https://github.com/avallecam/epitidy)
-   💚 [powder](https://github.com/avallecam/powder)
-   🚧 [sitreper](https://github.com/avallecam/sitreper)
-   💚 [cdcper](https://github.com/avallecam/cdcper)
-   💚 [avallecam](https://github.com/avallecam/avallecam)

# {avallecam} R package

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

-   `adorn_ame`: adorn a
    [`tabyl`](https://cran.r-project.org/web/packages/janitor/vignettes/janitor.html#tabyl---a-better-version-of-table)
    with totals on margins, percentages and N on values in only one
    function!
-   `print_inf`: make a quick(er) `print(n=Inf)`
-   `read_lastfile`: read the last file in a folder (ideal for workflows
    with daily inputs and updates)

### spatial data management

-   `read_gpx`: read GPX extension formats
-   `st_coordinates_tidy`: a tidy alternative to `sf::st_coordinates`.
    it retrieve coordinates within the original sf/data.frame object.
-   `sf_as_ppp`: integrates point geometry dataset and a boundary to
    create a ppp for spatstat analysis. [clink here for more
    information](https://github.com/r-spatial/sf/issues/1233).
-   `tibble_as_raster`: transform a x,y,z tibble to a raster.

### movement data management

-   `sum_range_h`: custom function to calculate amount of hours between
    to reported times
-   `get_distance_m`: generates a distance output between two set of
    points within a tibble and flexible with `dplyr::group_by` and
    `purrr::pmap`
