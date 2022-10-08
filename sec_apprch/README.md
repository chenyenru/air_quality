<!-- ## lung_cancer_all.csv -->

Age-standardized incidence rate per 100,000 standard population

"year", "sex", "county", "cancer", "deaths", "cancer_counts", "mean_age", "median_age", "raw_death_rates"

[1] "癌症診斷年"                                          "性別"                                               
[3] "縣市別"                                              "癌症別"                                             
[5] "年齡標準化發生率  WHO 2000世界標準人口 (每10萬人口)" "癌症發生數"                                         
[7] "平均年齡"                                            "年齡中位數"                                         
[9] "粗率 (每10萬人口)" 

## environment.xlsx

| 指標項                 | 定義                            | 公式                                   | 英文                                               |
| ------------------- | ----------------------------- | ------------------------------------ | ------------------------------------------------ |
| **空氣中臭氧濃度：(ppb)**   | 臭氧為光化學霧之主要成份，具強氧化力，對人體黏膜有刺激作用 | 各地區濃度為該地區一般自動監測站各測站濃度之算數平均  <br/> 值。 | Ozone Concentration (ppb)                        |
| **平均每人每年可支配所得：(元)** | 平均每人每年可支配所得。                  | 平均每戶可支配所得／平均每戶人數                     | Disposable household and per capita income (NTD) |
| 每萬人口病床數：(床／萬人)      | 每萬人口病床數。                      | (病床數／戶籍登記人口數)*10,0ph00               | Number of hospital beds per 10,000               |
| 工廠密度：(家／平方公里)       | 平均每一平方公里之營運中工廠家數。             | (營運中工廠家數／土地面積)                       | Number of factories per square kilometer         |
| 機車密度：(輛／平方公里)       | 平均每一平方公里之機車數。                 | 機車登記數／土地面積                           | Number of locomobiles per square kilometer       |

# Treatment variable

- **空氣中臭氧濃度**
  - ozone.csv [source](https://statis91.epa.gov.tw/epanet/)

# Observing variable

- 粗率 (每10萬人口)
  - 也就是肺癌死亡率
- # Controlled variables

### environment.xlsx

- 執行機關資源回收量 Recyclable Waste Recycled by Municipal Collection Team
- 巨大垃圾回收再利用量 Bulk Waste Recycled (ton)
- 一般廢棄物妥善處理率 rate of material recovery
- 機車密度 Number of locomobiles per square kilometer
- 汽車密度 Number of automobiles per square kilometer
- 工廠密度 Number of factories per square kilometer

### hospital_bed.xlsx

- 每萬人口病床數

### lung_cancer_all.xlsx

> "癌症診斷年","性別","縣市別","癌症別","年齡標準化發生率 WHO 2000世界標準人口 (每10萬人口)","癌症發生數","平均年齡","年齡中位數","粗率 (每10萬人口)"

> "year", "sex", "county", "cancer", "deaths", "cancer_counts", "mean_age", "median_age", "raw_death_rates"

年齡標準化發生率 WHO 2000世界標準人口 (每10萬人口) = Age-standardized incidence rate per 100,000 standard population

- 癌症診斷年
- 性別
- 縣市別
- 癌症別
- 年齡標準化發生率 WHO 2000世界標準人口 (每10萬人口)
- 癌症發生數
- 平均年齡
- 年齡中位數
- 粗率 (每10萬人口)

### revenue.xlsx

- 平均每人所獲得所得
  - median.xlsx
- 中位數每人所獲得所得 [source](https://www.stat.gov.tw/ct.asp?xItem=40875&ctNode=511&mp=4)
  - med.xlsx
  - med.csv

### urban_density.xlsx

- 都市計畫區現況人口密度：(人／平方公里)
  - 定義：指都市計畫區內每單位土地面積之現況人口數。 

### pm_concentration.csv

指標項：空氣中總懸浮微粒濃度(微克／立方公尺) PM Concentration 
定義：浮游於空氣中之微粒（包括10微米以上浮游粒子）。各地區濃度為該地?
洃@ 

般人工監測站各測站濃度之算數平均值。各測站濃度為該測站各連續24小時 

監測值之幾何平均值；81年以前每年測定月數未達8個月，82年以後每年 
       測定次數未達16次之測站及其監測資料不納入計算。 
註記：環境空氣品質檢驗結果(表號：11320301)；連江縣無一般人工監 
       測站，金門縣則於102年（含）前無設置。 

### so2_concentration.csv

指標項：二氧化硫含量(ppb) Sulfur Dioxide
定義：為燃料中硫份燃燒與空氣中之氧結合者，為一具刺激臭味之無色氣體，?
蝺貍?

水，與水反應為亞硫酸，為引起酸雨的主要物質。各地區濃度為該地區一般自 
       動監測站各測站濃度之算數平均值。 
註記：環境空氣品質監測結果(表號：11320302)；100年（含）前澎 
       湖縣、金門縣及連江縣無一般自動監測站。 
