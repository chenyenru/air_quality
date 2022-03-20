library(dplyr)
library(openxlsx)
library(readr)
library(tidyr)

# doctors <- read.csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/doctors.csv") # nolint # nolint
ozone <- read.csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/ozone.csv")
revenue <- read.csv("/Users/chen_yenru/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/more/revenue/med.csv")

# colnames(doctors)[1] <- "year"
# View(doctors)
# doctors <- doctors %>%
#   gather("county", "doctor", -1)
# # doctors <- filter(doctors, county == "臺中市)
# # doctors <- doctors[, c("year", "臺中市")]
# # colnames(doctors)[2] <- "doctor"
# View(doctors)

colnames(ozone)[1] <- "year"
ozone <- subset(ozone, year >= 1998)
ozone <- subset(ozone, year <= 2018)
View(ozone)
# ozone <- filter(ozone, county == "臺中市")
# ozone <- ozone[, c("year", "臺中市")]
# colnames(ozone)[2] <- "ozone"

rownames(ozone) <- NULL
View(ozone)

revenue <- revenue %>%
  gather("county", "revenue", -1)

rownames(revenue) <- NULL
revenue <- subset(revenue, year >= 1998)
revenue <- subset(revenue, year <= 2018)
revenue$revenue <- as.numeric(gsub(",", "", revenue$revenue))

# revenue <- filter(revenue, county == "臺中市")
# revenue <- revenue[, c("year", "臺中市")]
# colnames(revenue)[2] <- "revenue"

# lung <- read.delim("DATA/lung_cancer_all.txt", fileEncoding="UTF-8", sep=",")
lung <- read.csv("DATA/lung_cancer_all.csv")
colnames(lung) <- c("year", "sex", "county", "cancer", " ", " ", " ", " ", "raw_cancer_rate")
lung <- subset(lung, !(county %in% c("澎湖縣", "金門縣", "連江縣", "全國")))
lung <- subset(lung, sex %in% c("全"))
lung <- subset(lung, cancer %in% c("肺、支氣管及氣管"))
lung <- subset(lung, year >= 1998)
lung <- subset(lung, year <= 2018)

keep.cols <- names(lung) %in% c(" .1", " .2", " .3", " ", "sex", "cancer") # nolint
lung <- lung[!keep.cols]

rownames(lung) <- NULL
View(lung)

# lung <- head(lung, -2)
# lung <- lung %>%
# gather("sex", "lung_cancer", 3:4)

View(ozone)
View(revenue)

# merge_one <- merge(doctors, ozone, by = c(1, 2), all = TRUE)
# View(merge_one)

merge_two <- merge(ozone, revenue, by = c(1, 2), all = TRUE)
colnames(merge_two)[1] <- "year"
View(merge_two)

merge_three <- merge(merge_two, lung, by = c(2, 1), all = TRUE)
colnames(merge_three)[1] <- "year"
View(merge_three)

Sys.setlocale("LC_ALL", "Chinese")
write.csv(merge_three, "DATA/merged.csv")

# Importing the large dataset of all voila

file <- read.csv("DATA/merged.csv")
file <- file[, -1]
View(file)

summary(file)