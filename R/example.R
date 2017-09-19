library(tidyverse)

a <- read_csv("Rc.csv")
?read_csv

colnames(a) <- c("subject", "years", "supervisor", 
                 "stat course", "data anal", "R prof",
                 "x", "x1", "x2", "x3", "x4", "x5", "x6")
a <- select(a, -x)

a

summary(a)

a <- mutate(a, ratio_x1_x2=x1/x2)

a$years <- parse_number(a$years)

hist(a$years)

boxplot(a$ratio_x1_x2~a$supervisor)

plot(a$x1, a$x2)
abline(lm(a$x2~a$x1))

b <- rnorm(10)
mad(b)
?mad
