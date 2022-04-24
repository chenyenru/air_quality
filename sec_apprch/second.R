library(dplyr)
library(openxlsx)
library(readr)
library(tidyr)

# doctors <- read.csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/doctors.csv") # nolint # nolint
ozone <- read.csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/ozone.csv")
revenue <- read.csv("/Users/chen_yenru/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/more/revenue/med.csv")
co <- read.csv("/Users/chen_yenru/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/drive-download/CO.csv")
no2 <- read.csv("/Users/chen_yenru/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/drive-download/no2.csv")
smoke <- read.csv("~/Documents/GitHub/Data_Analysis/air_qu/sec_apprch/DATA/smoke.csv")

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

revenue <- revenue %>%
  gather("county", "revenue", -1)

rownames(revenue) <- NULL
revenue <- subset(revenue, year >= 1998)
revenue <- subset(revenue, year <= 2018)
revenue$revenue <- as.numeric(gsub(",", "", revenue$revenue))

colnames(co)[1] <- "year"
co <- co %>%
  gather("county", "co", -1)

colnames(no2)[1] <- "year"
no2 <- no2 %>%
  gather("county", "no2", -1)

smoke_new <- subset(smoke, select = c(1, 2, 4))

colnames(smoke_new) <- c("year", "county", "smoke")


# revenue <- filter(revenue, county == "臺中市")
# revenue <- revenue[, c("year", "臺中市")]
# colnames(revenue)[2] <- "revenue"

# lung <- read.delim("DATA/lung_cancer_all.txt", fileEncoding="UTF-8", sep=",")
lung <- read.csv("DATA/lung_cancer_all.csv")
colnames(lung) <- c("year", "sex", "county", "cancer", " ", " ", " ", " ", "raw_cancer_rate")
lung <- subset(lung, !(county %in% c("澎湖縣", "金門縣", "連江縣", "全國", "新北市")))
lung <- subset(lung, sex %in% c("全"))
lung <- subset(lung, year >= 1998)
lung <- subset(lung, year <= 2018)
ovarian <- subset(lung, cancer %in% c("卵巢、輸卵管及寬韌帶"))
liver <- subset(lung, cancer %in% c("肝及肝內膽管"))
breast <- subset(lung, cancer %in% c("女性乳房"))
oral <- subset(lung, cancer %in% c("口腔、口咽及下咽"))
lung <- subset(lung, cancer %in% c("肺、支氣管及氣管"))

keep.cols <- names(ovarian) %in% c(" .1", " .2", " .3", " ", "sex", "cancer") # nolint
keep.cols <- names(liver) %in% c(" .1", " .2", " .3", " ", "sex", "cancer") # nolint
keep.cols <- names(breast) %in% c(" .1", " .2", " .3", " ", "sex", "cancer") # nolint
keep.cols <- names(oral) %in% c(" .1", " .2", " .3", " ", "sex", "cancer") # nolint
keep.cols <- names(lung) %in% c(" .1", " .2", " .3", " ", "sex", "cancer") # nolint



ovarian <- ovarian[!keep.cols]
liver <- liver[!keep.cols]
breast <- breast[!keep.cols]
oral <- oral[!keep.cols]
lung <- lung[!keep.cols]

rownames(ovarian) <- NULL
rownames(liver) <- NULL
rownames(breast) <- NULL
rownames(oral) <- NULL
rownames(lung) <- NULL

colnames(ovarian)[3] <- "ovarian"
colnames(liver)[3] <- "liver"
colnames(breast)[3] <- "breast"
colnames(oral)[3] <- "oral"
colnames(lung)[3] <- "lung"

# lung <- head(lung, -2)
# lung <- lung %>%
# gather("sex", "lung_cancer", 3:4)

# View(ozone)
# View(revenue)

# merge_one <- merge(doctors, ozone, by = c(1, 2), all = TRUE)
# View(merge_one)

merge_two <- merge(ozone, revenue, by = c(1, 2), all = TRUE)
colnames(merge_two)[1] <- "year"
# View(merge_two)
merge_two <- merge_two[order(merge_two$year), ]
merge_two <- subset(merge_two, !(county %in% c("新北市")))

merge_three <- merge(lung, merge_two, by = c(1, 2), all = TRUE)
merge_four <- merge(co, merge_three, by = c(1, 2))
merge_five <- merge(no2, merge_four, by = c(1, 2))
merge_six <- merge(smoke_new, merge_five, by = c(1, 2))
merge_seven <- merge(ovarian, merge_six, by = c(1, 2))
merge_eight <- merge(liver, merge_seven, by = c(1, 2))
merge_nine <- merge(breast, merge_eight, by = c(1, 2))
merge_ten <- merge(oral, merge_nine, by = c(1, 2))

Sys.setlocale("LC_ALL", "Chinese")
write.csv(merge_ten, "DATA/merged.csv")

# Importing the large dataset of all to test, voila

# file <- read.csv("DATA/merged.csv")
# file <- file[, -1]
# View(file)
# 
# summary(file)