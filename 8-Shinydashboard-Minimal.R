## app.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Latihan Shiny"),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Menu 1', tabName = 'menu1', icon = icon("bookmark")),
      menuItem('Menu 2', tabName = 'menu2', icon = icon("chart-area"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "menu1",
        fluidRow(
          box(),
          box()
        ),
        fluidRow(
          box(width = 12,
              plotlyOutput("bar_plotly")
              )
        ),
        fluidRow(
          box(width  = 4,),
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
        tabName = "menu2",
        print("Ini adalah menu 2")
      )
    )
  )
)

server <- function(input, output) {
  output$bar_plotly <-  renderPlotly({
    library(plotly)
    fig <- plot_ly(x = ~rnorm(50),
                   type = "histogram",
                   histnorm = "probability")
    
    fig
  })
}

shinyApp(ui, server)
