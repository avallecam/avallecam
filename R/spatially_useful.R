#' tibble friendly sf, ppp, and raster operations
#'
#' @description functions ot extract coordinates from a point geometry, convert a sf to ppp and create a raster
#'
#' @describeIn st_coordinates_tidy retrieve coordinates within the original sf/data.frame object. an alternative from [st_coordinates()](https://r-spatial.github.io/sf/reference/st_coordinates.html)
#'
#' @param sf_object sf_object input
#'
#' @return sf and data.frame object X and Y extracted from geometry column
#'
#' @import dplyr
#' @import tidyr
#'
#' @examples
#'
#' \dontrun{
#'
#' # st_coordinates_tidy --------------------------------------
#'
#' library(tidyverse)
#' library(sf)
#' library(avallecam)
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
#' # current solution
#' sites_sf %>%
#'   st_coordinates()
#'
#' # our proposal
#' sites_sf %>%
#'   st_coordinates_tidy()
#'
#' # sf_to_ppp ------------------------------------------
#'
#' # data packages
#' library(tidyverse)
#' library(avallecam)
#' library(maptools)
#' library(sf)
#'
#' # import sample data
#' library(spatstat)
#' data("flu")
#' flu_one <- flu$pattern$`wt M2-M1 13`
#' flu_one %>% plot()
#'
#' # reverse engineering
#'
#' # extract window from ppp
#' flu_one_window <- st_as_sf(flu_one) %>%
#'   filter(label=="window") %>%
#'   pull(geom)
#' # extract points from ppp
#' flu_one_points <- flu_one %>%
#'   as_tibble() %>%
#'   #tibble to sf
#'   st_as_sf(coords = c("y", "x"),
#'            remove = T,
#'            crs = 4326,
#'            agr = "constant")
#'
#' # re-create a ppp from points and bbox
#' sf_as_ppp(sf_geometry_input = flu_one_points,
#'           sf_polygon_boundary = flu_one_window) %>%
#'   plot()
#'
#' # tibble_as_raster -------------------------------------
#'
#' set.seed(33)
#'
#' expand_grid(x=1:10,
#'        y=1:10) %>%
#'   mutate(z=rnorm(100)) %>%
#'
#'   # convert tibble to raster
#'   tibble_as_raster() %>%
#'
#'   # plot to verify
#'   plot()
#'
#'   }
#'
#' @export st_coordinates_tidy
#' @export sf_as_ppp
#' @export tibble_as_raster

st_coordinates_tidy <- function(sf_object) {

  sf_object %>%
    rownames_to_column() %>%
    left_join(
      sf_object %>%
        sf::st_coordinates() %>%
        as_tibble() %>%
        rownames_to_column()
    ) %>%
    select(-rowname)
}

#' @describeIn st_coordinates_tidy integrates point geometry dataset and a boundary to create a ppp for spatstat analysis. [more](https://github.com/r-spatial/sf/issues/1233)
#' @inheritParams st_coordinates_tidy
#' @param sf_geometry_input input sf of points
#' @param sf_polygon_boundary input sf of box or boundary

sf_as_ppp <- function(sf_geometry_input,sf_polygon_boundary) {
  # input
  house <- sf_geometry_input
  window_boundary <- sf_polygon_boundary
  # transform sf to ppp
  house_g <- house #%>% select(geometry)
  house_poly <- window_boundary %>% sf::st_buffer(dist = 0) %>% sf::st_union() #needs to be cleaner!
  p.sp  <- as(house_g, "Spatial")  # Create Spatial* object
  p.ppp <- as(p.sp, "ppp")      # Create ppp object
  # add window
  Window(p.ppp) <- spatstat::as.owin(as(house_poly, "Spatial"))
  # # determine the binwidth
  # h_ppp <- bw.scott(p.ppp) #bw.ppl(p.ppp)
  # h_ppp
  return(p.ppp)
}

#' @describeIn st_coordinates_tidy transform a x,y,z tibble to a raster
#' @inheritParams st_coordinates_tidy
#' @param data tibble with three column names: x, y, z (for longitud, latitud, and grid value)

tibble_as_raster <- function(data) {

  gam_humber_viz_raster_id <-
    data %>%
    as_tibble() %>%
    arrange(x,y) %>%
    #filter(z>1) %>%
    group_by(y) %>%
    mutate(y_id=group_indices()) %>%
    ungroup() %>%
    group_by(x) %>%
    mutate(x_id=group_indices()) %>%
    ungroup()

  gam_humber_viz_raster_matrix <-
    gam_humber_viz_raster_id %>%
    select(z,ends_with("_id")) %>%
    pivot_wider(names_from = x_id,values_from = z) %>%
    #naniar::vis_miss()
    select(-y_id) %>%
    as.matrix() %>%
    t()

  gam_humber_viz_raster_id_x <- gam_humber_viz_raster_id %>%
    select(x,x_id) %>%
    distinct()

  gam_humber_viz_raster_id_y <- gam_humber_viz_raster_id %>%
    select(y,y_id) %>%
    distinct()

  gam_humber_viz_raster_list <-
    list(x = gam_humber_viz_raster_id_x$x,
         y = gam_humber_viz_raster_id_y$y,
         z = gam_humber_viz_raster_matrix)

  #image(gam_humber_viz_raster_list)

  raster <- raster::raster(gam_humber_viz_raster_list)

  raster::projection(raster) <- CRS("+proj=longlat +datum=WGS84")

  return(raster)
}
