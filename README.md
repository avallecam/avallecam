# avallecam

Personal library for custom R functions.

## Installation

Type this in your R console: 

```r
if(!require("devtools")) install.packages("devtools")
devtools::install_github("avallecam/avallecam")
```

## Main functionalities

Check the [reference page](https://avallecam.github.io/avallecam/reference/index.html) for examples.

### epidemiologically usefull

- `epi_tidymodel_*`: summmarize core estimates for OR, RR, PR regression models and linear regression coefficients.
- `epi_tidymodel_up`: update raw models to generate various simple models or adjusted by one parsimous model
- all of these are based on [`broom`](https://broom.tidyverse.org/index.html)

### to make my life -just a little bit more- easy

- `adorn_ame`: adorn a [`tabyl`](https://cran.r-project.org/web/packages/janitor/vignettes/janitor.html#tabyl---a-better-version-of-table) with totals on margins, percentages and N on values in only one function! 
- `print_inf`: make a quick(er) `print(n=Inf)`
- `read_lastfile`: read the last file in a folder (ideal for workflows with daily inputs and updates)

### spatially useful

- `read_gpx`: read GPX extension formats
- `st_coordinates_tidy`: a tidy alternative to `sf::st_coordinates`. it retrieve coordinates within the original sf/data.frame object.
- `sf_as_ppp`: integrates point geometry dataset and a boundary to create a ppp for spatstat analysis. [clink here for more information](https://github.com/r-spatial/sf/issues/1233).
-  `tibble_as_raster`: transform a x,y,z tibble to a raster. 

### movement(ally) usefull

- `sum_range_h`: custom function to calculate amount of hours between to reported times
- `get_distance_m`: generates a distance output between two set of points within a tibble and flexible with `dplyr::group_by` and `purrr::pmap` 

### incidence(cially) usefull

- `get_info_tidy`: generates a tibble of `incidence::get_info()`. [clink here for more information](https://www.repidemicsconsortium.org/incidence/index.html).
- `tidy_incidence`: generates a complete summary tibble from incidence fit paramteter estimates
- `glance_incidence`: generates a complete summary tibble from incidence fit model performance
