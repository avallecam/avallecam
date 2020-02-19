#' adorn up a tabyl output
#'
#' @describeIn adorn_2x2 [DEPRECATED] Creates the usual 2 by 2 output to a tabyl format.
#'
#' @param tabyl tabyl input
#'
#' @return tabyl object with horizontal % and in front N.
#'
#' @import janitor
#'
#' @examples
#'
#' library(tidyverse)
#' library(janitor)
#' library(avallecam)
#'
#' mtcars %>%
#'   tabyl(am,cyl) %>%
#'   adorn_ame()
#' mtcars %>%
#'   tabyl(am,cyl) %>%
#'   adorn_ame(where = "row")
#' mtcars %>%
#'   tabyl(am,cyl) %>%
#'   adorn_ame(where = "row",denominator = "col")
#' mtcars %>%
#'   tabyl(am,cyl) %>%
#'   adorn_ame(where = c("row","col"),denominator = "col")
#' mtcars %>%
#'   tabyl(am,cyl) %>%
#'   adorn_ame(where = c("row","col"),denominator = "row")
#'
#' @export adorn_2x2
#' @export adorn_ame
#' @export adorn_tpn

adorn_2x2 <- function(tabyl) {
  tabyl %>%
    adorn_totals(where = "col") %>%
    adorn_percentages() %>%
    adorn_pct_formatting() %>%
    adorn_ns(position = "front")
}

#' @describeIn adorn_2x2 Creates total, percetage and N to a tabyl format.
#' @inheritParams adorn_2x2
#' @param where (janitor::adorn_totals) one of "row", "col", or c("row", "col")
#' @param denominator (janitor::adorn_percentages) the direction to use for calculating percentages. One of "row", "col", or "all"
#' @param position (from janitor::adorn_ns) should the N go in the "front", or in the "rear", of the percentage?
#' @param na.rm should missing values (including NaN) be omitted from the calculations?

adorn_ame <- function(tabyl,
                      where="col",
                      denominator = "row",
                      position = "front",
                      na.rm=TRUE) {
  tabyl %>%
    adorn_totals(where = where,na.rm = na.rm) %>%
    adorn_percentages(denominator = denominator,na.rm = na.rm) %>%
    adorn_pct_formatting() %>%
    adorn_ns(position = position)
}

#' @describeIn adorn_2x2 Creates total, percetage and N to a tabyl format. (same as adorn_ame, but with a formal name)
#' @inheritParams adorn_ame

adorn_tpn <- function(tabyl,
                      where="col",
                      denominator = "row",
                      position = "front",
                      na.rm=TRUE) {
  tabyl %>%
    adorn_totals(where = where,na.rm = na.rm) %>%
    adorn_percentages(denominator = denominator,na.rm = na.rm) %>%
    adorn_pct_formatting() %>%
    adorn_ns(position = position)
}
