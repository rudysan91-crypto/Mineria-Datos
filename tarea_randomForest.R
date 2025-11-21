#carga de librerias
library(readxl)

# se carga el data set
datos <- read.csv("C:/Users/Rudy/OneDrive/Rudy/USAC/4.Trimestre/Introduccion a la mineria de datos/sesion 3/base_datos_violencia_intrafamiliar.csv", encoding = "UTF-8")
datar <- datos[,c("AGR_SEXO","HEC_AREA","AGR_EDAD","AGR_ALFAB","AGR_ESCOLARIDAD","AGR_EST_CIV","AGR_NACIONAL","AGR_TRABAJA") ]

install.packages("randomForest")
library(randomForest)

#se convierte a factor la variable
datar$HEC_AREA <- as.factor(datar$HEC_AREA)

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
bosque <- randomForest(HEC_AREA ~
                         AGR_SEXO +
                         AGR_EDAD +
                         AGR_ALFAB +
                         AGR_ESCOLARIDAD +
                         AGR_EST_CIV +
                         AGR_NACIONAL +
                         AGR_TRABAJA,
                       data = train,
                       ntree = 200,
                       mtry = 3
)

prueba <- predict(bosque, test)
prueba

matriz <- table(test$HEC_AREA, prueba)

#precisión del modelo
pre <- sum(diag(matriz))/sum(matriz)
pre

persona <- data.frame(
  AGR_SEXO = c(2),
    AGR_EDAD = c(40),
    AGR_ALFAB = c(1),
    AGR_ESCOLARIDAD = c(55),
    AGR_EST_CIV = c(2),
    AGR_NACIONAL = c(1),
    AGR_TRABAJA = c(1)
)

result2 <- predict(bosque,persona,type="prob")
result2

plot(bosque)
