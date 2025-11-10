# Documentación Técnica

## 1. Objetivo
Implementar técnicas de minería de datos (Apriori, FP-Growth y K-Means) sobre el dataset **Personas-ENEIC-IV-2024-2.xlsx**, generando hallazgos reproducibles y propuestas basadas en evidencia.

## 2. Requisitos
- R (>= 4.0)
- Paquetes: `readxl`, `dplyr`, `arules`, `fim4r`, `ggplot2`

## 3. Preparación del ambiente
Colocar el archivo original **Personas-ENEIC-IV-2024-2.xlsx** en la raíz del proyecto.

## 4. Instrucciones de ejecución
1. Ejecutar `01_limpieza_personas.R`  
   - Limpia NAs, elimina columnas **100% NA** y columnas con **un único valor**.  
   - Genera `Personas_limpio.csv` y `Personas_limpio.rds`.
2. Ejecutar `02_exploracion_personas.R`  
   - Genera `resultados/exploracion_resumen_na.csv`.
3. Ejecutar `03_apriori_personas.R`  
   - Genera `resultados/apriori_*.csv`.
4. Ejecutar `04_fpgrowth_personas.R`  
   - Genera `resultados/fpgrowth_*.csv`.
5. Ejecutar `05_kmeans_personas.R`  
   - Genera `resultados/kmeans_asignaciones.csv` y `resultados/kmeans_plot1.png`.

## 5. Notas de replicación
- Scripts 
- Selección automática de variables según tipo y número de niveles para las reglas.
- K-Means usa todas las columnas numéricas disponibles; NAs se reemplazan por -1 (criterio del curso).

## 6. Bibliotecas utilizadas
- **readxl** para lectura de Excel.  
- **dplyr** para filtrado y manipulación simple.  
- **arules** para Apriori.  
- **fim4r** para FP-Growth.  
- **ggplot2** para gráficas simples.

## 7. Consideraciones
- Si se generan pocas/muchas reglas, ajustar `supp` y `conf`.  
- Evitar usar variables con demasiados niveles para reglas (se filtran automáticamente).

## 8. Licencia y autoría
Trabajo individual de **Rudy Eduardo Sánchez Díaz** para **Introducción a la Minería de Datos**.