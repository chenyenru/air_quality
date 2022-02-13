library(dplyr)
library(openxlsx)
library(readr)


deaths_cancer <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/DATA/taichung_data/child_data/deaths_cancer_organized.csv")
# View(deaths_cancer)
deaths_cancer$year<- with(deaths_cancer, Year+1911)
deaths_cancer <- select(deaths_cancer, -1)
deaths_cancer<- deaths_cancer[-c(1,2),]
# View(deaths_cancer)

air_quality <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/DATA/taichung_data/child_data/air_quality.csv")
air_quality <- air_quality[-c(9,10),]
# View(air_quality)

population_density <- read_csv("~/Documents/GitHub/Data_Analysis/air_qu/DATA/taichung_data/child_data/population_density.csv")
# View(population_density)
population_density<- population_density[-c(1,2),]
# View(population_density)

education <- read.csv("~/Documents/GitHub/Data_Analysis/air_qu/DATA/taichung_data/child_data/education_organized.csv")
# View(education)
merge_one <- merge(population_density, air_quality, by="year")
# View(merge_one)

merge_two<- merge(deaths_cancer, education, by="year")
# View(merge_two)
merge_three <- merge(merge_one, merge_two, by="year")
# View(merge_three)


write.csv(merge_three, "DATA/taichung_data/merged.csv")

# Importing the large dataset of all voila

file <- read_csv("DATA/stripping_data/big files/file.csv")
View(file)

summary(file)





# Starting the analysis HERE
fit1 <- lm(`死亡率.主要癌症_氣管.支氣管和肺癌_死亡率.人.十萬人.`~ 標準化死亡率.主要死因_癌症.人.十萬人.+空氣中總懸浮微粒濃度+population_density+AQI.PSI..100之日數比率, data=merge_three)
fit2 <- lm(`死亡人數.主要死因_肺炎.人..`~ 標準化死亡率.主要死因_癌症.人.十萬人.+空氣中總懸浮微粒濃度+population_density+AQI.PSI..100之日數比率, data=merge_three)
fit3 <- lm(`教育程度_15歲以上人口教育程度_大學...`~ 標準化死亡率.主要死因_癌症.人.十萬人.+空氣中總懸浮微粒濃度+population_density+AQI.PSI..100之日數比率, data=merge_three)


summary(fit)

