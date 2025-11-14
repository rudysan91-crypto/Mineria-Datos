#INSTALANDO LIBRERIAS
install.packages("arules")
install.packages("genero")
install.packages("rpart")
install.packages("rpart.plot")
                 
#UTILIZANDO LIBRERIAS               
library(genero)
library(arules)
library(rpart)
library(rpart.plot)

#CARGANDO DATASET
datos = read.csv("C:/Users/Rudy/OneDrive/Rudy/USAC/4.Trimestre/Introduccion a la mineria de datos/sesion 3/base_datos_violencia_intrafamiliar.csv", encoding = "UTF-8")
print(datos)

#EXPLORANDO VARIABLES A UTILIZAR, PARA CORROBORAR SI EXISTE MUCHA NULIDAD
table(datos$VIC_SEXO) 
# 1=HOMBRE - 2=MUJER

table(datos$VIC_TRABAJA)
# 1 =	Si trabaja por un salario o ingreso
# 2	= No trabaja por un salario o ingreso
# 9	= Ignorado


table(datos$VIC_ESCOLARIDAD)
# 10	Ninguno
# 21 a 26	Primero a sexto primaria
# 29	Primaria (grado ignorado)
# 31 a 33	Primero a tercero básico
# 39	Básico (grado ignorado)
# 44 a 46	Cuarto a sexto diversificado
# 49	Diversificado (grado ignorado)
# 51 a  57	Primer año a séptimo universitario (Incluye maestría)
# 59	Universitario (año ignorado)
# 99	Ignorado (tanto nivel como grado)
 

table(datos$HEC_ANO)
# 2000	2000 en adelante (no puede ser superior al año de denuncia)
# 9999	Ignorado año de ocurrencia del hecho


table(datos$VIC_EDAD)
# 1 a 98	Edad de la víctima
# 99	Edad ignorada de la víctima


table(datos$TOTAL_HIJOS)
# 00 a 20	Total de hijos e Hijas
# 99	Ignorado

# 1 hombre, 2 mujer
# 1 hombre, 0 mujer

data_research <- datos[, c("VIC_TRABAJA", "VIC_ESCOLARIDAD", "HEC_ANO", "VIC_EDAD", "TOTAL_HIJOS", "VIC_SEXO")]

data_research


data_research$sexo <- ifelse(data_research$VIC_SEXO == 1, 1, 0)
data.frame(1:ncol(data_research), colnames(data_research))

#CREANDO EL ARBOL CON LAS VARIABLES SELECCIONADAS
arbol <- rpart(sexo ~
                 VIC_TRABAJA +
                 VIC_ESCOLARIDAD +
                 HEC_ANO,
                 VIC_EDAD,
                 TOTAL_HIJOS,
               data = data_research, method = "class"
)

rpart.plot(arbol, type = 2, extra=0, under = TRUE, fallen.leaves = TRUE, box.palette = "BuGn",
           main="HOMBRE=1 O MUJER=0", cex = 0.5)



#PARA PREDICCIÓN
persona <- data.frame(
  VIC_TRABAJA =c(2),
  VIC_ESCOLARIDAD = c(54),
  HEC_ANO = c(2001),
  VIC_EDAD = c(19),
  TOTAL_HIJOS = (0)
)

result <- predict(arbol, persona, type = "prob")
result


