library(dplyr)
library(openxlsx)
library(readr)
library(tidyr)

doctors <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/doctors.csv")
ozone <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/ozone.csv")
revenue <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/revenue.csv")

colnames(doctors)[1] <- "year"
doctors <- doctors %>%
  gather("county", "doctor", -1)
doctors <- filter(doctors, county == "臺中市")
# doctors <- doctors[, c("year", "臺中市")]
# colnames(doctors)[2] <- "doctor"

colnames(ozone)[1] <- "year"
ozone <- ozone %>%
  gather("county", "ozone", -1)
ozone <- filter(ozone, county == "臺中市")
# ozone <- ozone[, c("year", "臺中市")]
# colnames(ozone)[2] <- "ozone"

colnames(revenue)[1] <- "year"
revenue <- revenue %>%
  gather("county", "revenue", -1)
revenue <- filter(revenue, county == "臺中市")
# revenue <- revenue[, c("year", "臺中市")]
# colnames(revenue)[2] <- "revenue"

lung <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/deaths_lung.csv")
lung <- head(lung, -2)
lung <- lung %>%
  gather("sex", "lung_cancer", 3:4)

lung
colnames(lung)[1] <- "year"
colnames(lung)[2] <- "county"
lung$sex = NULL

doctors
ozone
revenue

merge_one <- merge(doctors, ozone, by=c(1, 2))
# View(merge_one)

merge_two<- merge(merge_one, revenue, by=c(1, 2))
colnames(merge_two)[1] <- "year"
# View(merge_two)

merge_three <- merge(merge_two, lung, by=c(1, 2))
# View(merge_three)

Sys.setlocale("LC_ALL","Chinese")
write.csv(merge_three, "DATA/merged.csv")

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

library(showtext)
showtext_auto(enable = TRUE)
font_families()
coplot(ozone ~ year|county, type="b", data=file, family="source-han-serif-tw") 
scatterplot(ozone~year|county, data=file, family="source-han-serif-tw")

  ## Heterogeniety across countries
plotmeans(ozone ~ county, data = file, family="arial")

  ## Heterogeneity across years
plotmeans(ozone ~ year, data = file, family="serif")

# Basic OLS Model
ols <-lm(ozone ~ doctor, data = file)
summary(ols)            
yhat <- ols$fitted
ggplot(file, aes(x = doctor, y = ozone))+
  geom_point() +
  geom_smooth(method=lm)

# Fixed Effects Model
library(car)
fixed.dum <-lm(ozone ~ doctor + factor(county) - 1, data = file)
summary(fixed.dum)
yhat <- fixed.dum$fitted
scatterplot(yhat ~ file$doctor | file$county,  xlab ="doctor", ylab ="yhat of ozone", boxplots = FALSE,smooth = FALSE)
abline(lm(file$y~file$doctor),lwd=3, col="red")    


# Random Effects Model
random <- plm(ozone ~ doctor, data=file, model="random")
summary(random)


## Using PLM
# import package
# import data 
pdf = pdata.frame(file, index = c("county", "year"))
# specify and run the model
model = plm(ozone~doctor, data = pdf, model = "random")
summary(model)



# Decide using fixed or random
phtest(fixed, random)
