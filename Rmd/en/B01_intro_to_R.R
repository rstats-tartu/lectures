#In R, one works in an area called the “workspace.” 
#The workspace is a working environment where objects are created and manipulated. 
#Objects commonly kept in the workspace are (a) entire data sets (i.e. tibbles) 
#and (b) the output of statistical analyses. 
#It is also relatively common to keep programs (i.e., functions) that do 
#special project-related tasks within the workspace.
ls() #display the names of the objects in the workspace.
#Within the workspace, one removes objects using the rm function:  
#rm(x, y, ink, temp, foo)
#if you fail to save the workspace after adding or modifying objects you create 
#in the current session, they will NOT be there next time you start R and load the specific workspace.
#to save current objects, use the “Save Workspace” option from the File menu to 
#specify where to save the workspace. 

#To get more information on any specific named function, for example solve, the command is
# help(solve)
#Searches of help files can be conducted using the help.search function. 
#For instance, to find functions related to regression one would type:
# help.search("regression")

2+2 # use Cntr/Cmd + Enter to evaluate the code 
#or click the Run button
2-2 #2 minus 2
2*3 #2 times 3
2/3
2**3 #2 in the order of 3 

sqrt(2)
2**(1/2)
(sqrt(2))**2

sin(pi / 2)
2==3

log(4)
exp(log(4))

log2(4)
2**(log2(4))

log10(100)
10**(log10(100))

x<- pi
round(x, 2) # round to 2 decimals 

x <- c(1,2,3,4,5) #vector: c() - combine
y<- c(1,3,4,2,7)
cor(x, y) #correlation
sum(x)
sum(x, y)
mean(x)
median(x)
quantile(x)
rank(y)
var(x) #variance
sd(x) #standard deviation - goes with mean
mad(x) #median absulute deviation - goes with median
max(x)
min(x)
exp(x)

################R function 
sum() #returns the sum of all the values present in its arguments.
?sum()#default argument value - na.rm=FALSE, you can change it!
sd #shows the function code, but does not run it

#a collection of similar functions - package
#you can download many thousands of packages 
#from repositories (CRAN, bioconductor): install.packages("packagename")
#takes directly from CRAN repository
#tidyverse is a package that is itself a 
#collection of packages that work well together
#in order to use the functions in a package 
#you have to first load the package: library(packagename)
#each fun has a help page, most packages have tutorials and such.

#next code helps you to install all your packages to a new machine or R version.
#this is very useful

#in the old version/machine run:
installed <- as.data.frame(installed.packages())
write.csv(installed, "installed_previously.csv")

#and in the new one:
installedPreviously <- read.csv("installed_previously.csv")
baseR <- as.data.frame(installed.packages())
toInstall <- setdiff(installedPreviously$Package, baseR$Package)
install.packages(toInstall) 

###############################################names
#We can assign values to names, thus creating objects 
# <- does the assigning, shortcut: Alt + - (the minus sign)
#All statements where you create objects have the same form: object_name <- value
#When reading that code say ???object name gets value???.

#Object names must start with a letter, and 
#can only contain letters, numbers, _, and . 
#no spaces
#case-sensitive
#a long name: this_is_a_long_name_01
#use TAB to autocomplete

apples <- 2 #two apples
oranges <- 3 #three oranges
inventory <- apples + oranges
inventory #inspect the object

#or you can use the function sum()
inventory <- sum(apples, oranges)

apelsinid<-oranges #here we changed the name 
#(or, more accurately, created a new name for 
#the same object, thus cloning the object) 

#we can also change the object behind a name. 
#The last change stands.
apples <- apples + 4
inventory<- apples + oranges
inventory
########################################################fun
#as we get more apples and oranges, 
#we want a way to reduce typing.
#for this we write functions, 
#which hide the code from the user

inventory <- function(apples, oranges) {
  inventory <- apples + oranges
  inventory
}
#run this code and see how the new 
#fun appears in the Global Enviroment
#lets use our new function
inventory(3,4)
#or equivalently
inventory(apples = 3, oranges = 4)

#OK, write a function that calculates standard error 
#from standard deviation (sd)
#sd() is a native R fun for standard deviation - 
#look it up in help! it has 2 arguments.
#SEM=SD/sqrt(N)
#N - length(x)

