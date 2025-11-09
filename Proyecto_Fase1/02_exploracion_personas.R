
# 02 - Exploración descriptiva


library(dplyr)

# Cargar datos limpios
datos_limpios <- read.csv("C:\\Users\\rudy\\Downloads\\Personas_limpio.csv", encoding = "UTF-8")

# Dimensiones y tipos
dim(datos_limpios)
str(datos_limpios)

# Conteo de NAs por columna
na_por_col <- colSums(is.na(datos_limpios))
na_por_col

# Porcentaje de NAs
porc_na <- round(na_por_col / nrow(datos_limpios) * 100, 2)
porc_na

# Frecuencias básicas para variables con pocos valores únicos (<= 20)
tablas <- lapply(datos_limpios, function(col) {
  u <- unique(col)
  if (length(u) <= 20) {
    sort(table(col), decreasing = TRUE)
  } else {
    NULL
  }
})

# Imprimir solo las que aplican
for (nm in names(tablas)) {
  if (!is.null(tablas[[nm]])) {
    cat("\n--- Frecuencias de", nm, "---\n")
    print(tablas[[nm]])
  }
}
