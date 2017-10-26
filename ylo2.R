library(tidyverse) 
library(ggthemes)
library(ggjoy)
library(ggrepel)

?mpg
m1 <- mpg

best_in_class <- m1 %>% group_by(class) %>% 
  top_n(1, hwy)
ggplot(m1, aes(displ, hwy)) + 
  geom_point(aes(color=class))+
  geom_point(data= best_in_class, size=3, shape=1)+
  geom_label_repel(data= best_in_class, 
                   aes(label=model), cex=2)
## vers1
download.file("https://raw.githubusercontent.com/rstats-tartu/datasets/master/diabetes.csv",
              "diabetes.csv")
diabetes <- read_csv2("diabetes.csv")
diabetes

## vers2
diabetes <- read_csv2("https://raw.githubusercontent.com/rstats-tartu/datasets/master/diabetes.csv")
diabetes

ggplot(diabetes, aes(hdl, y=..density..)) + 
  geom_histogram(binwidth = 5, color="white", fill="blue")

ggplot(diabetes, aes(hdl, fill=gender)) + 
  geom_histogram(binwidth = 5, color="white")

ggplot(diabetes, aes(hdl)) + 
  geom_histogram(binwidth = 5, color="white")+
  facet_wrap(~gender, nrow=2)

ggplot(diabetes, aes(hdl)) + 
  geom_histogram(binwidth = 5, color="white")+
  facet_wrap(c("gender", "location"))

ggplot(diabetes, aes(hdl)) + 
  geom_histogram(binwidth = 5, color="white")+
  facet_grid(gender~location)

sch <- read_csv("data/schools.csv")
sch <- arrange(sch, school)
sch <- drop_na(sch)

sch$school <- as.factor(sch$school)

ggplot(sch, aes(x=score1, y=school)) + 
  geom_joy() +
  theme_tufte()

ggplot(sch, aes(x=score1, y=reorder(school, score1))) + 
  geom_joy() +
  theme_tufte()

ggplot(sch[1:100,], aes(x=school, y=score1)) + 
  geom_violin() +
  theme_tufte()+
  coord_flip()


