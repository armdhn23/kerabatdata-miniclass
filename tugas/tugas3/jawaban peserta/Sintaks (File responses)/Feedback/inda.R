T_6 <- read.csv('data/produksiperlakuanikannasional.csv', stringsAsFactors = T, sep = "," )

## Penulisan nama variabel tidak jelas, T_6 itu apa?
## Kode yang baik kode yang bisa dibaca org lain, bukan cuma bisa di mengerti sendiri

View(T_6)

head(data)
## jelas error, apa ada objek data?
tail(data)
## mungkin mksdmu tail(T_6) ?

## kenapa tidak liat struktur data?? apa yakin data sudah sesuai dengan formatnya?
## str(objek)

library(dplyr)
Nama_Provinsi <- T_6 %>%
  select(NamaProvinsi)
Nama_Provinsi

## Kalo langsung run untuk nama provinsi, dia bakal print 5336 rows,
## nama provinsi duplikat krn terdiri dari beberapa tahun, solusinya pke fungsi
## unique(object) supaya tiap provinsi yng unik cuma sekali di print
unique(Nama_Provinsi)

Filter_Volume <- T_6 %>% 
  filter(Volume > 50000)
Filter_Volume


## Salah satu prinsip kode yang baik yaitu KISS, keep it simple,...
## <https://dzone.com/articles/software-design-principles-dry-and-kiss>
## saya tidak dapat apa gunanya variabel Nama_Provinsi dan Filter_Volume
## sampai repot" dicari

## Penulisan nama variabel tidak konsisten, Nama_Provinsi pke huruf besar diawal
## group_data pake huruf kecil, kasih huruf kecil semua saja.


# agregrasi
library(dplyr)
group_data <- T_6 %>%
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

