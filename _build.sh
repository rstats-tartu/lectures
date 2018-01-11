#!/bin/sh

# ~/.local/share/fonts should be used instead
FONT_HOME=~/.local/share/fonts

echo "installing fonts at $PWD to $FONT_HOME"
mkdir -p "$FONT_HOME/adobe-fonts/source-code-pro"
mkdir -p "$FONT_HOME/huertatipografica/alegreya"
# find "$FONT_HOME" -iname '*.ttf' -exec echo '{}' \;

(git clone \
   --branch release \
   --depth 1 \
   'https://github.com/adobe-fonts/source-code-pro.git' \
   "$FONT_HOME/adobe-fonts/source-code-pro" && \
fc-cache -f -v "$FONT_HOME/adobe-fonts/source-code-pro")

(git clone \
   --branch master \
   --depth 1 \
   'https://github.com/huertatipografica/Alegreya.git' \
   "$FONT_HOME/huertatipografica/alegreya" && \
fc-cache -f -v "$FONT_HOME/huertatipografica/alegreya/fonts")

echo "rendering site"
# Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
# Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
Rscript -e "rmarkdown::render_site(encoding = 'UTF-8')"

