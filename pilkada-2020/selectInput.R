library(shiny)
library(shinydashboard)

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = 'Select Input'),
  dashboardSidebar(disable = T),
  dashboardBody(
    box(width = 5, title = 'Pilih Tingkat Wilayah', status = "primary", solidHeader = TRUE,
      selectizeInput(inputId = 'tingkat_wil', label = 'Tingkat Wilayah',
                     choices = list('Provinsi' = 1, 'Kabupaten' = 2))
    ),
    box(width = 3, title = 'Nilai Inputan', status = "primary", solidHeader = TRUE,
      textOutput('value_wil')
    ),
    box(width = 4, title = 'Output Inputan', status = "primary", solidHeader = TRUE,
      textOutput('text_wil')
    )
  )
)


server <- function(input, output, session) {
  
  output$value_wil <- renderText({
    input$tingkat_wil
  })
  
  output$text_wil <- renderText({
    
    show_text <- function(inputan){
      if(inputan == 1){
        print('Anda memilih wilayah Provinsi')
      } else {
        print('Anda memilih wilayah Kabupaten/Kota')
      }
    }
    
    show_text(input$tingkat_wil)
    
  })
}

shinyApp(ui, server)
