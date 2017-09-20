library(tidyverse)

a <- read_csv("https://raw.githubusercontent.com/rstats-tartu/datasets/master/quiz.csv")

colnames(a) <- c("subject", "years", "supervisor", 
                 "stat course", "data anal", "R prof",
                 "x", "x1", "x2", "x3", "x4", "x5", "x6")
a <- select(a, -x)

a <- mutate(a, diff_x1_x2=x1 - x2)

a$years <- parse_number(a$years)

