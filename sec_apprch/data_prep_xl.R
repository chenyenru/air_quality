library(readxl)
library(openxlsx)
library(tidyr)


# environment <- loadWorkbook('DATA/more/environment.xlsx')
# sheetNames2 <- sheets(environment)

env_eng <- c(
  "waste_recycled_muni",
  "bulk_waste_recycled",
  "rate_material_recov",
  "locomobiles_density",
  "automobiles_density",
  "factory_density"
)

library(openxlsx)
a <- loadWorkbook("DATA/more/environment.xlsx")
sheetNames <- sheets(a)
for (i in 1:length(sheetNames))
{
  assign(sheetNames[i], readWorkbook(a, sheet = i))
}

urban_density <- gather(read_xlsx("DATA/more/urban_density.xlsx"), "county", "urban_density", -year)

hospital_bed <- gather(read_xlsx("DATA/more/hospital_bed.xlsx"), "county", "hospital_bed", -year)
waste_recycled_muni <- read.csv("DATA/more/執行機關資源回收量.csv")

#  waste_recycled_muni <- gather(` 執行機關資源回收量`, "county", "waste_recycled_muni", -year)


bulk_waste_recycled <- gather(` 巨大垃圾回收再利用量`, "county", "bulk_waste_recycled", -year)

一般廢棄物妥善處理率 <- read.csv("DATA/more/一般廢棄物妥善處理率.csv")
rate_material_recov <- gather(`一般廢棄物妥善處理率`, "county", "rate_material_recov", -year)

`家庭收支-平均儲蓄傾向` <- read.csv("DATA/more/家庭收支-平均儲蓄傾向.csv")
family_income <- gather(`家庭收支-平均儲蓄傾向`, "county", "family_income", -year)

`就業者之行業結構-工業` <- read.csv("DATA/more/就業者之行業結構-工業.csv")
employee_industrial <- gather(`就業者之行業結構-工業`, "county", "employee_industrial", -year)

factory_density <- gather(` 工廠密度`, "county", "factory_density", -year)

locomobiles_density <- gather(` 機車密度`, "county", "locomobiles_density", -year)
automobiles_density <- gather(` 汽車密度`, "county", "automobiles_density", -year)
factory_density <- gather(` 工廠密度`, "county", "factory_density", -year)
factory_density <- gather(` 工廠密度`, "county", "factory_density", -year)


# temp <- merge(waste_recycled_muni, bulk_waste_recycled, by = c(1, 2))
# temp <- merge(temp, rate_material_recov, by = c(1, 2))
temp1 <- merge(waste_recycled_muni, locomobiles_density, by = c(1, 2))
temp2 <- merge(temp1, automobiles_density, by = c(1, 2))
temp3 <- merge(temp2, factory_density, by = c(1, 2))
temp4 <- merge(temp3, urban_density, by = c(1, 2))
temp5 <- merge(temp4, hospital_bed, by = c(1, 2))
temp6 <- merge(temp5, rate_material_recov, by = c(1, 2))
temp7 <- merge(temp6, employee_industrial, by = c(1, 2))
temp8 <- merge(temp7, family_income, by = c(1, 2))

temp9 <- subset(temp8, !(county %in% c("澎湖縣", "金門縣", "連江縣", "總計", "新北市", "臺灣地區")))

import <- read.csv("DATA/merged.csv")
import <- import[, -1]

final <- merge(temp9, import, by = c(1, 2))


View(final)
write.csv(final, "DATA/merge2.csv")

