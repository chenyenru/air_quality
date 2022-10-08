library(ggplot2)
dataset <- read.csv("Dataset.csv")
dataset$X=NULL
colnames(dataset)

x <- dataset$no2
y <- dataset$liver


plot(x, y, main = "Main title",
     xlab = "NO2 Concentration", ylab = "Liver Cancer Incidence Rate",
     pch = 19)
A = 5.6422*exp(-1)
abline(a=A,b=-6.2658, col="red", lwd=3, lty=2)
