# Import Data
data <- read.csv('data/produkolahanikan.csv')
View(data)

# Melihat 6 data pertama dan 6 data terakhir
head(data)
tail(data)

## melihat struktur data juga sangat penting
## str(objek)

# select
library(dplyr)
Nama_Provinsi <- data %>%
  select( NamaProvinsi)
Nama_Provinsi

# filter
Filter_Volume <- data %>% 
  filter(Volume > 50000)
Filter_Volume

## Salah satu prinsip kode yang baik yaitu KISS, keep it simple 
## <https://dzone.com/articles/software-design-principles-dry-and-kiss>
## saya tidak dapat apa gunanya variabel Nama_Provinsi dan Filter_Volume

## Penulisan nama variabel harus konsisten, Nama_Provinsi pke huruf besar diawal
## group_data pake huruf kecil, kasih huruf kecil semua saja.

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

## Supaya grafiknya lebih bagus lagi bisa tambahkan judul, xlab, ylab
## Bisa juga ganti theme atau kostum warna

ggplot(group_data, aes(Wilayah, rata_rata_volume, fill=Wilayah)) +
  geom_bar(stat = 'identity') +
  scale_fill_brewer(palette="BuPu") + # costum warna lain, Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd
  theme_minimal() # costum theme, masih banyak tema yg lain
