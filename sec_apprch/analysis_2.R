df <- read.csv("DATA/merge2.csv")
View(df)
df <- df[, -1]
df
View(df)
library(imputeTS)
# df <- imputeTS::na_ma(df, k = 4, weighting = "simple")
# View(df)
na_interpolation(df, option = "linear")
View(df)

# determine if there's na
sum(is.na(df))


# Importing the large dataset of all voila

file <- df

summary(file)
colnames(file)[8] <- "raw_death_rates"
colnames(file)[8]


# Starting the analysis HERE
library(tidyverse) # Modern data science library
library(plm) # Panel data analysis library
library(car) # Companion to applied regression
library(gplots) # Various programing tools for plotting data
library(tseries) # For timeseries analysis
library(lmtest) # For hetoroskedasticity analysis
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


# "year", "county", "waste_recycled_muni", "locomobiles_density", "automobiles_density", "factory_density", "urban_density", "ozone", "revenue"
# year, county, waste_recycled_muni, locomobiles_density, automobiles_density, factory_density, urban_density, raw_cancer_rate, ozone, revenue
# raw_death_rates ~ year + county + waste_recycled_muni + locomobiles_density + automobiles_density + factory_density + urban_density + ozone + revenue

file$factory_density <- as.numeric(as.character(file$factory_density))

library(plm)
file %>% summarise_all(funs(class))
pdf <- pdata.frame(file, c("county", "year"))
View(pdf)


# model<- (raw_death_rates ~ waste_recycled_muni + bulk_waste_recycled + rate_material_recov + locomobiles_density + automobiles_density + factory_density + doctor + ozone + revenue + sex + deaths + mean_age)
model <- (raw_death_rates ~ waste_recycled_muni + locomobiles_density + automobiles_density + factory_density + urban_density + ozone + revenue)
# Random Effects Model
random <- plm(model, data = pdf, model = "random")
# random.method = "amemiya"
summary(random)

# Fixed Effects Model
fixed <- plm(model, data = pdf, model = "within")
summary(fixed)



# Fixed vs. Random
# H0) = Random Effects Model is efficient
# H1) = Fixed Effects Model is efficient
# if a > 0.05:
#   We should use the random effects model
phtest(fixed, random)

# Regression Diagnostics
## Time-fixed effects
fixed.time <- plm(raw_death_rates ~ ozone + factor(year) + waste_recycled_muni + locomobiles_density + automobiles_density + factory_density + urban_density + revenue, data = pdf, model = "within")
summary(fixed.time)

## Testing Time-fixed effects model. The null hypothesis is that no time-fixed effects are needed
pFtest(fixed.time, fixed)
plmtest(fixed, c("time"), type = ("bp"))
### If the p value < 0.05 then use time-fixed effects.
### In this example, no need to use time-fixed effects.

## Random effects vs Pooled OLS
pool <- plm(raw_death_rates ~ ozone, data = pdf, model = "pooling")
summary(pool)

## Breusch-Pagan Lagrange Multiplier for random effects. Null is no panel effect (i.e. OLS better).
plmtest(pool, type = c("bp"))

## Cross-sectional dependence testing
fixed <- plm(raw_death_rates ~ ozone, data = pdf, model = "within")
pcdtest(fixed, c("lm"))
pcdtest(fixed, c("cd"))

## Serial Correlation Testing
pbgtest(fixed)

## Unit Roots / Stationary Testing
### H0) The null hypothesis is that the series has a unit root (i.e. non-stationary)
adf.test(pdf$raw_death_rates, k = 2)

## Heteroskedasticity testing
### If hetersokedasticity is detected we need to use a robust covariance matrix (Sandwich estimator) to account for it
bptest(raw_death_rates ~ ozone + factor(county), data = pdf, studentize = F)

## Controlling for heteroskedasticity: Random effects
### Original Coefficients
coeftest(random)
### Heteroskedasticity consistent coefficients
coeftest(random, vcovHC)
### Heteroskedasticity consistent coefficients, type 3
coeftest(random, vcovHC(random, type = "HC3"))
### The following shows the HC standard errors of the coefficients
t(sapply(c("HC0", "HC1", "HC2", "HC3", "HC4"), function(x) sqrt(diag(vcovHC(random, type = x)))))

## Controlling for heteroskedasticity: Fixed effects
### Original coefficients
coeftest(fixed)
### Heteroskedasticity consistent coefficients
coeftest(fixed, vcovHC)
### Heteroskedasticity consistent coefficients (Arellano)
coeftest(fixed, vcovHC(fixed, method = "arellano"))
### Heteroskedasticity consistent coefficients, type 3
coeftest(fixed, vcovHC(fixed, type = "HC3"))
### The following shows the HC standard errors of the coefficients
t(sapply(c("HC0", "HC1", "HC2", "HC3", "HC4"), function(x) sqrt(diag(vcovHC(fixed, type = x)))))
