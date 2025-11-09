# 03 - Reglas de Asociación (Apriori)
library(dplyr)
library(arules)

# Datos limpios
datos_limpios <- read.csv("C:\\Users\\rudy\\Downloads\\Personas_limpio.csv", encoding = "UTF-8")
str(datos_limpios)

# eligiendo variables
data_ap <- datos_limpios[, c("DOMINIO", "P02A02", "P02A03", "P02A07", 
                     "P03A01", "P03A02", "P05C09A", "P05C12", "P05D01")]

# haciendo limipieza de datos
data_ap <- na.omit(data_ap)


num_cols <- sapply(data_ap, is.numeric)
if (any(num_cols)) {
  data_ap[, num_cols] <- arules::discretizeDF(data_ap[, num_cols, drop = FALSE])
}
data_ap[, !num_cols] <- lapply(data_ap[, !num_cols, drop = FALSE], factor)

# Convertir a transacciones
trans <- as(data_ap, "transactions")

# Aplicar algoritmo Apriori
reglas <- apriori(trans, parameter = list(support = 0.4, confidence = 0.5, target = "rules"))
reglas_ordenadas <- sort(reglas, by = "support", decreasing = TRUE)

# Visualizar reglas encontradas
inspect(reglas_ordenadas)