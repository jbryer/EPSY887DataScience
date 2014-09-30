devtools::install_github("seankross/lego")
library(lego)
data(legosets)

head(legosets)
legosets[1,]
legosets[,1]
names(legoset)
names(legosets)
row.names(legosets)
names(legosets)
legosets[,'Name']
head(legosets[,c('Name','Year')])
head(legosets$Name)
names(legosets)

table(legosets$Theme, useNA='ifany')

temp <- c(3,4,2)
barplot(temp)
names(temp) <- c('A', 'B', 'C')
temp
class(temp)
dim(temp)
length(temp)
barplot(temp)

barplot(table(legosets$Theme, useNA='ifany'))

hist(legosets$Year)
?hist
hist(legosets$Year, breaks=5)
hist(legosets$Year, breaks=20)
hist(legosets$Year, breaks=length(unique(legosets$Year)))

str(legosets)

mean(legosets$Pieces)
table(is.na(legosets$Pieces))
class(c(TRUE,FALSE, NA))
as.integer(c(TRUE, FALSE, NA))
sum(is.na(legosets$Pieces))
sum(is.na(legosets$Pieces)) / nrow(legosets) * 100
mean(legosets$Pieces, na.rm=TRUE)
sd(legosets$Pieces, na.rm=TRUE)
median(legosets$Pieces, na.rm=TRUE)
IQR(legosets$Pieces, na.rm=TRUE)
summary(legosets$Pieces)

boxplot(legosets$Pieces)

plot(legosets$Pieces)
plot(legosets$Pieces, legosets$USD_MSRP)

cor(legosets$Pieces, legosets$USD_MSRP, 
	use='pairwise.complete.obs')

cor(legosets[,c('Pieces', 'USD_MSRP', 'Minifigures')],
	use='pairwise.complete.obs')
cor(legosets[,c('Pieces', 'USD_MSRP', 'Minifigures')],
	use='complete.obs')

pairs(legosets[,c('Pieces', 'USD_MSRP', 'Minifigures')],
	use='pairwise.complete.obs')

panel.hist <- function(x, ...)
{
	usr <- par("usr"); on.exit(par(usr))
	par(usr = c(usr[1:2], 0, 1.5) )
	h <- hist(x, plot = FALSE)
	breaks <- h$breaks; nB <- length(breaks)
	y <- h$counts; y <- y/max(y)
	rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
	usr <- par("usr"); on.exit(par(usr))
	par(usr = c(0, 1, 0, 1))
	r <- abs(cor(x, y,use='pairwise.complete.obs'))
	txt <- format(c(r, 0.123456789), digits = digits)[1]
	txt <- paste0(prefix, txt)
	if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
	text(0.5, 0.5, txt, cex = cex.cor * r)
}
pairs(legosets[,c('Pieces', 'USD_MSRP', 'Minifigures')],
	  lower.panel=panel.smooth,
	  upper.panel=panel.cor,
	  diag.panel=panel.hist)

head(complete.cases(legosets))
table(complete.cases(legosets))

ncol(legosets)
miss <- apply(legosets, 1, function(x) {
	sum(is.na(x))
})
head(miss)
table(miss)
barplot(table(miss))
miss.percent <- miss / ncol(legosets)
table(miss.percent)

##### ggplot2 
ggplot(legosets, aes(x=Pieces)) + geom_histogram()
ggplot(legosets, aes(x=Year)) + geom_histogram()
ggplot(legosets, aes(x=Year)) + 
	geom_histogram(binwidth=1, color='black', 
				   fill='blue', alpha=.5)

ggplot(legosets, aes(x=Year, fill=Availability)) + 
	geom_histogram(binwidth=1)

ggplot(legosets, aes(x=Year)) + 
	geom_histogram(binwidth=1) +
	facet_wrap(~ Availability, ncol=2)

ggplot(legosets, aes(x=Year)) + 
	geom_histogram(binwidth=1) +
	facet_grid(~ Availability)

legosets$log_pieces <- log(legosets$Pieces)

ggplot(legosets, aes(x=Theme)) + geom_bar() + 
	theme(axis.text.x=element_text(angle=90, size=2))

table(legosets$Theme)
df <- as.data.frame(table(legosets$Theme))
df <- df[df$Freq > 20,]
ggplot(df, aes(x=Var1, y=Freq, label=Freq)) +
	geom_bar(stat='identity', alpha=.5) + 
	coord_flip() + geom_text(hjust=-0.3) + 
	xlab('') + ylab('Number of Sets') +
	ggtitle('Number of Sets by Theme\n(where n >= 20)')

ggplot(legosets, aes(x=Availability, Pieces)) + 
	geom_boxplot() + 
	geom_hline(yintercept=mean(legosets$Pieces, na.rm=TRUE), color='blue') +
	coord_flip()

legosets[which(legosets$USD_MSRP > 500),]

ggplot(legosets, aes(x=Pieces, y=USD_MSRP)) + 
	geom_point(alpha=.1)

ggplot(legosets, aes(x=Pieces, y=USD_MSRP)) + 
	geom_jitter(alpha=.5)

ggplot(legosets, aes(x=Pieces, y=USD_MSRP)) + 
	geom_vline(xintercept=mean(legosets$Pieces, na.rm=TRUE), color='blue') +
	geom_hline(yintercept=mean(legosets$USD_MSRP, na.rm=TRUE), color='green') +
	geom_point(alpha=.1)
ggsave('legesetsScatter.pdf', width=6, height=4)

legosets2 <- legosets[legosets$Packaging %in% c('Box','Not specified'),]
nrow(legosets2)

ggplot(legosets2, aes(x=Pieces, y=USD_MSRP, color=Packaging)) + 
	geom_point(alhpa=.5) + geom_smooth(method='loess')

df.theme <- as.data.frame(table(legosets$Theme))
themes <- df.theme[df.theme$Freq > 100,]$Var1
df.tab <- as.data.frame(table(legosets$Theme, legosets$Availability))
head(df.tab)
head(data.frame(df.tab$Var1, df.tab$Var1 %in% themes), n=20)

df.tab <- df.tab[df.tab$Var1 %in% themes,]
ggplot(df.tab, aes(x=Var1, fill=Var2, y=Freq)) + geom_bar(stat='identity')

df.city <- legosets[legosets$Theme %in% c('City', 'Town'),]
head(df.city)

df.city <- legosets[legosets$Theme %in% c('City'),]
head(df.city)

library(sqldf)
df.city.sql <- sqldf("SELECT * FROM legosets WHERE Theme = 'City'")

nrow(df.city.sql); nrow(df.city)
