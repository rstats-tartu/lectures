
#' Calculate mode for smoothed data using density
#' @param x r object
#' @param adjust parameter for density function.
#' @examples 
#' library(dplyr)
#' N <- 3
#' N_simulations <- 10000
#' df <- tibble(a = rnorm(N * N_simulations, 100, 20), b = rep(1:N_simulations, each = N) )
#' Summary <- group_by(df, b) %>% summarise(Mean = mean(a), SD = sd(a)) 
#' mode(Summary$SD)
#' 

mode <-  function(x, adjust = 1) {
  x <- na.omit(x)
  dx <- density(x, adjust = adjust)
  y_max <- dx$x[which.max(dx$y)] 
  y_max
}

