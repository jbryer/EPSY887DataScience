setwd("~/Desktop/EPSY 887/week04")
install.packages('gdata')
install.packages('ggplot2')

library('gdata')
math<-read.xls('placement.xlsx')
head(math)

library("ggplot2")
ggplot(math,aes(x=exam1)) +	geom_histogram(binwidth=5) 
ggplot(math,aes(x=exam1)) +	geom_density()

ggplot(math, aes(x=arithmetic)) + geom_histogram(binwith=5)
ggplot(math, aes(x=elementary)) + geom_histogram(binwith=5)

ggplot(math, aes(x=elementary, y=exam1)) + geom_point()
ggplot(math, aes(x=elementary, y=exam1)) + geom_jitter() +
	coord_equal() + ylim(c(0,100)) + xlim(c(0,100)) +
	geom_smooth()

cor(math$elementary, math$exam1, use='complete.obs')
lm.out <- lm(exam1 ~ arithmetic + elementary + algerba, data=math)
lm.out <- lm(exam1 ~ elementary, data=math)
summary(lm.out)

names(lm.out)
lm.out$coefficients
lm.out$coefficients[1]
lm.out$coefficients[2]

mycor <- cor(math$elementary, math$exam1, use='complete.obs')
ci <- confint(lm.out)

ggplot(math, aes(x=elementary, y=exam1)) + geom_jitter() +
	coord_equal() + ylim(c(0,100)) + xlim(c(0,100)) +
	geom_abline(intercept=lm.out$coefficients[1],
				slope=lm.out$coefficients[2]) +
# 	geom_abline(intercept=ci[1,1], slope=ci[2,1], color='green') +
# 	geom_abline(intercept=ci[1,2], slope=ci[2,2], color='green') +
	geom_text(x=1, y=1, label=paste0("Correlation = ", 
					prettyNum(mycor, digits=2)), hjust=0)



ggplot(math,aes(x=exam1)) +	geom_histogram(binwidth=10)

ggplot(math,aes(x=exam1,y=arithmetic))+geom_histogram(stat='identity',color='blue',binwidth=20)

barplot(table(math$exam1,useNA='ifany'))
hist(math$exam1, breaks=12)  # the graph will show 12 bars
hist(math$exam1,breaks=length(unique(math$exam1)))  #good graph!

str(math)  #Shows me 83 observations and 9 variables, and column headers


table(is.na(math$exam1))  #FALSE= not missng value, TRUE= missing value
mean(math$exam1,na.rm=TRUE)  ## Need to remove missing values first!
sd(math$exam1,na.rm=TRUE)   ##ths is good practice for descriptive!!
median(math$exam1,na.rm=TRUE)
IQR(math$exam1,na.rm=TRUE)
summary(math$exam1,na.rm=TRUE)
plot(math$exam1)
boxplot(math$exam1)
plot(math$exam1,math$arithmetic)

unique(math$Code)

##  How to sort data by class sections
math$Code <- factor(math$Code,
                    levels = c("9am", "10am", '930am'),
                    labels = c("9am", 
                    		   "10am", "9:30am"))     ## ASK: HOW TO CHANGE SECTION TIMES TO 1,2,3
table(math$Code)
unique(math$Code)

library(psych)
# Give you everything
describeBy(math$exam1, math$Code, mat=TRUE)

describeBy(math$exam1, math$Code, mat=TRUE)[,c('group1','n','mean','sd','se')]

test <- math[math$Code %in% c('9:30am','9am'),]
table(test$Code)
test$Code <- as.character(test$Code)
t.test(exam1 ~ Code, data=test)

test <- math[math$Code == '9:30am' |
			 math$Code == '9am',]

# OR operators
TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

# AND operators
TRUE & TRUE
TRUE & FALSE
FALSE & FALSE

# NOT operator
!FALSE
!TRUE
!FALSE & TRUE

'me' == 'you'
'me' == 'me'
'me' != 'you'
'me' != 'me'

letters %in% c('a','e','i','o','u')
letters[letters %in% c('a','e','i','o','u')]

#Probably easier
math$Code <- as.factor(math$Code)

##  How to melt    
library(plyr)
library(reshape2)
str(math)
section<- math[,c('StudentID','exam1','arithmetic','elementary')]
section$StudentID <- 1:nrow(section)
head(section)
section.melt <- melt(section, id='StudentID')
head(section.melt)
nrow(section)
nrow(section.melt)

ggplot(section.melt, aes(x=StudentID, y=value, fill=variable)) + 
	geom_bar(stat='identity')



## How to get descriptives

#exam.outcomes <- section.melt[,c('Code',value')]  
means <- aggregate(math$exam1, list(math$Code), mean)
                    ##  Don't know what I'm doing

#   names(means) <- c('Code', 'exam.outcome', 'mean')
#   meansbyCode <- dcast(means, Code ~ exam.outcome, value.var='mean')
#   names(meansbycond) <- c('Condition', 'Happiness', 'Sadness')
