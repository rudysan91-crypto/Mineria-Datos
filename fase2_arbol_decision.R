#INSTALANDO LIBRERIAS
install.packages("arules")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("readxl")


#UTILIZANDO LIBRERIAS               
library(arules)
library(rpart)
library(rpart.plot)
library(readxl)


#CARGANDO DATASET
datos <-  read_excel("C:\\Users\\rudy\\Downloads\\Personas-ENEIC-IV-2024-2.xlsx")
print(datos)

#EXPLORANDO VARIABLES A UTILIZAR, PARA CORROBORAR SI EXISTE MUCHA NULIDAD
table(datos$P02A02) 
# sexo - 1=HOMBRE - 2=MUJER

table(datos$P02A03)
# edad

table(datos$P02A08)
# grupo etnico
# 1	Xinka
# 2	Garífuna?
# 3	Ladina(o)?
# 4	Afrodescendiente/Creole/ Afromestizo?
# 5	Extranjera(o)?
# 6	Maya?
  
table(datos$DOMINIO)
# UBICACION GEOGRAFICA
# 1	Urbano Metropolitano
# 2	Resto Urbano
# 3	Rural Nacional

table(datos$FORMAL_INFORMAL)
# UBICACION GEOGRAFICA


data_research <- datos[, c("FORMAL_INFORMAL", "P02A02", "P02A03", "P02A08", "DOMINIO")]

data_research

data_research$FORMAL_INFORMAL <- ifelse(data_research$FORMAL_INFORMAL == 2, 1, 0)
data.frame(1:ncol(data_research), colnames(data_research)) 

data_research <- data_research[!is.na(data_research$FORMAL_INFORMAL), ]

#CREANDO EL ARBOL CON LAS VARIABLES SELECCIONADAS
arbol <- rpart(FORMAL_INFORMAL ~ P02A02 + P02A03 + P02A08 + DOMINIO,
               data = data_research, method = "class"
)

rpart.plot(arbol, type = 2, extra=0, under = TRUE, fallen.leaves = TRUE, box.palette = "BuGn",
           main="FORMAL=1 O INFORMAL=0", cex = 0.5)



#PARA PREDICCIÓN ESCENARIO 1
#HOMBRE, DE 40 AÑOS, LADINO, UBICADO EN EL AREA URBANO METROPOLITANO
persona <- data.frame(
  P02A02 =c(1),
  P02A03 = c(40),
  P02A08 = c(3),
  DOMINIO = c(1)
)

result <- predict(arbol, persona, type = "prob")
result

#PARA PREDICCIÓN ESCENARIO 2
#MUJER, DE 18 AÑOS, MAYA, UBICADO EN EL AREA URBANO METROPOLITANO
persona2 <- data.frame(
  P02A02 =c(2),
  P02A03 = c(18),
  P02A08 = c(6),
  DOMINIO = c(1)
)

result2 <- predict(arbol, persona2, type = "prob")
result2

#PARA PREDICCIÓN ESCENARIO 3
#MUJER, DE 50 AÑOS, EXTRANJERO, UBICADO EN EL AREA URBANO METROPOLITANO
persona3 <- data.frame(
  P02A02 =c(2),
  P02A03 = c(50),
  P02A08 = c(5),
  DOMINIO = c(1)
)

result3 <- predict(arbol, persona, type = "prob")
result3

#PARA PREDICCIÓN ESCENARIO 4
#HOMBRE, DE 60 AÑOS, LADINO, UBICADO EN EL AREA RURAL
persona4 <- data.frame(
  P02A02 =c(1),
  P02A03 = c(60),
  P02A08 = c(3),
  DOMINIO = c(3)
)

result4 <- predict(arbol, persona, type = "prob")
result4

