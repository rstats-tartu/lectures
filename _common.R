
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
  fig.align = 'center',
  fig.show = "hold"
)

library(skimr)
skim_with(numeric = list(hist = NULL), ts = list(line_graph = NULL))
