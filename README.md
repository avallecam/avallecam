# avallecam

Personal library for custom R functions.

## Installation

Type this in your R console: 

> devtools::install_github("avallecam/avallecam")


## Main functionalities

### epidemiologically usefull

- `epi_tidymodel_*`: summmarize core estimates for OR, RR, PR, regression models (including gaussian-identity)
- `epi_tidymodel_up`: update raw models to generate various simple models or adjsuted by one parsimous model

### to make my life -just a little bit more- easy

- `adorn_2x2`: adorn a tabyl output for a 2 by 2 tabyl
- `print_inf`: make a quick print(n=Inf)

### custom

- `read_gpx`: read GPX extension formats
- `sum_range_h`: custom function to calculate amount of hours between to reported times
