# 04 - Reglas de Asociación
# Instalar fim4r

library(dplyr)
library(fim4r)

# Datos limpios
datos_limpios <- read.csv("C:\\Users\\rudy\\Downloads\\Personas_limpio.csv", encoding = "UTF-8")
str(datos_limpios)

# Selección automática de variables categóricas
es_categ <- sapply(datos, function(x) is.character(x) || is.factor(x) || length(unique(x[!is.na(x)])) <= 20)
data_fp <- datos[, es_categ, drop = FALSE]

# Convertir a factor y quitar NAs
data_fp[] <- lapply(data_fp, function(x) { if (!is.factor(x)) x <- as.factor(x); x })
data_fp <- na.omit(data_fp)

vars_fp <- c("P02A09","P02A10",
             "P02A11A","P02A11B","P02A11C","P02A11D","P02A11E","P02A11F",
             "P03A03A","P03A03B",
             "P04A03","P04A04",
             "P05C11A","P05C11B","P05C12")

data_fp <- datos[, vars_fp]

# FP-Growth 
reglas_fp <- fim4r(data_fp, method = "fpgrowth", target = "rules", supp = 0.4, conf = 0.5)
df_fp <- as(reglas_fp, "data.frame")

reglas_fp_ord <- sort(reglas_fp, by = "confidence", decreasing = TRUE)
inspect(reglas_fp_ord[1:500])



# intentando con otro set de variables
vars_alt <- c("DOMINIO","P02A02","P02A03","P02A07","P02A08","P02A12",
  "P03A01","P03A02","P04A01","P04A02","P04A03",
  "P05C01","P05C03","P05C10","P05C13","P05C14","P05C16","P05C20","P05C22","P05C25")

data_fp2 <- datos[, vars_alt]

reglas_fp2 <- fim4r(data_fp2, method = "fpgrowth", target = "rules", supp = 0.4, conf = 0.5)
df_fp2 <- as(reglas_fp, "data.frame")

reglas_fp_ord2 <- sort(reglas_fp, by = "confidence", decreasing = TRUE)
inspect(reglas_fp_ord2[1:100])


