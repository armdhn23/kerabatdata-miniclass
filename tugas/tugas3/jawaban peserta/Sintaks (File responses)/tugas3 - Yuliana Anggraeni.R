# Import Data
data <- read.csv('produkolahanikan.csv')
View(data)

# Melihat 6 data pertama dan 6 data terakhir
head(data)
tail(data)

# select
library(dplyr)
Nama_Provinsi <- data %>%
  select( NamaProvinsi)
Nama_Provinsi

# filter
Filter_Volume <- data %>% 
  filter(Volume > 50000)
Filter_Volume

# agregrasi
library(dplyr)
group_data <- data %>%
  group_by(Wilayah)%>%
  summarise(rata_rata_volume = mean(Volume))
group_data

# Visualisasi data
library(ggplot2)
ggplot(group_data, aes(Wilayah, rata_rata_volume, fill=Wilayah)) +
  geom_bar(stat = 'identity')