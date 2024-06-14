library(jsonlite)
library(dplyr)
library(tidyr)

# Directorios
dir_json <- "ruta_al_archivo_json" # estos JSONs son el output del script "dai_final_ocr.py"
dir_img <- "ruta_a_las_imagenes"

# Definir umbral
umbral <- 0.5

# Listar archivos
imagenes <- list.files(dir_img)
jsons <- list.files(dir_json)

# Crear marco de datos
tabla_calidad <- data.frame()

# Leer y procesar archivos JSON
for (i in seq_along(jsons)) {
  data <- fromJSON(file.path(dir_json, jsons[i]))
  tabla_q <- data$pages$imageQualityScores
  tabla_q$image <- imagenes[i]
  tabla_calidad <- bind_rows(tabla_calidad, tabla_q)
}

# Desanidar y limpiar tabla
tabla_calidad <- tabla_calidad %>%
  unnest(cols = detectedDefects) %>%
  mutate(type = gsub("quality/", "", type)) %>%
  pivot_wider(names_from = type, values_from = confidence) %>%
  mutate(
    baja_calidad = qualityScore < umbral,
    defecto_ruido = defect_noisy >= umbral,
    defecto_brillo = defect_glare >= umbral,
    defecto_difuminado = defect_faint >= umbral,
    defecto_desenfoque = defect_blurry >= umbral,
    defecto_oscuro = defect_dark >= umbral
  )

# Filtrar imagenes con problemas de calidad
tabla_img_reprocesar <- tabla_calidad %>%
  filter(baja_calidad & (defecto_ruido | defecto_brillo | defecto_difuminado | defecto_desenfoque | defecto_oscuro)) %>%
  select(image, defecto_ruido, defecto_brillo, defecto_difuminado, defecto_desenfoque, defecto_oscuro)
