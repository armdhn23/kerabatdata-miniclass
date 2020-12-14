# Import Data
data <- read.csv('D:/produksibudidayanasional.csv')

# Melihat 6 data pertama dan 6 data terakhir
head(data)
tail(data)

## kenapa tidak liat struktur data??
## str(objek)

# select, diginakan untuk menyeleksi kolom data, 
# misal kita ingin mengetahui nama-nama provinsi dari data produk olahan ikan
library(dplyr)
Nama_Provinsi <- data %>%
  select( NamaProvinsi)
Nama_Provinsi

## Kalo langsung run untuk nama provinsi, dia bakal print 5336 rows,
## nama provinsi duplikat krn terdiri dari beberapa tahun, solusinya pke fungsi
## unique(object) supaya tiap provinsi yng unik cuma sekali di print
unique(Nama_Provinsi)

# funsi filter, digunakan untuk menyaring data berdasarkan kondisi tertentu
# misal kita ingin memfilter volume dari data produk olahan ikan, yang volmenya berada diatas 50000
Filter_Volume <- data %>% 
  filter(Volume > 50000)
Filter_Volume


## Salah satu prinsip kode yang baik yaitu KISS, keep it simple,...
## <https://dzone.com/articles/software-design-principles-dry-and-kiss>
## saya tidak dapat apa gunanya variabel Nama_Provinsi dan Filter_Volume

## Penulisan nama variabel tidak konsisten, Nama_Provinsi pke huruf besar diawal
## group_data pake huruf kecil, kasih huruf kecil semua saja.



# agregrasi
library(dplyr)
group_data <- data %>%
  group_by(Tahun)%>%
  summarise(rata_rata_volume = mean(Volume))
group_data

# Visualisasi data
library(ggplot2)
ggplot(group_data, aes(Tahun, rata_rata_volume, fill=Tahun)) +
  geom_bar(stat = 'identity')

## Supaya grafiknya lebih bagus lagi bisa tambahkan judul, xlab, ylab
## Bisa juga ganti theme atau kostum warna

ggplot(group_data, aes(Wilayah, rata_rata_volume, fill=Wilayah)) +
  geom_bar(stat = 'identity') +
  scale_fill_brewer(palette="BuPu") + # costum warna lain, Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd
  theme_minimal() # costum theme, masih banyak tema yg lain
