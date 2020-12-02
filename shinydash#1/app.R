library(shiny)
library(shinydashboard)
library(ggplot2)
library(highcharter)
library(rgdal)     # R wrapper around GDAL/OGR
library(ggplot2)   # for general plotting
library(ggmap)    # for fortifying shapefiles
library(tidyverse)
library(DT)
library(leaflet)



ui <- dashboardPage(
  dashboardHeader(title = 'Perolehan Suara'),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Dash', tabName = 'dash', icon = icon("dashboard")),
      menuItem('Map', tabName = 'peta', icon = icon("map-marker")),
      menuItem('Table', tabName = 'table', icon = icon("th"))
    )),
  dashboardBody(
    tabItems(
      tabItem(tabName = 'dash',
              fluidRow(
                infoBoxOutput('daerah_jokowi'),
                valueBoxOutput('selisih_suara'),
                infoBoxOutput('daerah_prabowo'),
              ), #fluidrow
              fluidRow(
                box(width = 6,
                    highchartOutput('perbandingan_suara')),
                box(width = 6,
                    plotOutput('peta_daerah_capres'))
              )
      ), #tabItem
      tabItem('peta',
              box(width = 12, solidHeader = T, title = "Peta Daerah Kemenangan Capres Tahun 2014",
                  leafletOutput('peta_pemenangan_capres'))),
      tabItem('table',
              DTOutput('tabel'))
    ) #tabItems
  ) #dashboard body
) #dashboard page

server <- function(input, output) {
  
  # manipulasi data
  jokowi_prabowo <- read.csv('data/jokowi_prabowo.csv')
  mean_jokowi <- mean(jokowi_prabowo$JOKO.WIDODO...JUSUF.KALLA)
  mean_prabowo <- mean(jokowi_prabowo$PRABOWO.SUBIANTO...M..HATTA.RAJASA)
  
  daerah_jokowi <- jokowi_prabowo %>%
    arrange(desc(JOKO.WIDODO...JUSUF.KALLA))
  daerah_jokowi <- daerah_jokowi[1,c(2,3)]
  
  daerah_prabowo <- jokowi_prabowo %>%
    arrange(desc(PRABOWO.SUBIANTO...M..HATTA.RAJASA))
  daerah_prabowo <- daerah_prabowo[1,c(2,4)]
  
  data_pilpres <- read.csv('data/Hasil Pilpres 2014.csv')
  
  library(stringr) #library untuk menipulasi string
  # menghapus tanda . (titik) pada jumlah suara
  data_pilpres$jumlah_suara <- str_replace_all(data_pilpres$jumlah_suara, "[[:punct:]]", "")
  
  #mengganti tanda , (koma) menjadi tanda . (titik)
  data_pilpres$presentase <- str_replace_all(data_pilpres$presentase, ",", ".")
  
  #menghapus tanda % (persen)
  data_pilpres$presentase <- str_replace_all(data_pilpres$presentase, "%", "")
  
  #mengubah tipe data
  data_pilpres$jumlah_suara <- as.numeric(data_pilpres$jumlah_suara)
  data_pilpres$presentase <- as.numeric(data_pilpres$presentase)
  data_pilpres$pasangan <- as.factor(data_pilpres$pasangan)
  data_pilpres$nama <- as.factor(data_pilpres$nama)
  
  
  ### Peta
  indonesia <- readOGR('data/indonesia_provinces_ClipToShore_simplified.geojson')
  jokowi_prabowo <- read.csv('data/jokowi_prabowo.csv')
  
  indonesia@data<-inner_join(indonesia@data, jokowi_prabowo, by='kode')
  
  output$daerah_jokowi <- renderInfoBox({
    infoBox(
      paste('Jokowi-JK', daerah_jokowi[1]), 
      paste('Total Suara',daerah_jokowi[2],'%'), icon = icon("list")
    )
  })
  
  output$daerah_prabowo <- renderInfoBox({
    infoBox(
      paste('Prabowo-Hatta', daerah_prabowo[1]), 
      paste('Total Suara',daerah_prabowo[2], '%'), icon = icon("list")
    )
  })
  
  output$selisih_suara <- renderValueBox({
    valueBox(paste(round(abs(mean_jokowi-mean_prabowo),2), '%'), 'Selisih Suara',
             icon = icon("user"))
  })
  
  output$perbandingan_suara <- renderHighchart({
    # Change barplot fill colors by groups
    hc <- data_pilpres %>% 
      arrange(desc(jumlah_suara)) %>%
      hchart(
        'column', hcaes(x = nama, y = jumlah_suara,group = pasangan)
      )
    hc %>% hc_title(
      text = "Perbandingan Suara Capres 2014 <br> Per Provinsi"
    )
  })
  
  output$peta_daerah_capres <- renderPlot({
  
        indonesia@data$PEMENANG <- as.factor(indonesia@data$PEMENANG)
    
    spplot(indonesia, "PEMENANG", main = 'Peta Daerah Pemenangan \n Cawapres 2014',
           colorkey = list(space = "bottom", height = 1.05))
    
    
    
  })
  
  
  output$tabel <- renderDataTable({
    jokowi_prabowo <- read.csv('data/jokowi_prabowo.csv')
    data_tabel <- jokowi_prabowo[c(3,6,7)]
    colnames(data_tabel) <- c('Provinsi', 'Pemenang', 'Suara')
    datatable(data_tabel,
              options = list(scrollX = TRUE))
  })
  
  output$peta_pemenangan_capres <- renderLeaflet({
    
    labels <- sprintf("Provinsi: %s  <br/> Pemenang: %s <br/> Total suara: %g persen",
                      indonesia@data$provinsi, indonesia@data$PEMENANG, indonesia@data$Suara_menang
    ) %>% 
      lapply(htmltools::HTML)
    
    
    
    pal <- colorFactor(c("blue", "red", "orange"), domain = indonesia@data$PEMENANG)
    
    m <- leaflet(indonesia) %>%
      addTiles() %>%
      addPolygons()
    
    m <- m %>% addPolygons(
      fillColor = ~pal(PEMENANG),
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
    
    m <- m %>%
      addLegend("bottomright", pal = pal, values = ~indonesia@data$PEMENANG,
                title = "Pemenang",
                opacity = 1)
    m
    
    
  })
  
}

shinyApp(ui, server)
