
# 01 - Limpieza de datos (NAs + columnas constantes)


# Librerías
library(readxl)
library(dplyr)

# Carga de datos
datos <-  read_excel("C:\\Users\\rudy\\Downloads\\Personas-ENEIC-IV-2024-2.xlsx")

# Vista general
dim(datos)      # filas y columnas
str(datos)      # tipos
head(datos, 3)  # primeras filas


# 1) Eliminar columnas 100% NA
na_por_col <- colSums(is.na(datos))
cols_100_na <- names(na_por_col[na_por_col == nrow(datos)])
if (length(cols_100_na) > 0) {
  cat("Eliminando columnas 100% NA:\n")
  print(cols_100_na)
  datos <- datos[, !(colnames(datos) %in% cols_100_na)]
}
print(datos)

# 2) Eliminar columnas con un único valor
es_constante <- sapply(datos, function(x) length(unique(x[!is.na(x)])) == 1)
if (any(es_constante)) {
  cols_const <- names(es_constante[es_constante])
  cat("Eliminando columnas con un único valor:\n")
  print(cols_const)
  datos <- datos[, !(colnames(datos) %in% cols_const)]
}
print(datos)

# 3) Normalización suave para texto (trim y NAs comunes)
es_char <- sapply(datos, is.character)
if (any(es_char)) {
  datos[es_char] <- lapply(datos[es_char], trimws)
  a_na <- function(x) { x[x %in% c("", "NA", "N/A", "n/a", "NaN", "NULL", "Null", "null")] <- NA; x }
  datos[es_char] <- lapply(datos[es_char], a_na)
}
print(datos)

# Reporte de NAs después de limpieza
cat("\nResumen de NAs por columna (post-limpieza):\n")
print(colSums(is.na(datos)))

# Guardar salidas para siguientes scripts
write.csv(datos, "Personas_limpio.csv", row.names = FALSE, fileEncoding = "UTF-8")
saveRDS(datos, "Personas_limpio.rds")
cat("\nListo: guardado Personas_limpio.csv y Personas_limpio.rds\n")

getwd()

