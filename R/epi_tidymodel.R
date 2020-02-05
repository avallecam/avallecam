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
#'@export epi_tidynested
#'@export epi_tidymodel_coef
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

#' @describeIn epi_tidymodel_or tidy output for each update level in the nested models procedure
#' @inheritParams epi_tidymodel_or
#' @param add_nested add1() output model
#' @param level level of nesting process

epi_tidynested <- function(add_nested,level=i) {
  add_nested %>%
    broom::tidy() %>%
    arrange(p.value) %>%
    print() %>%
    rownames_to_column("rank") %>%
    select(term,df,LRT,p.value,rank) %>%
    rename_at(.vars = c("rank","LRT","p.value"),.funs = str_replace, "(.+)",paste0("\\1\\_",level))
}


#' @describeIn epi_tidymodel_or summarize and calculates coefficients from linear regression (gaussian identity GLM)
#' @inheritParams epi_tidymodel_or

epi_tidymodel_coef <- function(model_output,digits = 5) {
  m1 <- model_output %>% tidy() %>% #mutate(coef=estimate) %>%
    rownames_to_column()
  m2 <- model_output %>% confint_tidy() %>% #mutate_all(list(exp)) %>%
    rownames_to_column()

  left_join(m1,m2) %>%
    dplyr::select(term,#log.coef=estimate,
                  estimate ,#coef,
                  se=std.error,
                  conf.low,conf.high,
                  p.value) %>%
    mutate_at(.vars = vars(-term,-p.value),round, digits = digits) %>%
    mutate_at(.vars = vars(p.value),round, digits = digits) %>%
    #print() %>%
    return()
}
