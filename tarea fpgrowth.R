install.packages("readxl")
library(readxl)
pkgbuild::find_rtools()

install.packages("pkgbuild")
library(pkgbuild)
pkgbuild::find_rtools()

install.packages("arules")
library(arules)

install.packages("readxl")
library(readxl)

library(fim4r)


datos <- read_excel("C:\\Users\\Rudy\\OneDrive\\Rudy\\USAC\\4.Trimestre\\Introduccion a la mineria de datos\\sesion 3\\base_datos_violencia_intrafamiliar.xlsx")
datos <- read.csv("C:/Users/Rudy/OneDrive/Rudy/USAC/4.Trimestre/Introduccion a la mineria de datos/sesion 3/base_datos_violencia_intrafamiliar.csv", encoding = "UTF-8")

data_fp <- datos[, c( "VIC_EDAD", "VIC_ESCOLARIDAD", "VIC_TRABAJA","TOTAL_HIJOS","VIC_REL_AGR","VIC_OCUP")]
reglas_fp <- fim4r(data_fp, method="fpgrowth", target ="rules", supp =.2, conf=.5)
rf <- as(reglas_fp, "data.frame")

lapply(data_fp, function(x) sort(unique(x)))
lapply(data_fp, function(x) sort(table(x), decreasing = TRUE))

data_fp_2 = data_fp %>%
  filter(TOTAL_HIJOS != 99)

data_fp_3 = data_fp_2 %>%
  filter(VIC_TRABAJA != 9)

reglas_fp_2 <- fim4r(data_fp_3, method="fpgrowth", target ="rules", supp =.2, conf=.5)
rf_2 <- as(reglas_fp_2, "data.frame")