SEM0<- function(x) {
  SD<- sd(x) 
  SEM<- SD/sqrt(length(x))
  SEM
}

#x is just a placeholder for any object we want to insert
#so lets input a vector of numbers to SEM()
numbers<- c(2, 3.4, 54, NA, 3) #c() means "combine", NA means "any number" or "not available"

SEM0(numbers)

SEM01<- function(x) {
  SD<- sd(x, na.rm = TRUE) 
  SEM<- SD/sqrt(length(x))
  SEM
}
SEM01(numbers)
length(numbers)
#while SD removes NA-s, the length() does not. This leads to errors!

SEM1<- function(x) {
  x<- na.omit(x) #you want NAs to be removed
  SD<- sd(x) 
  SEM<- SD/sqrt(length(x))
  SEM
}

SEM1(numbers) #this works better!

SEM1<- function(x) {
  SD<- sd(x, na.rm = TRUE)#na.rm is an argument of the sd() fun
  SEM<- SD/sqrt(length(na.omit(x) ) ) #we nest 2 functions (length() and na.omit()) inside our function
  SEM
}
SEM1(numbers)

SEM2<-function(x) {
  SD<- sd(na.omit(x))
  SEM<- SD/sqrt(length(na.omit(x) ) )
  SEM
}
SEM2(numbers)

#harjutus: sd ilma sd() kasutamata
SEM3 <- function(x) {
  x <- na.omit(x)
  N <- length(x)
  SD <- sqrt(sum( (x-mean(x) )**2) / ( N-1 ) )
  SEM <- SD/sqrt(N)
  SEM
  }

SD3 <- function(x) {
  x <- na.omit(x)
  N <- length(x)
  SD <- sqrt(sum( (x-mean(x) )**2) / ( N-1 ) )
  SD
}


a <- rnorm(10, 10, 3)
SD3(a)
sd(a)
SEM3(a)
SEM2(a)
SEM1(a)



#lets start with installing a package
#install.packages("tidyverse")
#and load it
library(tidyverse)
#now its time to read in a data table (csv)
#NB! it is good practice to put all your library() 
#calls at the beginning of your script (if you share scripts)
library(gapminder)
#lets look at it in the Packages panel
# gapminder is the "gapminder data"
gap1<- gapminder

write_csv(gap1, "data/gapminder1.csv")
#see ?write_csv

gap<-read_csv("data/gapminder1.csv")
gap

#install gotta read em all as R studio addin
install.packages("devtools")
devtools::install_github("Stan125/GREA")

#when reading in csv files saved from Excel use read_csv2() or read.csv2() and 
#for writing in Excel friendly format (columns separated by ;) use write.csv2()

#When reading in a file, always check for type of data in the columns, 
#on the NAs, on the unique values.

library(VIM) # võib olla ajaraisk!
diabetes <- read.table(file = "data/diabetes.csv", sep = ";", dec = ",", header = TRUE)
str(diabetes)
aggr(diabetes, prop=FALSE, numbers=T)

#how many non-NA-containing rows we actually have (#377)
  
  nrows <- nrow(diabetes)
  ncomplete <- sum(complete.cases(diabetes))
  ncomplete #136
  ncomplete/nrows #34%
  
  #How many NAs in each Var?
 sapply(diabetes, function(x) sum(is.na(x))) 
  
#set arbitrary rules and check how many cells, rows, or columns pass and fail each rule
 
 library(validate)
 diabetes %>% check_that(
   ratio > 0.5, 
   mean(hdl, na.rm=TRUE) > 0,
   chol > 180 | glyhb < 8 
 ) %>% summary()
 
#plot the NA-s side-by-side for the variables in the diabetes dataset
  VIM::matrixplot(diabetes) 
#plot the NAs of 2 Vars  
  VIM::marginplot(diabetes[c("glyhb","bp.2s")], 
                  pch=c(20), alpha=0.5, 
                  col=c("darkgray", "red", "blue"))

  
#########small tables can be created in R
#row-wise
df <- tribble(
  ~colA, ~colB,
  "a",   1,
  "b",   2,
  "c",   3
)
#or column-wise 
df1 <- tibble(colA = c("a", "b", "c"), 
                  colB = c(1, 2, 3) )
df == df1
all.equal(df, df1)
add_row(df, colA = 4, colB = 0, .before = 3) #adds row to a tibble
add_row(df1, colA = 4, colB = 0) 

