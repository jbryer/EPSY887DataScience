library(ggplot2)
library(multilevelPSA)
data(pisana)
head(pisana)

tmp <- pisana[,c('PV1MATH', 'PUBPRIV')]

ggplot(tmp, aes(x=PV1MATH, color=PUBPRIV, fill=PUBPRIV)) + 
	geom_density(alpha=.5)
