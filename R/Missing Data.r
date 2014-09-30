require(mice)
require(VIM)
require(pisa)
require(survey)
require(naep)

options(digits=2)

data(sleep, package='VIM')
str(sleep)
?sleep

#Look at rows with complete cases
complete.cases(sleep)
sleep[complete.cases(sleep),]

#Or the rows with some missingness
sleep[!complete.cases(sleep),]

sum(is.na(sleep$Dream)) #Number of missing values
mean(is.na(sleep$Dream)) #Percent missing
mean(!complete.cases(sleep)) #Percent of rows with missing data

apply(sleep, 1, function(x) { sum(is.na(x)) } )
apply(sleep, 1, function(x) { sum(is.na(x)) } ) / ncol(sleep)


#Patterns of missingness
md.pattern(sleep)

#Visualize missingness
aggr(sleep, prop=FALSE, numbers=TRUE)
aggr(sleep, prop=TRUE, numbers=TRUE)


matrixplot(sleep)

marginplot(sleep[,c('Gest','Dream')], pch=c(20), col=c('darkgray','red','blue'))

#Shadow matrix
sm <- as.data.frame(abs(is.na(sleep)))
head(sleep)
head(sm)

#Examine the correlation of missingness between variables
y <- sm[which(sapply(sm, sd) > 0)] #Extract varabibles that have some missingness
cor(y)

cor.out <- cor(sleep, y, use='pairwise.complete.obs')
cor.out

cor.out.abs <- abs(cor(sleep, y, use='pairwise.complete.obs'))
cor.out[cor.out.abs < .2] <- ''
cor.out
View(cor.out)

#Complete-case analysis (listwise deletion)
nrow(sleep)
nrow(na.omit(sleep))
cor(na.omit(sleep))

fit <- lm(Dream ~ Span + Gest, data=na.omit(sleep))
summary(fit)

#Impute missing values with mice
imp <- mice(sleep, printFlag=TRUE, seed=1234)
imp
ls(imp)
imp$method

dataset5 <- complete(imp, 5)
head(dataset5)

dataset4 <- complete(imp, 4)
head(dataset4)

fit <- with(imp, lm(Dream ~ Span + Gest))
pooled <- pool(fit) 
summary(pooled)

################################################################################
require(devtools); install_github('naep','jbryer')
require(naep)

baseDir = getBaseDirectory()
baseDir = "/Users/jbryer/Dropbox/Projects/NAEP/PRIMER_FINAL"
vars <- c("SCRPSU", "DSEX", "IEP", "LEP", "ELL3", "SDRACEM", "PARED", "RPTSAMP", 
		  "REPGRP1", "REPGRP2", "JKUNIT", "ORIGWT", "SRWT01", "SRWT02", "SRWT03", "SRWT04", 
		  "SRWT05", "SRWT06", "SRWT07", "SRWT08", "SRWT09", "SRWT10", "SRWT11", "SRWT12", 
		  "SRWT13", "SRWT14", "SRWT15", "SRWT16", "SRWT17", "SRWT18", "SRWT19", "SRWT20", 
		  "SRWT21", "SRWT22", "SRWT23", "SRWT24", "SRWT25", "SRWT26", "SRWT27", "SRWT28", 
		  "SRWT29", "SRWT30", "SRWT31", "SRWT32", "SRWT33", "SRWT34", "SRWT35", "SRWT36", 
		  "SRWT37", "SRWT38", "SRWT39", "SRWT40", "SRWT41", "SRWT42", "SRWT43", "SRWT44", 
		  "SRWT45", "SRWT46", "SRWT47", "SRWT48", "SRWT49", "SRWT50", "SRWT51", "SRWT52", 
		  "SRWT53", "SRWT54", "SRWT55", "SRWT56", "SRWT57", "SRWT58", "SRWT59", "SRWT60", 
		  "SRWT61", "SRWT62", "SMSRSWT", "MRPCM1", "MRPCM2", "MRPCM3", "MRPCM4", "MRPCM5")

g8math = getNAEPData(year = 2005, grade = 8, subject = "Math", sample = "PM", 
					 directory = baseDir, vars = vars)

repweights <- c(paste("SRWT0", 1:9, sep=''), paste("SRWT", 10:62, sep=''))

svydesign <- svrepdesign(data=g8math$data, 
						 weights=g8math$data[,'ORIGWT'],
						 repweights=g8math$data[,repweights],
						 rscales=1, scale=1,
						 combined.weights=TRUE,
						 type='JKn')

#Survey functions
ls("package:survey")[grep("^svy*", ls("package:survey"))]

table(g8math$data$IEP)
svytable(~ IEP, svydesign)

m4 <- naep.model(MRPCM ~ DSEX + IEP + ELL3 + SDRACEM + PARED, var = "MRPCM", 
				 naepData = g8math, svyFUN = svyglm)
fix(naep.model)

MIcombine

m4$svyFUN

m4$combined






