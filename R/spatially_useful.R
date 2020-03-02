#' retrieve coordinates within the original sf/data.frame object
#'
#' @describeIn st_coordinates_tidy retrieve coordinates within the original sf/data.frame object. an alternative from st_coordinates() (https://r-spatial.github.io/sf/reference/st_coordinates.html)
#'
#' @param sf_object sf_object input
#'
#' @return sf and data.frame object X and Y extracted from geometry column
#'
#' @import dplyr
#' @import sf
#'
#' @examples
#'
#' library(tidyverse)
#' library(sf)
#'
#' sites <- tibble(gpx_point = c("a","b"),
#'                 longitude = c(-80.144005, -80.109),
#'                 latitude = c(26.479005,26.83)) %>% print()
#'
#' sites_sf <- sites %>%
#'   st_as_sf(coords = c("longitude", "latitude"),
#'            remove = T,
#'            crs = 4326) %>% print()
#'
#' sites_sf %>%
#'   st_coordinates_tidy()
#'
#' @export st_coordinates_tidy

st_coordinates_tidy <- function(sf_object) {

  sf_object %>%
    rownames_to_column() %>%
    left_join(
      sf_object %>%
        st_coordinates() %>%
        as_tibble() %>%
        rownames_to_column()
    ) %>%
    select(-rowname)
}

