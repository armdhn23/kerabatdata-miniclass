library(leaflet)
library(rgdal)

# Peta Prov
peta_idn <- readOGR('data/indonesia_provinces_ClipToShore_simplified.geojson')
pilkada_prov <- read.csv('data/provinsi.csv')

peta_idn@data<-inner_join(peta_idn@data, pilkada_prov, by='provinsi')
peta_idn@data$provinsi <- factor(peta_idn@data$provinsi)
peta_idn@data$melaksanakan_pilkada <- factor(peta_idn@data$melaksanakan_pilkada,
                                                levels = c("Ya", "Tidak"))

labels <- sprintf("Provinsi: %s <br/> Melaksanakan Pilkada: %s",
                  peta_idn@data$provinsi,
                  peta_idn@data$melaksanakan_pilkada
) %>% 
  lapply(htmltools::HTML)


labels
pal <- colorFactor(c("red", "white"), domain = peta_idn@data$melaksanakan_pilkada)
pal
m <- leaflet(peta_idn) %>%
  addTiles() %>%
  addPolygons()

m <- m %>% addPolygons(
  fillColor = ~pal(peta_idn@data$melaksanakan_pilkada),
  weight = 2,
  opacity = 1,
  color = "white",
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = labels,
  labelOptions = labelOptions(
    style = list("font-weight" = "normal", padding = "3px 8px"),
    textsize = "15px",
    direction = "auto"))
m
m <- m %>%
  addLegend("bottomright", pal = pal, values = ~peta_idn@data$melaksanakan_pilkada,
            title = "Melaksanakan Pilkada",
            opacity = 1)
m

## Peta kab kota
kabkota <- read.csv('data/kabkota.csv', stringsAsFactors = T)

labels_kabkota <- sprintf("Kabupaten/Kota: %s",
                          kabkota$kab_kota
) %>% 
  lapply(htmltools::HTML)

leaflet(kabkota) %>%
  addTiles() %>%
  addAwesomeMarkers (lng = ~longitude,
                     lat = ~latitude,
                     label = labels_kabkota)
