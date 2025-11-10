# 05 - Clustering (K-Means) + gráficas

library(dplyr)
library(ggplot2)

# Datos limpios
datos_limpios <- read.csv("C:\\Users\\rudy\\Downloads\\Personas_limpio.csv", encoding = "UTF-8")

data_fp <- datos_limpios[, c("P02A03",   # Edad de la persona
                     "P03A01",   # Sabe leer y escribir
                     "P04A01",   # Condición de actividad (trabaja / no trabaja)
                     "P02A07",   # Estado civil
                     "P05C12",   # Situación laboral o tipo de ocupación
                     "DOMINIO")] # Área geográfica (urbano/rural)

data_fp_gr <- datos_limpios[, c("P02A03",   # Edad
                        "P03A01",   # Alfabetización
                        "P03A02",   # Nivel educativo
                        "P04A01",   # Trabaja o no trabaja
                        "P05C12",   # Ocupación principal
                        "P05D01",   # Ingreso estimado
                        "DOMINIO",  # Urbano / Rural
                        "P02A12")]  # Tipo de hogar / situación familiar

# Revisando estado de los datos
lapply(data_fp, function(x) sort(unique(x)))

# Asignando valor numerico a los datos nulos
data_fp[is.na(data_fp)] = -1
data_fp_gr[is.na(data_fp_gr)] = -1

# Creando los cálculos k-Means
cluster = kmeans(data_fp, centers = 3)
cluster_gt = kmeans(data_fp_gr, centers = 3)


# estado civil vs edad de la persona
ggplot(data_fp, aes(x = P02A07, y = P02A03, color = as.factor(cluster$cluster))) +
  geom_point() +
  geom_point(data = as.data.frame(cluster$centers), aes(x = P02A07, y = P02A03), color = "black", size = 4, shape = 17) +
  labs(title = "Estado civil vs Edad de la persona") +
  theme_minimal()

