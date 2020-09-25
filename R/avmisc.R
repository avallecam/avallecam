#' The Most Important Custom Functions
#'
#' @description benchwork optimizer
#'
#' @describeIn print_inf make a quick(er) `print(n=Inf)`
#'
#' @param object objeto input
#'
#' @return Really (context dependent) important outputs.
#'
#' @import tidyverse
#'
#' @examples
#'
#' \dontrun{
#'
#' # print_inf ---------------------------------------------------
#'
#' library(tidyverse)
#' mtcars %>% as_tibble() %>% print_inf()
#'
#' # read_lastfile------------------------------------------------
#'
#' # # read last name in a long list of files
#' # lastfile_name <- read_lastfile(path = "../../long_rute_to_folder/", pattern = "*.xlsx") %>% print()
#' #
#' # # read that filename
#' # read_excel(lastfile_name)
#'
#' }
#'
#' @export print_inf
#' @export read_lastfile

print_inf <- function(object) {
  object %>%
    print(n=Inf)
}

#' @describeIn print_inf read the last file in a folder (ideal for workflows with daily inputs and updates)
#' @param path path to folder
#' @param pattern any specific file extension

read_lastfile <- function(path,pattern) {
  list.files(path = path,
             pattern = pattern,
             full.names = T) %>%
    enframe(name = NULL) %>%
    bind_cols(pmap_df(., file.info)) %>%
    #last modified (the oldest)
    filter(mtime==max(mtime)) %>%
    #last created
    #filter(ctime==max(ctime)) %>%
    pull(value)
}
