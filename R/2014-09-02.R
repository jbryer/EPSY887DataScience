# Read an Excel file
install.packages(c('gdata','xlsx'))

library(gdata)
?gdata
?read.xls

psm <- read.xls('../Data/WebOfScienceResults.xlsx', sheet=1)
psa <- read.xls('../Data/WebOfScienceResults.xlsx', sheet=2)
ps <- read.xls('../Data/WebOfScienceResults.xlsx', sheet=3)

head(psm)
head(psa)
head(ps)

names(psm)
names(psa)
names(ps)

psm$Keyword <- 'Propensity Score Matching'
psa$Keyword <- 'Propensity Score Analysis'
ps$Keyword <- 'Propensity Score'

citations <- rbind(psm, psa, ps)
