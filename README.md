# Evaluación y Selección de Imágenes para Reprocesamiento
## Descripción del Código
Este script en R se utiliza para evaluar la calidad de imágenes a partir de archivos JSON que contienen puntuaciones de calidad y defectos detectados en cada imagen. A continuación se detalla el proceso llevado a cabo por el script:

Carga de Librerías: Se utilizan las librerías jsonlite, dplyr y tidyr para la manipulación de datos y lectura de archivos JSON.

Configuración de Directorios: Se especifican los directorios donde se encuentran los archivos JSON y las imágenes correspondientes.

Lectura de Archivos: Se leen todos los archivos JSON en el directorio especificado y se asocian con sus imágenes correspondientes.

Procesamiento de Datos:

Se desanidan las listas de defectos detectados.
Se limpian y transforman los nombres de los tipos de defectos.
Se reestructuran los datos para tener una columna por cada tipo de defecto con su respectiva confianza.
Se crean nuevas columnas indicando si la imagen tiene baja calidad y si presenta defectos específicos según un umbral predefinido.
Filtrado de Imágenes a Reprocesar: Se filtran las imágenes que tienen baja calidad y al menos uno de los defectos especificados (ruido, brillo, difuminado, desenfoque, oscuridad).

Salida de Datos: Se genera una tabla con las imágenes que requieren reprocesamiento y los defectos detectados en ellas.

Este script es útil para automatizar la evaluación y selección de imágenes que necesitan ser mejoradas en función de sus defectos detectados.
