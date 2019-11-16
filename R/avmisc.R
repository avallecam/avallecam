#' funciones varias
#'
#' impresión de todo el contenido.
#'
#' @param object objeto input
#'
#' @return object with n=Inf.
#'
#'@export

print_inf <- function(object) {
  object %>%
    print(n=Inf)
}
