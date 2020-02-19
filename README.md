# avallecam

Personal library for custom R functions.

## Installation

Type this in your R console: 

```r
if(!require("devtools")) install.packages("devtools")
devtools::install_github("avallecam/avallecam")
```

## Main functionalities

### epidemiologically usefull

- `epi_tidymodel_*`: summmarize core estimates for OR, RR, PR regression models and linear regression coefficients.
- `epi_tidymodel_up`: update raw models to generate various simple models or adjusted by one parsimous model
- all of these are based on [`broom`](https://broom.tidyverse.org/index.html)

### to make my life -just a little bit more- easy

- `adorn_ame`: adorn a [`tabyl`](https://cran.r-project.org/web/packages/janitor/vignettes/janitor.html#tabyl---a-better-version-of-table) with totals on margins, percentages and N on values in only one function! 
- `print_inf`: make a quick(er) `print(n=Inf)`

### custom

- `read_gpx`: read GPX extension formats
- `sum_range_h`: custom function to calculate amount of hours between to reported times
 
