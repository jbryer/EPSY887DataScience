require(likert)
data(pisaitems)
items24 <- pisaitems[,substr(names(pisaitems), 1,5) == 'ST24Q']
head(items24); ncol(items24)

str(items24)

# items24$ST24Q01 <- as.integer(items24$ST24Q01)
for(i in 1:ncol(items24)) {
	items24[,i] <- as.integer(items24[,i])
}
str(items24)

letters
for(l in letters) {
	print(paste0('Brought to you by the letter ', l))
}

paste('Hello', 'Tina')
paste0('Hello', 'Tina')
paste('Hello', 'Tina', sep='-')

head(items24)
items24$total <- apply(items24, 1, sum)
items24$totalMean <- items24$total / (ncol(items24) - 1)
summary(items24$total)
summary(items24$totalMean)

items24 <- pisaitems[,substr(names(pisaitems), 1,5) == 'ST24Q']
missing <- rep(0, ncol(items24))
missing
for(i in 1:ncol(items24)) {
	missing[i] <- sum(is.na(items24[,i]))
}
missing
missing / nrow(items24) * 100

missingCount <- function(x) {
	y <- sum(is.na(x))
	return(y)
}

missingCount(items24[,1])
missingCount(items24[,2])

missing <- apply(items24, 2, missingCount)
length(missing); ncol(items24)
missing

missingByRow <- apply(items24, 1, missingCount)
length(missingByRow); nrow(items24)
mean(missingByRow)
summary(missingByRow)
boxplot(missingByRow)

table(missingByRow > 5)
prop.table(table(missingByRow > 5))
