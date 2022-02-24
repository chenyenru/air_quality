library(readxl)
library(openxlsx)

a <- loadWorkbook(('DATA/more/density.xlsx'))
sheetNames <- sheets(a)
for(i in 1:length(sheetNames))
{
  assign(sheetNames[i],readWorkbook(a,sheet = i))
}

b <- loadWorkbook(('DATA/more/environment.xlsx'))
sheetNames <- sheets(b)
for(i in 1:length(sheetNames))
{
  assign(sheetNames[i],readWorkbook(b,sheet = i))
}

hospital_bed <- read_xlsx("DATA/more/hospital_bed.xlsx")
revenue <- read_xlsx("DATA/more/revenue.xlsx")



