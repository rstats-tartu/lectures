#!/bin/sh

echo "installing bundled fonts"
fc-cache -fv fonts/

echo "rendering site"
# Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
# Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
Rscript -e "rmarkdown::render_site(encoding = 'UTF-8')"

