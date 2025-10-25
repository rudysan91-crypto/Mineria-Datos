# Carga de librerias
library(readxl)
library(arules)
library(ggplot2)
library(dplyr)


datos = read.csv("C:/Users/Rudy/OneDrive/Rudy/USAC/4.Trimestre/Introduccion a la mineria de datos/sesion 3/base_datos_violencia_intrafamiliar.csv", encoding = "UTF-8")

# Creando Data Frame
data_fp = datos[, c("VIC_EDAD", "VIC_ESCOLARIDAD", "VIC_TRABAJA", "VIC_REL_AGR", "VIC_OCUP", "TOTAL_HIJOS")]
data_fp_gr = datos[, c("VIC_EDAD", "VIC_ESCOLARIDAD", "HEC_DEPTO", "VIC_TRABAJA", "AGR_EDAD", "AGR_ESCOLARIDAD")]
data_fp_guatemala = subset(data_fp_gr, HEC_DEPTO == 1)

# Definir el objeto que faltaba
data_fp_CR = data_fp

# Revisando estado de los datos
lapply(data_fp_CR, function(x) sort(unique(x)))

# Filtrado de datos en una sola variable
df_filtrado = data_fp_CR %>%
  filter(TOTAL_HIJOS != 99) %>%
  filter(VIC_TRABAJA != 9)

# Asignando valor numerico a los datos nulos
df_filtrado[is.na(df_filtrado)] = -1
data_fp_guatemala[is.na(data_fp_guatemala)] = -1

# Creando los cálculos k-Means
cluster = kmeans(df_filtrado, centers = 3)
cluster_gt = kmeans(data_fp_guatemala, centers = 3)

# VICTIMA EDAD vs AGRESOR EDAD
ggplot(data_fp_guatemala, aes(x = VIC_EDAD, y = AGR_EDAD, color = as.factor(cluster_gt$cluster))) +
  geom_point() +
  geom_point(data = as.data.frame(cluster_gt$centers), aes(x = VIC_EDAD, y = AGR_EDAD), color = "black", size = 4, shape = 17) +
  labs(title = "Edad de la Victima vs Edad del Agresor") +
  theme_minimal()

# VIC EDAD vs TOTAL HIJOS
ggplot(df_filtrado, aes(x = VIC_EDAD, y = TOTAL_HIJOS, color = as.factor(cluster$cluster))) +
  geom_point() +
  geom_point(data = as.data.frame(cluster$centers), aes(x = VIC_EDAD, y = TOTAL_HIJOS), color = "black", size = 4, shape = 17) +
  labs(title = "Edad vs Cantidad Hijos") +
  theme_minimal()

# VIC EDAD vs TRABAJA
ggplot(df_filtrado, aes(x = VIC_TRABAJA, y = VIC_EDAD, color = as.factor(cluster$cluster))) +
  geom_point() +
  geom_point(data = as.data.frame(cluster$centers), aes(x = VIC_TRABAJA, y = VIC_EDAD), color = "black", size = 4, shape = 17) +
  labs(title = "Trabaja vs Edad") +
  theme_minimal()

