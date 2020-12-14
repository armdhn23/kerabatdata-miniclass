# Import Data
data <- read.csv('produkolahanikan.csv')

# Melihat 6 data pertama dan 6 data terakhir
head(data)
tail(data)

# select, diginakan untuk menyeleksi kolom data, 
# misal kita ingin mengetahui nama-nama provinsi dari data produk olahan ikan
library(dplyr)
Nama_Provinsi <- data %>%
  select( NamaProvinsi)
Nama_Provinsi

# funsi filter, digunakan untuk menyaring data berdasarkan kondisi tertentu
# misal kita ingin memfilter volume dari data produk olahan ikan, yang volmenya berada diatas 50000
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

# Interpretasi : 
# Setlah dilakukan visualisasi data dengan menggunakan ggplot dapat kita ketahui bahwa
# produk pengolahan ikan terbesar berada pada daerah maluku-papua dengan volume 13.745
# Produk pengolahan ikan terkecil berada pada daerah Sumatera dengan volume hanya mencapai 2.839


