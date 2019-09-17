#' tidy up -even more- an output model from broom
#'
#' Prepares the output to a printable table format. Exclusive for models that estimate odds ratios (OR)
#'
#' @param wm1 model output from glm
#' @param digits number of decimal digits for pvalue
#'
#' @return dataset with exponentiated estimate and confidence intervals.
#'
#'@export

epi_tidymodel_or <- function(wm1,digits=5) {
  m1 <- wm1 %>% tidy() %>% mutate(or=exp(estimate)) %>% rownames_to_column()
  m2 <- wm1 %>% confint_tidy() %>% mutate_all(list(exp)) %>% rownames_to_column()

  left_join(m1,m2) %>%
    dplyr::select(term,log.or=estimate,se=std.error,or,
                  conf.low,conf.high,p.value) %>%
    mutate_at(.vars = vars(-term,-p.value),round, digits = digits) %>%
    mutate_at(.vars = vars(p.value),round, digits = digits) %>%
    #print() %>%
    return()
}
