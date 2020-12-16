## app.R ##
library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(dplyr)
library(leaflet)

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
          box(
            selectizeInput(inputId = 'tingkat_wil', label = 'Tingkat Wilayah',
                           choices = list('Provinsi' = 1, 'Kabupaten' = 2))
          )
        ),
        fluidRow(
          box(
            width = 12,
          )
        ),
        fluidRow(
          box(width  = 4,
              plotlyOutput('pie_1')),
          box(width = 4),
          box(width = 4)
        ),
        fluidRow(
          box(width = 4),
          box(width = 4),
          box(width = 4)
        )
      ),
      tabItem(
        tabName = "tabel",
        print("Ini adalah Tabel")
      )
    )
  )
)

server <- function(input, output) {
  
  kabkota <- read.csv("data/pilkada_kabkota.csv")
  provinsi <- read.csv('data/pilkada_provinsi.csv')
  
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
  
  output$pie_1 <- renderPlotly({
    
    if(input$tingkat_wil == 1){
      data_pie1 <- provinsi %>%
        filter(provinsi == 'Sumatera Barat')
    } else{
      data_pie1 <- kabkota %>%
        filter(kab_kota == 'Tojo Una-una')
    }
    
    pie_plotly(data_pie1)
  })
  
  
}

shinyApp(ui, server)
