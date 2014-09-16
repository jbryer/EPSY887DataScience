library(reshape2)

data.class <- read.csv('../Data/data.class.csv')
head(data.class)
# label conditions
# data.class$cond <- ordered(data.class$cond,
#                      levels = c(1,2, 3),
#                      labels = c("interpersonal sad", 
#                                 "noninterpersonal sad", "neutral"))

data.class$cond <- factor(data.class$cond,
						   levels = c(1,2, 3),
						   labels = c("interpersonal sad", 
						   		   "noninterpersonal sad", "neutral"))

str(data.class)

tmp <- data.class[,c('cond','shap','ssad')]
head(tmp)
tmp.melt <- melt(tmp, 'cond')
head(tmp.melt)
nrow(tmp)
nrow(tmp.melt)

# get means for each condition
##mean for sad and happy by condition
library(plyr)
sadmeans <- aggregate(data.class$ssad,list(data.class$cond),mean)
names(sadmeans) <- c('cond',' mean')
# sadmeans <- rename(sadmeans, c(Group.1="cond"))
# sadmeans <- rename(sadmeans, c(x="mean"))
sadmeans

hapmeans <- aggregate(data.class$shap,list(data.class$cond),mean)
hapmeans <- rename(hapmeans, c(Group.1="cond"))
hapmeans <- rename(hapmeans, c(x="mean"))
hapmeans

outcomes <- data.class[,c('cond', 'shap', 'ssad')]
outcomes <- melt(outcomes, 'cond')
means <- aggregate(outcomes$value, list(outcomes$cond, outcomes$variable), mean)
names(means) <- c('cond', 'outcome', 'mean')
meansbycond <- dcast(means, cond ~ outcome, value.var='mean')
names(meansbycond) <- c('Condition', 'Happiness', 'Sadness')

##Create a data.frame
meanscondition <- data.frame(c(aggregate(data.class$ssad,list(data.class$cond),mean),aggregate(data.class$shap,list(data.class$cond),mean)))
meansbycondition <- meanscondition[,c(1,2,4)]
meansbycondition <- rename(meansbycondition, c('Group.1'='Condition', 'x'='Sadness', 'x.1'='Happiness'))
meansbycondition

library(ggplot2)
ggplot(meansbycondition, aes(x=Condition, y=Sadness)) + 
	geom_histogram(stat="identity", color="blue", fill="blue")

ggplot(meansbycondition, aes(x=Condition, y=Happiness)) + 
	geom_histogram(stat='identity', color="blue", fill="blue")

means.melt <- melt(meansbycondition, id='Condition')
ggplot(means.melt, aes(x=Condition, y=value, fill=variable)) +	
	geom_bar(stat='identity', position='dodge') +
	geom_text(aes(label=prettyNum(value, digits=2)), position=position_dodge(width=0.9), vjust=-0.2) +
	ylab('Mean Score') +	
	scale_fill_manual('', values=c('Happiness'='purple','Sadness'='orange'))

ggplot(means.melt, aes(x=variable, y=value, fill=Condition)) +	
	geom_bar(stat='identity', position='dodge') +
	geom_text(aes(label=prettyNum(value, digits=2)), position=position_dodge(width=0.9), vjust=-0.2) +
	ylab('Mean Score') +	
	scale_fill_hue('')

#Scatter plot
ggplot(data.class, aes(x=shap, y=ssad)) +
	geom_point(alpha=.2)

lm.out <- lm(ssad ~ shap, data=data.class)
summary(lm.out)
class(lm.out)
names(lm.out)
lm.out$coefficients
class(lm.out$coefficients)
length(lm.out$coefficients)
intercept <- lm.out$coefficients[1]
slope <- lm.out$coefficients[2]

ggplot(data.class, aes(x=shap, y=ssad)) +
	geom_jitter(alpha=.5) + geom_smooth() +
	geom_abline(intercept=intercept, slope=slope, color='purple') +
	xlab('Happiness') + ylab('Sadiness') +
	ggtitle("Tina's Study Results")


ggplot(data.class, aes(x=shap, y=ssad, color=cond)) +
	geom_jitter(alpha=.8) + geom_smooth(alpha=.1, method='loess') +
	geom_abline(intercept=intercept, slope=slope, color='purple') +
	xlab('Happiness') + ylab('Sadiness') +
	ggtitle("Tina's Study Results")

ggplot(data.class, aes(x=shap, y=ssad)) +
	geom_jitter(alpha=.8) + geom_smooth(alpha=.1) +
	geom_abline(intercept=intercept, slope=slope, color='purple') +
	xlab('Happiness') + ylab('Sadiness') +
	ggtitle("Tina's Study Results") +
	facet_wrap(~ cond, ncol=1)

# Gender and condition
df <- data.class[,c('cond','gender','ssad','shap')]
df$gender <- factor(df$gender, levels=c(1,2), labels=c('Male','Female'))
df.melt <- melt(df, id=c('cond','gender'))
head(df.melt)
df.means <- aggregate(df.melt$value, 
		list(df.melt$cond,df.melt$gender,df.melt$variable), mean)
df.sd <- aggregate(df.melt$value, 
					  list(df.melt$cond,df.melt$gender,df.melt$variable), sd)
names(df.means) <- c('Condition', 'Gender', 'Outcome', 'Mean')
names(df.sd) <- c('Condition', 'Gender', 'Outcome', 'SD')

df.means$SD <- df.sd$SD

ggplot(df.means, aes(x=Condition, y=Mean, fill=Gender)) + 
	geom_bar(stat='identity', position='dodge') +
	geom_errorbar(aes(ymin=(Mean - SD), ymax=(Mean + SD)), color='green', position='dodge') +
	facet_wrap(~ Outcome, ncol=1) +
	ylim(c(0,7))


library(psych)
head(data.class)
describe(data.class$shap)
desc.hap <- describeBy(data.class$shap, group=list(data.class$gender, data.class$cond), mat=TRUE)
desc.hap

desc.sad <- describeBy(data.class$ssad, group=list(data.class$gender, data.class$cond), mat=TRUE)
desc.sad

desc <- cbind(desc.hap[,c('group1','group2','mean','se')],
			  desc.sad[,c('mean','se')])
desc
names(desc) <- c('Gender', 'Condition', 'Happiness.Mean','Happiness.SE','Sadiness.Mean', 'Sadiness.SE')
desc

ggplot(desc, aes(x=group2, y=mean, fill=group1)) +
	geom_bar(stat='identity', position='dodge') +
	geom_errorbar(aes(ymin=(mean-1.96*se), ymax=(mean+1.96*se)), position='dodge', color='green')
