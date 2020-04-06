#' distance tibble
#'
#' @description generates a distance (in meters) output between two set of points within a tibble and flexible with group_by and purrr::pmap
#'
#' @describeIn get_distance_m generates a distance (in meters) output between two set of points within a tibble and flexible with group_by and purrr::pmap
#'
#' @param set1_lat set1 of latitude coordinates
#' @param set1_lon set1 of longitude coordinates
#' @param set2_lat set2 of latitude coordinates
#' @param set2_lon set2 of longitude coordinates
#'
#' @return distance as double vector
#'
#' @author Andree Valle-Campos at Emerge, Emergent Diseases and Climate Change Unit - UPCH.
#'
#' @references for more details check [geosphere](https://cran.r-project.org/web/packages/geosphere/index.html) package
#'
#' @import dplyr
#' @import geosphere
#'
#' @examples
#'
#' library(tidyverse)
#' library(geosphere)
#' library(purrr)
#' library(avallecam)
#'
#' # function alone
#'
#' get_distance_m(set1_lat = 57.2, set1_lon = -2.08,
#'                set2_lat = 52.4, set2_lon = -4.08)
#'
#' # in a tibble this works as a rowwise operation
#'
#' tibble(
#'   set1_lat = c(57.2, 47.2), set1_lon = c(-2.08,-12.08),
#'   set2_lat = c(52.4, 62.4), set2_lon = c(-4.08,-14.08)
#' ) %>%
#'   mutate(dist_test=pmap_dbl(.l = select(.,set1_lat,set1_lon,set2_lat,set2_lon),
#'                             .f = get_distance_m))
#'
#' # with lag or lead rows and group by operations
#'
#' d <- tibble(run = c(rep(1,6), rep(2,6)),
#'             grp = c(rep("a",3),rep("b",3),rep("a",3),rep("b",3)),
#'             lat = rep(c(57.15508, 52.41283, 57.15521,
#'                         52.41278, 57.14520, 52.41317),2),
#'             lon = rep(c(-2.07887, -4.07806, -2.07886,
#'                         -4.07803, -2.07886, -4.07858),2))
#'
#' d %>%
#'   group_by(run,grp) %>%
#'   mutate(dist=pmap_dbl(list(lat,lon,lag(lat),lag(lon)),get_distance_m))
#'
#'
#' @export get_distance_m

get_distance_m <- function(set1_lat, set1_lon, set2_lat, set2_lon) {
  distm(x = c(set1_lon, set1_lat), y = c(set2_lon, set2_lat), fun = distGeo) %>%
    as.numeric()
}
