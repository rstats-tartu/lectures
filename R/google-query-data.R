
## devtools::install_github("tidyverse/googledrive")
library(googledrive)
library(readr)

## Shows YOUR google account files
recent_files <- drive_find(n_max = 50)

## Use your table id from previous list
id <- recent_files$id[1]

## id of tapa741 test dataset
id <- "1IOzPyBpbXVA7mVizQZ3JIi4KjuifnCjK6gGvYUgq5VE"

## Download data to file
drive_download(as_id(id), path = "data/testdataset.csv", overwrite = TRUE)

## Read downloaded csv
query <- read_csv("data/testdataset.csv")
query
