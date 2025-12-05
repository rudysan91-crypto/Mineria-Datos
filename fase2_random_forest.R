#carga de librerias
library(readxl)

# cargar dataset
datos <-  read_excel("C:\\Users\\rudy\\Downloads\\Personas-ENEIC-IV-2024-2.xlsx")
print(datos)

# limpiar nombres para evitar errores
names(datos) <- make.names(names(datos))

# seleccionar columnas correctas
datar <- datos[, c("FORMAL_INFORMAL", "P02A02", "P02A03", "P02A08", "DOMINIO","P03A01")]

install.packages("randomForest")
library(randomForest)

#se convierte a factor la variable
datar$FORMAL_INFORMAL <- as.factor(datar$FORMAL_INFORMAL)

#limpiando dataset, se omite todo lo que está vacío
datar <- na.omit(datar)

#definir el tema aleaotorio
set.seed(42)

#revolver la informacion
datar <- datar[sample(1:nrow(datar)),]

#definir cuanto sera para testeo y cuanto para entreno
index <- sample(1:nrow(datar), 0.8*nrow(datar))

train <- datar[index,]
test <- datar[-index,]

#bosque aleaotorio
bosque <- randomForest(FORMAL_INFORMAL ~ P02A02 + P02A03 + P02A08 + DOMINIO + P03A01,
                       data = train,
                       ntree = 200,
                       mtry = 3
)

prueba <- predict(bosque, test)
prueba

matriz <- table(test$FORMAL_INFORMAL, prueba)

#precisión del modelo
pre <- sum(diag(matriz))/sum(matriz)
pre

#PREDICCION 1
#MUJER DE 25 AÑOS, LADINA, UBICADA EN LA URBE METROPOLITANA, QUE NO SABE LEER NI ESCRIBIR
persona1 <- data.frame(
  P02A02 = c(2),
  P02A03 = c(25),
  P02A08 = c(3),
  DOMINIO = c(1),
  P03A01 = c(2)
)

result1 <- predict(bosque,persona1,type="prob")
result1

plot(bosque)

#PREDICCION 2
#MUJER DE 70 AÑOS, LADINA, UBICADA EN LA URBE METROPOLITANA, QUE SABE LEER NI ESCRIBIR
persona2 <- data.frame(
  P02A02 = c(2),
  P02A03 = c(70),
  P02A08 = c(3),
  DOMINIO = c(1),
  P03A01 = c(1)
)

result2 <- predict(bosque,persona2,type="prob")
result2

plot(bosque)


#PREDICCION 3
#HOMBRE DE 17 AÑOS, XINKA, UBICADA EN EL AREA RURAL, QUE NO SABE LEER NI ESCRIBIR
persona3 <- data.frame(
  P02A02 = c(1),
  P02A03 = c(17),
  P02A08 = c(1),
  DOMINIO = c(3),
  P03A01 = c(2)
)

result3 <- predict(bosque,persona3,type="prob")
result3

plot(bosque)






