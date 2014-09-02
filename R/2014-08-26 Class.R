setwd("~/Dropbox/School/Teaching/EPSY887 2014 Fall Data Science Institute")
getwd()

# Need to only install once
?install.packages
install.packages('foreign')

library(foreign)

myname <- 'Jason'
class(myname)

mynumber <- c(2112, 3)
class(mynumber)
mynumber

length(mynumber)

ccd <- read.spss('Data/sc051a.sav', to.data.frame=TRUE)
dim(ccd)
names(ccd)

titanic <- read.csv("Data/titanic.csv")
names(titanic)
head(titanic, n=3)
tail(titanic)

names(titanic)[1] <- 'ticket'
names(titanic)

View(titanic[1001:1309,])

class(titanic)
dim(titanic)
titanic[1,]
titanic[,1]
class(titanic[,1])
class(titanic[,3])

str(titanic)

table(titanic$sex)
table(titanic$sex, useNA='always')

ccd <- NULL

myvar <- NA
myvar <- NULL

load('Data/WorldData.Rda')

?save

library(gdata)
?read.xls
