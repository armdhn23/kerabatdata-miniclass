library(plotly)
library(dplyr)

kabkota <- read.csv("data/pilkada_kabkota.csv")
poso <- kabkota %>%
  filter(kab_kota == 'Poso')

touna <- kabkota %>%
  filter(kab_kota == 'Tojo Una-una')

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

pie_plotly(poso)

pie_plotly(touna)

provinsi <- read.csv('data/pilkada_provinsi.csv')
