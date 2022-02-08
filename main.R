library(dplyr)
library(openxlsx)

deaths_cancer <- read_csv("DATA/taichung_data/child_data/deaths_cancer.csv")
View(deaths_cancer)
deaths_cancer$year<- with(deaths_cancer, Year+1911)
deaths_cancer <- select(deaths_cancer, -1)
deaths_cancer<- deaths_cancer[-c(1,2),]
View(deaths_cancer)

air_quality <- read_csv("DATA/taichung_data/child_data/air_quality.csv")
air_quality <- air_quality[-c(9,10),]
View(air_quality)

population_density <- read_csv("DATA/taichung_data/child_data/population_density.csv")
population_density<- population_density[-c(1,2),]
View(population_density)

merged <- merge(deaths_cancer, air_quality, by="year")
View(merged)

write.csv(merged, "DATA/taichung_data/merged.csv")

# Starting the analysis HERE
fit <- lm(`死亡率-主要癌症_氣管、支氣管和肺癌_死亡率(人/十萬人)_女`~., data=merged[ , !(names(merged) %in% c('死亡率-主要癌症_氣管、支氣管和肺癌_死亡率(人/十萬人)_女'))])




