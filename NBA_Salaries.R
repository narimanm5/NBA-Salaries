library(data.table)
library(corrplot)
library(GGally)
library(tidyverse)
library(PerformanceAnalytics)
library(plotly)
attach(DF)
variables <- 
  DF %>% 
  select(PPG, MPG, TOPG, RPG, PER, SPG, APG)
salary <- season17_18
fit <- lm(salary ~ .,data = variables)
stats_salary <- 
  DF %>% 
  select(season17_18, PPG, MPG,  RPG, APG)
ggpairs(stats_salary)
summary(fit)
anova(fit)
step(fit,test="F")

fit <- lm(salary ~ PPG + TOPG + RPG + APG)
summary(fit)
anova(fit)
step(fit,test="F")
library(car)
vif(fit)

plot(salary~PPG)
abline(fit,col="red")
#A2-linearity
plot(fit,which=1)

#A3-homoscedasticity
plot(residuals(fit)~PPG)
plot(residuals(fit)~RPG)
plot(residuals(fit)~TOPG)
plot(residuals(fit)~APG)
plot(fit,which = 3)
library(lmtest)
gqtest(fit)
#hetroscedasticity! variance increases from segment 1 to 2

#A4-Independence of errors
plot(residuals(fit)~DF$...1,xlab="index" ,pch=16)
abline(h=0,col="red")
acf(residuals(fit),main="")
plot(fit,which = 3)
library(randtests)
runs.test(residuals(fit),alternative = "two.sided")
# errors are independent!

#A5-normality
plot(fit,which = 2)
shapiro.test(resid(fit))







