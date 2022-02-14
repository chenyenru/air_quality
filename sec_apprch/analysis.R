# Importing the large dataset of all voila

file <- read.csv("DATA/merged.csv")
file <- file[,-1]
View(file)

summary(file)


# Starting the analysis HERE
library(tidyverse) # Modern data science library 
library(plm)       # Panel data analysis library
library(car)       # Companion to applied regression 
library(gplots)    # Various programing tools for plotting data
library(tseries)   # For timeseries analysis
library(lmtest)    # For hetoroskedasticity analysis
library(dplyr)
library(showtext)

showtext_auto(enable = TRUE)
# font_families()
# coplot(ozone ~ year|county, type="b", data=file, family="source-han-serif-tw") 
# scatterplot(ozone~year|county, data=file, family="source-han-serif-tw")
# 
# ## Heterogeniety across countries
# plotmeans(ozone ~ county, data = file, family="arial")
# 
# ## Heterogeneity across years
# plotmeans(ozone ~ year, data = file, family="serif")
# 
# # Basic OLS Model
# ols <-lm(ozone ~ doctor, data = file)
# summary(ols)            
# yhat <- ols$fitted
# ggplot(file, aes(x = doctor, y = ozone))+
#   geom_point() +
#   geom_smooth(method=lm)
# 
# # Fixed Effects Model
# library(car)
# fixed.dum <-lm(ozone ~ doctor + factor(county) - 1, data = file)
# summary(fixed.dum)
# yhat <- fixed.dum$fitted
# scatterplot(yhat ~ file$doctor | file$county,  xlab ="doctor", ylab ="yhat of ozone", boxplots = FALSE,smooth = FALSE)
# abline(lm(file$y~file$doctor),lwd=3, col="red")    

library(plm)
file %>% summarise_all(funs(class))
pdf <- pdata.frame(file, c("county","year"))

# Fixed Effects Model
fixed <- plm(raw_death_rates ~ ozone, data=pdf, model="within")
summary(fixed)

# Random Effects Model
random <- plm(raw_death_rates ~ ozone, data=pdf, model="random")
summary(random)

# Fixed vs. Random
# H0 = Random Effects Model is efficient
# H1 = Fixed Effects Model is efficient
# if a > 0.05:
#   We should use the random effects model
phtest(fixed, random)

# Regression Diagnostics
## Time-fixed effects
fixed.time <- plm(raw_death_rates ~ ozone + factor(year), data=pdf, model="within")
summary(fixed.time)

## Testing Time-fixed effects model. The null hypothesis is that no time-fixed effects are needed
pFtest(fixed.time, fixed)
plmtest(fixed, c("time"), type=("bp")) 
### If the p value < 0.05 then use time-fixed effects. 
### In this example, no need to use time-fixed effects.

## Random effects vs Pooled OLS

