
knitr::write_bib(c(.packages(), 
                   'bookdown', 
                   'knitr', 
                   'rmarkdown'), 
                 'packages.bib')

options(htmltools.dir.version = FALSE, 
        booktabs = TRUE,
        formatR.indent = 2, 
        width = 55, 
        digits = 3,
        dplyr.print_min = 6,
        dplyr.print_max = 6,
        warnPartialMatchAttr = FALSE, 
        warnPartialMatchDollar = FALSE)

knitr::opts_chunk$set(
  message = FALSE,
  comment = "#>",
  collapse = TRUE,
  out.width = "70%",
  fig.align = 'center',
  fig.width = 6,
  fig.asp = 0.7,  # 1 / phi
  fig.show = "hold"
)

old <- ggplot2::theme_set(ggthemes::theme_tufte())
