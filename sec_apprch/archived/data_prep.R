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
# doctors <- filter(doctors, county == "臺中市)
# doctors <- doctors[, c("year", "臺中市")]
# colnames(doctors)[2] <- "doctor"

colnames(ozone)[1] <- "year"
ozone <- ozone %>%
  gather("county", "ozone", -1)
# ozone <- filter(ozone, county == "臺中市")
# ozone <- ozone[, c("year", "臺中市")]
# colnames(ozone)[2] <- "ozone"

colnames(revenue)[1] <- "year"
revenue <- revenue %>%
  gather("county", "revenue", -1)
# revenue <- filter(revenue, county == "臺中市")
# revenue <- revenue[, c("year", "臺中市")]
# colnames(revenue)[2] <- "revenue"

cancer <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/lung_cancer_all.csv")
View(cancer)
colnames(cancer) <- c("year", "sex", "county", "cancer", "deaths", "cancer_counts", "mean_age", "median_age", "raw_death_rates")
# lung <- filter(cancer, year>=2015 & cancer=="肺、支氣管及氣管" & (sex=="男" | sex=="女"))
lung <- filter(cancer, cancer=="肺、支氣管及氣管" & (sex=="全"))
lung <- lung[, c(1, 3, 2, 4, 5, 6, 7, 8, 9)]

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
