# Why you don't want to do mean imputation
set.seed(2112)
x <- rnorm(1000, mean=0, sd=1)
mean(x)
sd(x)
hist(x)

x2 <- x
x2[sample(length(x2), 250)] <- NA
table(is.na(x2))

x2[is.na(x2)] <- mean(x2, na.rm=TRUE)
mean(x); mean(x2)
sd(x); sd(x2)
