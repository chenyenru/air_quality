library(dplyr)
library(openxlsx)
library(readr)
library(tidyr)

doctors <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/doctors.csv")
ozone <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/ozone.csv")
revenue <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/revenue.csv")

colnames(doctors)[1] <- "year"
View(doctors)
doctors <- doctors %>%
  gather("county", "doctor", -1)
# doctors <- filter(doctors, county == "臺中市)
# doctors <- doctors[, c("year", "臺中市")]
# colnames(doctors)[2] <- "doctor"
View(doctors)

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

# lung <- read.delim("DATA/lung_cancer_all.txt", fileEncoding="UTF-8", sep=",")
lung <- read.csv("DATA/lung_cancer_all.csv")
View(lung)
colnames(lung) <- c("year", "sex", "county", "cancer", " ", " ", " ", " ", "raw cancer_rate")
lung <- subset(lung, !(county %in% c("澎湖縣", "金門縣", "連江縣")))
lung <- subset(lung, sex %in% c("全"))
lung <- subset(lung, cancer %in% c("肺、支氣管及氣管"))
lung <- subset(lung, year>2000)


# lung <- head(lung, -2)
# lung <- lung %>%
# gather("sex", "lung_cancer", 3:4)

doctors
ozone
revenue

merge_one <- merge(doctors, ozone, by=c(1, 2), all = TRUE)
# View(merge_one)

merge_two<- merge(merge_one, revenue, by=c(1, 2), all = TRUE)
colnames(merge_two)[1] <- "year"
# View(merge_two)

merge_three <- merge(merge_two, lung, by=c(1, 2), all = TRUE)
# View(merge_three)

View(merge_three)

Sys.setlocale("LC_ALL","Chinese")
write.csv(merge_three, "DATA/merged.csv")

# Importing the large dataset of all voila

file <- read.csv("DATA/merged.csv")
file <- file[,-1]
View(file)

summary(file)