#bind 2 tables by rows or by columns: two sets of functions
df1.1 <- tibble(colA = "d", 
                colB =  4)

df1.2 <- bind_rows(df1, df1.1)
df1.3 <- rbind(df1, df1.1)
all.equal(df1.2, df1.3) #TRUE

df1.4 <- bind_cols(df1, df1.1)#error
df1.5 <- cbind(df1, df1.1) #guesses your true intention --- dangerous


df2 <- tribble(
  ~ColC, ~ColD,
  "d",   4
)

df4 <- bind_cols(df, df2) #error
df4 <- cbind(df, df2) #works by guessing your true intention
df4.2 <- bind_rows(df, df2) #works by guessing your true intention
df4.3 <- rbind(df, df2) #error

df2.1 <- tribble(
  ~ColC, ~ColD,
  "d",   4,
  "e",  5,
  "f",   6)
df4.1 <- bind_cols(df, df2.1) #works


#########tibble and data frame are R-s table formats
class (df) #[1] "tbl_df"     "tbl"        "data.frame"
#tibble is the newer form

df <- as.data.frame(df) #converts to data frame
class(df)# [1] "data.frame"
#the older form - some older functions need it
df<- as_tibble(df) #back to tibble


a <- matrix(1:20, ncol=4)
df_cl <- as.data.frame(a)
df_ti <- as_tibble(df_cl)
df_dp <- as_data_frame(a)
all.equal(df_ti, df_dp)
is.tibble(df_dp)

#########################################################types of objects
#R operates on named data structures. The simplest such structure is the numeric
#vector, which is a single entity consisting of an ordered collection of numbers.

#types of r objects: vector, list, data frame, matrix
#vector: a directional collection of numbers, characters, etc: v <- c(1, 3, "s", NA)
#df: a list of equal length vectors
#matrix: a list of equal length numeric vectors
#list: a collection of r objects (including other lists --- lists within lists).


#types of data inside r objects: numeric, integer, logical, character, factor (ordered and unordered)
#coercing between data types:
#matrix()
#as.matrix()
#as.vector()
#as.factor()
#as.character()

#types of missing data: NA - unknown value; NaN - not a number (no value is possible)

#NA + 3 = NA
#######################################
##indexing --- extracting parts of tables, vectors, lists

#vector indexing in one dimension: counts positions inside the vector
my_vector <- 2:5
my_vector[c(1,3)]
my_vector[-1]
my_vector[c(-1, -3)]
my_vector[3:5]

my_vector + 2 #each element of the vector is used, one after other. 
#2 is a vector of length one, it is recycled for the length of the longer vector.
my_vector2 <- c(1, 2)
my_vector + my_vector2 #2+1=3; 3+2=5; 4+1=5, 5+2=7 --- recycling again!
#no warning

my_vector3 <- c(1,2,3)
my_vector + my_vector3 #3 5 7 6 
#warning: longer object length is not a multiple of shorter object length

#data frame indexing in two dimensions: rows and columns
df
df[1,]
df[,2] #tibble
df$colB #vector
df1 <- as.data.frame(df)
df1[,2] #vector
df1[2,2] #vector
df1[2, c(1,2)]
df[2,2]#tibble
df$colB[df$colA != "a"] #a filter of colB by colA value
df$colA[df$colB > 1]

#list indexing in "three" dimensions: [ ] and [[ ]].
my_list <- list(a=tibble(colA=c("A", "B"), colB=c(1,2)), b=c(1, NA, "s"))
#this list has two elements, a df called "a" and a character vector called "b".
str(my_list)

my_list[[1]] #class is df  --- we extracted a df from the list
my_list$a #class is df --- $ does the same thing as [[ ]]
my_list[1] #class is list (of one element --- 
#we took out all elements but the first, but the result is still list)

my_list$a[2,] #class is df

my_list[[1]][1,] #the first list object extracted, 
#and then the first row of that is extracted --- class: df

#For lists, one generally uses [[ to select any single element, 
#whereas [ returns a list of the selected elements. 
#The [[ form allows only a single element to be selected using integer or 
#character indices, whereas [ allows indexing by vectors. 
#Note though that for a list, the index can be a vector and each element 
#of the vector is applied in turn to the list, the selected component, the 
#selected component of that component, and so on. 
#The result is still a single element.


