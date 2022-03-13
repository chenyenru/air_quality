library(readxl)
library(openxlsx)
library(tidyr)


# environment <- loadWorkbook('DATA/more/environment.xlsx')
# sheetNames2 <- sheets(environment)

env_eng <- c("waste_recycled_muni", 
                 "bulk_waste_recycled", 
                 "rate_material_recov", 
                 "locomobiles_density",
                 "automobiles_density",
                 "factory_density")

library(openxlsx)
a <- loadWorkbook('DATA/more/environment.xlsx')
sheetNames <- sheets(a)
for(i in 1:length(sheetNames))
{
  assign(sheetNames[i],readWorkbook(a,sheet = i))
}

urban_density <- gather(read_xlsx("DATA/more/density.xlsx"), "county", "urban_density", -year)

hospital_bed <- gather(read_xlsx("DATA/more/hospital_bed.xlsx"), "county", "hospital_bed", -year)

revenue <- gather(read_xlsx("DATA/more/revenue.xlsx"), "county", "revenue", -year)

waste_recycled_muni <- gather(` 執行機關資源回收量`, "county", "waste_recycled_muni", -year)
bulk_waste_recycled <- gather(` 巨大垃圾回收再利用量`, "county", "bulk_waste_recycled", -year)
rate_material_recov <- gather(` 一般廢棄物妥善處理率`, "county", "rate_material_recov", -year)
locomobiles_density <- gather(` 機車密度`, "county", "locomobiles_density", -year)
automobiles_density <- gather(` 汽車密度`, "county", "automobiles_density", -year)
factory_density <- gather(` 工廠密度`, "county", "factory_density", -year)

temp <- merge(waste_recycled_muni, bulk_waste_recycled, by=c(1, 2))
temp <- merge(temp, rate_material_recov, by=c(1, 2))
temp <- merge(temp, locomobiles_density, by=c(1, 2))
temp <- merge(temp, automobiles_density, by=c(1, 2))
temp <- merge(temp, factory_density, by=c(1, 2))


import <- read.csv("DATA/merged.csv")
import <- import[,-1]
View(import)

temp <- merge(temp, import, by=c(1,2))

View(temp)
write.csv(temp, "DATA/more/merge2.csv")
