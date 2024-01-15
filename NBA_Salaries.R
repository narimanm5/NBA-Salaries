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
library(car)
vif(fit)

plot(salary~PPG)
abline(fit,col="red")
#A2-linearity


#A3-homoscedasticity
plot(residuals(fit)~PPG)
plot(residuals(fit)~RPG)
plot(residuals(fit)~TOPG)
plot(residuals(fit)~APG)
plot(fit,which = 1)
library(lmtest)
gqtest(fit)
#hetroscedasticity! variance increases from segment 1 to 2

#A4-indepency of errors
plot(residuals(fit)~DF$...1)
abline(h=0,col="red")
acf(residuals(fit),main="")
plot(fit,which = 3)

#A5-normality
plot(fit,which = 2)
shapiro.test(resid(fit))




library(randtests)
runs.test(residuals(fit),alternative = "two.sided")
# errors are independent!

n <- length(season17_18)
Syy <- (n-1) * var(season17_18)
new <- data.frame(PPG = 30,MPG = 40,RPG = 5,APG = 10)
predict.lm(fit,new,interval = "prediction")


qqPlot(PPG)
norm(PPG)
