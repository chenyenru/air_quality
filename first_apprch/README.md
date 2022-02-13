.
├── DATA
│   ├── panel_analysis.ipynb
│   ├── shitun.csv
│   ├── stripping_data
│   │   ├── aqi_data_raws
            |-- data's too big I don't want to talk about it
│   │   └── big files
│   │       ├── combined.csv
│   │       ├── file.csv
│   │       └── file.csv.zip
│   └── taichung_data
│       ├── child_data
│       │   ├── cars_and_trash.csv
│       │   ├── garbage_truck.csv
│       │   ├── taichung.csv
│       │   ├── tch_cars.csv
│       │   └── trash_burned.csv
│       └── final_merge.csv
├── README.md
└── data_manipulation
    ├── first.ipynb
    ├── merge.py
    ├── second_combine.ipynb
    └── third.ipynb

# Python Notebook
- first.ipynb:
  -  my first attempt to interpret AQI data
-  second.ipynb:
   -  a much cleaner attempt to interpret AQI data
   -  together with merging data
-  third.ipynb
   -  merging with 2 more data
-  **panel_analysis.ipynb**
   -  do panel analysis
      -  adjust linear regression by adjusting with confounding variables' estimators

# Data
## Data Files
[link to data source](https://statdb.dgbas.gov.tw/pxweb/Dialog/statfile9.asp)
- cars_and_trash.csv
- air_quality.csv


## Indicators
------------------------------ 					
指標項：空氣中總懸浮微粒濃度：(微克∕立方公尺) 					
定義：浮游於空氣中之微粒﹙包括10微米以上浮游粒子﹚。各地區濃度為該地?					
洃@ 					
       					
般人工監測站各測站濃度之算數平均值。各測站濃度為該測站各連續24小時 					
       					
監測值之幾何平均值；81年以前每年測定月數未達8個月，82年以後每年 					
       測定次數未達16次之測站及其監測資料不納入計算。 					
註記：環境空氣品質檢驗結果(表號：11320301)；連江縣無一般人工監 					
       測站，金門縣則於102年（含）前無設置。 					
------------------------------ 					
指標項：細懸浮微粒手動監測(PM2.5)濃度值：(微克/立方公尺) 					
定義：指空氣中直徑2.5微米(um)以下的懸浮粒子，其濃度值依據環保署空氣 					
       品質監測站之手動監測資料彙編。 					
註記：1.統計月報表1-1 重要環境保護統計指標。2.資料數據自102年起 					
       。 					
------------------------------ 					
指標項：空氣中臭氧濃度：(ppb) 					
定義：臭氧為光化學霧之主要成份，具強氧化力，對人體黏膜有刺激作用，並?					
鼢茠?					
       					
會造成重大傷害。各地區濃度為該地區一般自動監測站各測站濃度之算數平均 					
       值。 					
註記：環境保護統計年報 表1-10  臭氧濃度監測結果；100年（含）前澎 					
       湖縣、金門縣及連江縣無一般自動監測站。 					
------------------------------ 					
指標項：二氧化硫含量：(ppb) 					
定義：為燃料中硫份燃燒與空氣中之氧結合者，為一具刺激臭味之無色氣體，?					
蝺貍?					
       					
水，與水反應為亞硫酸，為引起酸雨的主要物質。各地區濃度為該地區一般自 					
       動監測站各測站濃度之算數平均值。 					
註記：環境空氣品質監測結果(表號：11320302)；100年（含）前澎 					
       湖縣、金門縣及連江縣無一般自動監測站。 					
------------------------------ 					
指標項：AQI(PSI)>100之日數比率：(％) 					
定義：105年(含)前指PSI>100之日數占PSI總監測日數之百分比；1 					
       06年起指AQI>100之日數占AQI總監測日數之百分比。PSI係指 					
       空氣污染指標 (Pollutant Standard Index)； 					
       AQI係指空氣品質指標 (Air Quality Index)。 					
公式：(PSI>100之日數∕PSI總監測日數)*100；(AQI>100 					
       之日數∕AQI總監測日數)*100 					

------------------------------ 					
指標項：汽車密度：(輛∕平方公里) 					
定義：平均每一平方公里之汽車數。 					
公式：(汽車登記數∕土地面積) 					
●土地面積(平方公里） 					

------------------------------ 					
指標項：工廠密度：(家∕平方公里) 					
定義：平均每一平方公里之營運中工廠家數。 					
公式：(營運中工廠家數∕土地面積) 					
●土地面積(平方公里） 					

------------------------------ 					
- 指標項：都市計畫區現況人口密度：(人∕平方公里) 	
定義：指都市計畫區內每單位土地面積之現況人口數。 	
公式：(都市計畫區現況人口∕都市計畫區面積) 	