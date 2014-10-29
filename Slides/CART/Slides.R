### R code from vignette source 'Slides.Rnw'

###################################################
### code chunk number 1: Slides.Rnw:56-86
###################################################
options(width=50)
#options(digits=3)
options(continue="   ")
options(warn=-1)

require(tree)
require(rpart)
require(party)
require(randomForest)
require(ggplot2)
require(mice)
require(ROCR)
require(TriMatch)

data(tutoring, package='TriMatch')
students <- tutoring

students$Treat <- TRUE
students[students$treat %in% c('Control'),]$Treat <- FALSE

# California house prices
calif <- read.table('../../Data/cadata.dat', header=TRUE)

load('../../Data/titanic3.sav') 
titanic3$survived <- as.integer(titanic3$survived)
titanic3$pclass <- as.integer(titanic3$pclass)

par(mfrow = c(1,1), xpd = NA) #To prevent text from being clipped
par(bg="white", mai=c(1.2,1.5,1,1))



###################################################
### code chunk number 2: Slides.Rnw:182-183
###################################################
names(calif)


###################################################
### code chunk number 3: rtree1
###################################################
treefit <- tree(log(MedianHouseValue) ~ Longitude + Latitude, 
data=calif)
plot(treefit); text(treefit, cex=0.75)


###################################################
### code chunk number 4: rtree2
###################################################
price.deciles <- quantile(calif$MedianHouseValue, 0:9/9)
cut.prices <- cut(calif$MedianHouseValue, price.deciles, include.lowest=TRUE)
plot(calif$Longitude, calif$Latitude, col=grey(10:2/11)[cut.prices], pch=20, 
	 xlab="Longitude", ylab="Latitude")
partition.tree(treefit, ordvars=c("Longitude","Latitude"), add=TRUE)


###################################################
### code chunk number 5: Slides.Rnw:215-216
###################################################
summary(treefit)


###################################################
### code chunk number 6: Slides.Rnw:225-228
###################################################
treefit2 <- tree(log(MedianHouseValue) ~ Longitude + Latitude, 
				 data=calif, mindev=.001)
summary(treefit2)


###################################################
### code chunk number 7: rtree3
###################################################
plot(treefit2); text(treefit2, cex=0.75)


###################################################
### code chunk number 8: rtree3map
###################################################
plot(calif$Longitude, calif$Latitude, col=grey(10:2/11)[cut.prices], 
pch=20, xlab="Longitude", ylab="Latitude")
partition.tree(treefit2, ordvars=c("Longitude","Latitude"), add=TRUE)


###################################################
### code chunk number 9: Slides.Rnw:260-263
###################################################
treefit3 <- tree(log(MedianHouseValue) ~ ., data=calif)
summary(treefit3)



###################################################
### code chunk number 10: Slides.Rnw:280-281
###################################################
names(titanic3)


###################################################
### code chunk number 11: rpart
###################################################
(titanic.rpart <- rpart(survived ~ pclass + sex + age + sibsp, 
data=titanic3))


###################################################
### code chunk number 12: rpartfig
###################################################
plot(titanic.rpart); text(titanic.rpart, use.n=TRUE, cex=1)


###################################################
### code chunk number 13: tree
###################################################
(titanic.tree <- tree(survived ~ pclass + sex + age + sibsp, 
data=titanic3))


###################################################
### code chunk number 14: treefig
###################################################
plot(titanic.tree); text(titanic.tree, cex=1)


###################################################
### code chunk number 15: ctree
###################################################
(titanic.ctree <- ctree(factor(survived) ~ pclass + sex + age + sibsp, 
data=titanic3))


###################################################
### code chunk number 16: ctreefig
###################################################
plot(titanic.ctree)


###################################################
### code chunk number 17: rocr1
###################################################
titanic.pred <- predict(titanic.ctree)
pred <- prediction(titanic.pred, as.integer(titanic3$survived))
perf <- performance(pred, measure="tpr", x.measure="fpr") 
plot(perf, colorize=TRUE, yaxis.at=c(0,0.5,0.8,0.9,1), 
yaxis.las=1)
lines(c(0,1), c(0,1), col="grey")


###################################################
### code chunk number 18: hsplot1
###################################################
names(students)
rp = rpart(Treat ~ Age + Ethnicity + Military + Gender + 
Employment + Transfer + ESL + 
EdMother + EdFather + Income, data=students)
plot(rp); text(rp, cex=1, use.n=TRUE)


###################################################
### code chunk number 19: Slides.Rnw:407-409
###################################################
strata = factor(rp$where)
table(strata, students$Treat)


###################################################
### code chunk number 20: Slides.Rnw:417-418
###################################################
printcp(rp)


###################################################
### code chunk number 21: Slides.Rnw:422-423
###################################################
(cp4min <- rp$cptable[which.min(rp$cptable[,"xerror"]),"CP"])


###################################################
### code chunk number 22: hsplot2
###################################################
rp2 = prune(rp, cp=cp4min - .001)
plot(rp2); text(rp2, use.n=TRUE, all=FALSE)


###################################################
### code chunk number 23: Slides.Rnw:448-450
###################################################
strata = factor(rp$where)
table(strata, students$Treat)


###################################################
### code chunk number 24: Slides.Rnw:454-456
###################################################
strata2 = factor(rp2$where)
table(strata2, students$Treat)


###################################################
### code chunk number 25: Slides.Rnw:468-471
###################################################
titanic.mice <- mice(titanic3[,c("pclass","sex","age","sibsp")])
titanic.complete <- cbind(survived=titanic3$survived, 
complete(titanic.mice, 5))


###################################################
### code chunk number 26: Slides.Rnw:474-477
###################################################
titanic.glm <- glm(survived ~ pclass + sex + age + sibsp,
				   data=titanic.complete,
				   family=binomial(logit))


###################################################
### code chunk number 27: Slides.Rnw:483-484
###################################################
oldopt <- options(width=100)


###################################################
### code chunk number 28: Slides.Rnw:486-487
###################################################
summary(titanic.glm)


###################################################
### code chunk number 29: Slides.Rnw:494-497
###################################################
titanic.glm2 <- glm(survived ~ pclass + sex + pclass:sex + age + sibsp,
data=titanic.complete, family=binomial(logit))
summary(titanic.glm2)


###################################################
### code chunk number 30: Slides.Rnw:499-500
###################################################
options(oldopt)


###################################################
### code chunk number 31: Slides.Rnw:538-539
###################################################
oldopt <- options(width=100)


###################################################
### code chunk number 32: Slides.Rnw:541-548
###################################################
set.seed(2112)
titanic.rf <- randomForest(factor(survived) ~ pclass + sex + age + sibsp, 
						   data=titanic.complete,
						   ntree=5000,
						   importance=TRUE)
print(titanic.rf)
importance(titanic.rf)


###################################################
### code chunk number 33: Slides.Rnw:550-551
###################################################
options(oldopt)


