## app.R ##
library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(dplyr)
library(leaflet)
library(rgdal)

ui <- dashboardPage(
  dashboardHeader(title = "Pilkada 2020"),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Dashboard', tabName = 'dashboard', icon = icon("dashboard")),
      menuItem('Tabel', tabName = 'tabel', icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "dashboard",
        fluidRow(
          box(selectInput('tingkat_wil', label = 'Tingkat Wilayah',
                          choices = list('Provinsi' = 1, 'Kabupaten' = 2), selected = 2,
            )
          )
        ),
        fluidRow(
          box(
            width = 12,
            leafletOutput('peta')
          )
        ),
        fluidRow(
          box(width = 4,
              plotlyOutput('pie_1')),
          box(width = 4,
              plotlyOutput('pie_2')),
          box(width = 4,
              plotlyOutput('pie_3'))
        ),
        fluidRow(
          box(width = 4,
              plotlyOutput('pie_4')),
          box(width = 4,
              plotlyOutput('pie_5')),
          box(width = 4,
              plotlyOutput('pie_6'))
        )
      ),
      tabItem(
        tabName = "tabel",
        selectInput('tingkat_wil_tabel', label = 'Tingkat Wilayah',
                    choices = list('Provinsi' = 1, 'Kabupaten' = 2), selected = 2,
        ),
        dataTableOutput('tabel_data')
      )
    )
  )
)

server <- function(input, output) {
  
  peta_idn <- readOGR('data/indonesia_provinces_ClipToShore_simplified.geojson')
  pilkada_prov <- read.csv('data/provinsi.csv')
  
  peta_idn@data<-inner_join(peta_idn@data, pilkada_prov, by='provinsi')
  peta_idn@data$provinsi <- factor(peta_idn@data$provinsi)
  peta_idn@data$melaksanakan_pilkada <- factor(peta_idn@data$melaksanakan_pilkada,
                                               levels = c("Ya", "Tidak"))
  
  pie_plotly <- function(data){
    judul <- data[1,4]
    plot_ly(data, type='pie', labels=~paslon, values=~total_suara,
            hoverinfo = 'text',
            text = ~paste0(paslon, '\n',
                           'Total Suara: ', total_suara, '\n',
                           'Persentase Suara: ', round(persentase_suara,2), '%'),
            textinfo='percent', showlegend = FALSE) %>% 
      layout(title = judul, font='Raleway')
  }
  
  output$peta <- renderLeaflet({
    if(input$tingkat_wil == 1){
      # Peta Prov
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
      m <- m %>%
        addLegend("bottomright", pal = pal, values = ~peta_idn@data$melaksanakan_pilkada,
                  title = "Melaksanakan Pilkada",
                  opacity = 1)
      m
    } else{
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
    }
    
  })
  
  # bengkulu dan balut
  output$pie_1 <- renderPlotly({
    if(input$tingkat_wil == 1){
      data_pie1 <- read.csv('data/pilkada_provinsi.csv')
      data_pie1 <- data_pie1 %>%
        filter(provinsi == 'Bengkulu')
    } else{
      data_pie1 <- read.csv('data/pilkada_kabkota.csv')
      data_pie1 <- data_pie1 %>%
        filter(kab_kota == 'Banggai Laut')
    }
    
    pie_plotly(data_pie1)
  })
  
  # jambi dan banggai
  output$pie_2 <- renderPlotly({
    if(input$tingkat_wil == 1){
      data_pie2 <- read.csv('data/pilkada_provinsi.csv')
      data_pie2 <- data_pie2 %>%
        filter(provinsi == 'Jambi')
    } else{
      data_pie2 <- read.csv('data/pilkada_kabkota.csv')
      data_pie2 <- data_pie2 %>%
        filter(kab_kota == 'Banggai')
    }
    pie_plotly(data_pie2)
  })
    
  # kalut dan poso
  output$pie_3 <- renderPlotly({
    if(input$tingkat_wil == 1){
      data_pie3 <- read.csv('data/pilkada_provinsi.csv')
      data_pie3 <- data_pie3 %>%
        filter(provinsi == 'Kalimantan Utara')
    } else{
      data_pie3 <- read.csv('data/pilkada_kabkota.csv')
      data_pie3 <- data_pie3 %>%
        filter(kab_kota == 'Poso')
    }
    
    pie_plotly(data_pie3)
  })
    
    # sulteng dan sigi
  output$pie_4 <- renderPlotly({
    if(input$tingkat_wil == 1){
      data_pie4 <- read.csv('data/pilkada_provinsi.csv')
      data_pie4 <- data_pie4 %>%
        filter(provinsi == 'Sulawesi Tengah')
    } else{
      data_pie4 <- read.csv('data/pilkada_kabkota.csv')
      data_pie4 <- data_pie4 %>%
        filter(kab_kota == 'Sigi')
    }
    
    pie_plotly(data_pie4)
  })
    
    # sulut dan toli-toli
    output$pie_5 <- renderPlotly({
      if(input$tingkat_wil == 1){
        data_pie5 <- read.csv('data/pilkada_provinsi.csv')
        data_pie5 <- data_pie5 %>%
          filter(provinsi == 'Sulawesi Utara')
      } else{
        data_pie5 <- read.csv('data/pilkada_kabkota.csv')
        data_pie5 <- data_pie5 %>%
          filter(kab_kota == 'Toli-toli')
      }
      
      pie_plotly(data_pie5)
    })
    
    # sumbar dan touna
    output$pie_6 <- renderPlotly({
      if(input$tingkat_wil == 1){
        data_pie6 <- read.csv('data/pilkada_provinsi.csv')
        data_pie6 <- data_pie6 %>%
          filter(provinsi == 'Sumatera Barat')
      } else{
        data_pie6 <- read.csv('data/pilkada_kabkota.csv')
        data_pie6 <- data_pie6 %>%
          filter(kab_kota == 'Tojo Una-una')
      }
      
      pie_plotly(data_pie6)
    })
    
    output$tabel_data <- renderDataTable({
      
      if(input$tingkat_wil_tabel == 1){
        data_tabel <- read.csv('data/pilkada_provinsi.csv')
      } else {
        data_tabel <- read.csv('data/pilkada_kabkota.csv')
      }
      
      datatable(data_tabel, filter = 'top',
                options = list(scrollX = TRUE))
    })
    
}

shinyApp(ui, server)
