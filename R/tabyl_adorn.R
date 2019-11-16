#' adorn up a tabyl output
#'
#' Creates the usual 2 by 2 output to a tabyl format.
#'
#' @param tabyl tabyl input
#'
#' @return tabyl object with horizontal % and in front N.
#'
#' @import janitor
#'
#'@export

adorn_2x2 <- function(tabyl) {
  tabyl %>%
    adorn_totals(where = "col") %>%
    adorn_percentages() %>%
    adorn_pct_formatting() %>%
    adorn_ns(position = "front")
}
