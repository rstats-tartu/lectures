## install.packages("NHANES")
## install.packages("ggformula")
library(NHANES)
library(ggplot2)
library(ggformula)

## Plot relationship between Age, Height and Gender 
ggplot(NHANES, aes(Age, Height)) + 
  geom_point(alpha = 0.1) +
  facet_wrap(~ Gender)

gf_point(NHANES, Height~Age | Gender, alpha = 0.1)

## Build model
hmod1 <-lm(Height ~ Gender * ns(Age, 5), data = NHANES)

