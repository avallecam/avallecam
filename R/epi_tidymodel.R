#' Tidy up -even more- an output model using broom functions
#'
#' Summarize OR, RR, PR regression outputs and update models for simple and other multiple models.
#'
#' @describeIn epi_tidymodel_or summarize and calculates OR coefficients from bin-logit regression
#'
#' @param model_output output raw GLM model
#' @param digits digits for numeric double objects (p.value)
#'
#' @import dplyr
#' @import broom
#'
#' @return table summary from traditional epi models.
#'
#' @examples
#'
#' # ejemplo
#' # falta
#'
#'@export epi_tidymodel_or
#'@export epi_tidymodel_rr
#'@export epi_tidymodel_pr
#'@export epi_tidymodel_up
#'

epi_tidymodel_or <- function(model_output,digits=5) {
  m1 <- model_output %>% tidy() %>% mutate(or=exp(estimate)) %>% rownames_to_column()
  m2 <- model_output %>% confint_tidy() %>% mutate_all(list(exp)) %>% rownames_to_column()

  left_join(m1,m2) %>%
    dplyr::select(term,log.or=estimate,se=std.error,or,
                  conf.low,conf.high,p.value) %>%
    mutate_at(.vars = vars(-term,-p.value),round, digits = digits) %>%
    mutate_at(.vars = vars(p.value),round, digits = digits) %>%
    #print() %>%
    return()
}

#' @describeIn epi_tidymodel_or summarize and calculates RR coefficients from bin-log regression
#' @inheritParams epi_tidymodel_or

epi_tidymodel_rr <- function(model_output,digits = 5) {
  m1 <- model_output %>% tidy() %>% mutate(rr=exp(estimate)) %>% rownames_to_column()
  m2 <- model_output %>% confint_tidy() %>% mutate_all(list(exp)) %>% rownames_to_column()

  left_join(m1,m2) %>%
    dplyr::select(term,log.rr=estimate,se=std.error,rr,
                  conf.low,conf.high,p.value) %>%
    mutate_at(.vars = vars(-term,-p.value),round, digits = digits) %>%
    mutate_at(.vars = vars(p.value),round, digits = digits) %>%
    #print() %>%
    return()
}

#' @describeIn epi_tidymodel_or summarize and calculates PR coefficients from bin/poisson-log regression
#' @inheritParams epi_tidymodel_or

epi_tidymodel_pr <- function(model_output,digits=5) {
  m1 <- model_output %>% tidy() %>% mutate(pr=exp(estimate)) %>% rownames_to_column()
  m2 <- model_output %>% confint_tidy() %>% mutate_all(list(exp)) %>% rownames_to_column()

  left_join(m1,m2) %>%
    dplyr::select(term,log.pr=estimate,se=std.error,pr,
                  conf.low,conf.high,p.value) %>%
    mutate_at(.vars = vars(-term,-p.value),round, digits = digits) %>%
    mutate_at(.vars = vars(p.value),round, digits = digits) %>%
    #print() %>%
    return()
}

#' @describeIn epi_tidymodel_or updates reference models (null or parsimonius) by adjusting with a new covariate. to use with purrr::map() and requires to use rlang::sym() to recognize the variable.
#' @inheritParams epi_tidymodel_or
#' @param reference_model reference model to update
#' @param variable new variable to update into the model

epi_tidymodel_up <- function(reference_model,variable) {
  update(reference_model, expr(~ . + !!variable))
}
