#' tidy up -even more- an output model from broom
#'
#' Prepares the output to a printable table format. Exclusive for models that estimate prevalence ratios (PR)
#'
#' @param wm1 model output from glm
#'
#' @return dataset with exponentiated estimate and confidence intervals.
#'
#'@export

epi_tidymodel_pr <- function(wm1) {
  m1 <- wm1 %>% tidy() %>% mutate(pr=exp(estimate)) %>% rownames_to_column()
  m2 <- wm1 %>% confint_tidy() %>% mutate_all(list(exp)) %>% rownames_to_column()

  left_join(m1,m2) %>%
    dplyr::select(term,log.pr=estimate,se=std.error,pr,
                  conf.low,conf.high,p.value) %>%
    mutate_at(.vars = vars(-term,-p.value),round, digits = 5) %>%
    mutate_at(.vars = vars(p.value),round, digits = 5) %>%
    #print() %>%
    return()
}
