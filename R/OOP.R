source('R/contingency.table.R')
load('Data/titanic.Rda')

names(titanic)
head(titanic)
table(titanic$sex, titanic$survived)
prop.table(table(titanic$sex, titanic$survived))

ct <- contingency.table(x=titanic$sex, y=titanic$survived)
ct
print(ct)

contingency.table(titanic$pclass, titanic$survived)


# Linear regression
out <- glm(survived ~ pclass + sex + age, data=titanic, family='binomial')
class(out)
print(out)
summary(out)

summary(titanic$survived)
summary(titanic$fare)

plot(ct, legend='Percentn of Total')
