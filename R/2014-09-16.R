library(foreign)

pisa1 <- read.spss('Data/pisausa2009.sav')
class(pisa1)
pisa2 <- read.spss('Data/pisausa2009.sav', to.data.frame=TRUE)
class(pisa2)
head(pisa2)
dim(pisa2)
pisa3 <- read.spss('Data/pisausa2009.sav', to.data.frame=TRUE, use.value.labels=FALSE)
class(pisa3)
head(pisa3)


