library(dplyr)
library(tidyverse)
## kalo sudah load tidyverse, tidak usah lagi load dplyr dan ggplot2 krn sudah sepaket


library(magrittr) ## untuk apa ini?
my_data<-read.csv("data/produksiperlakuanikannasional.csv")
my_data
##saran liat 6 data awal atau akhir saja dibanding liat semua
## penamaan datanya juga abstrak, my_data itu tidak menggambarkan datanya spt apa

View(my_data)
summary(my_data)

my_data %>%
  group_by(Wilayah)%>%
  summarize(rata2_VOlume = mean(Volume))
## sintaks diatas kurang )
## makanya kebawah ngikut error
## fokus dek, tanda ) sudah sy tmbhkan



my_data%>%
  group_by(Wilayah, JenisPerlakuan)%>%
  summarize(rata2_VOlume = mean(Volume))

my_data%>%
  group_by(Wilayah, JenisPerairan)%>%
  summarize(rata2_VOlume = mean(Volume))

my_data%>%
  group_by(Wilayah, JenisPerairan)%>%
  summarize(rata2_Tahun = mean(Tahun))
## lebih satu tanda )
## fokus ki dek, sudah saya perbaiki


## variabel Tahun tidak tepat jika dirata"kan dek, 
## hasilnya pun tidak terdapat informasi


my_data%>%
  group_by(Wilayah, JenisPerlakuan)%>%
  summarize(rata2_Tahun = mean(Tahun))

## saya bingung baca kodenya, kenapa berulang" ditulis sintaks bgtu?
## saya juga heran kenapa tidak disimpan ke dlm variabel atau objek?
## salah satu prinsip kode yg baik adalah KISS, keep it simple!

library(ggplot2)
ggplot(my_data, aes(Tahun, Volume, group = Wilayah, color = Wilayah))+
  geom_line() +
  geom_point()
## karena hasil aggregasi data tidak disimpan ke dlm variabel baru
## malah pke data asli,
## sudah jelas grafiknya berantakan

## karena mau bikin line chart, mungkin tujuannya mau bikin bgni
## tapi masih bingung sintaksnya bgmna
## saya coba buat

library(tidyverse)

perlakuan_ikan<-read.csv("data/produksiperlakuanikannasional.csv", stringsAsFactors = T)
## nanti sesuaikan path nya

str(perlakuan_ikan)
## Var tahun tipenya integer, harus di ubah dulu jadi factor
View(perlakuan_ikan)

#aggregasi data
perlakuan_ikan_aggregat <- perlakuan_ikan%>%
  filter(JenisPerlakuan != "semua") %>%
  group_by(JenisPerlakuan, Tahun)%>%
  summarize(rata_volume = mean(Volume))

View(perlakuan_ikan_aggregat)
glimpse(perlakuan_ikan_aggregat)

#membuat grafik
line_perlakuan_ikan <- 
  ggplot(perlakuan_ikan_aggregat, 
         aes(factor(Tahun), rata_volume, group = JenisPerlakuan, color=JenisPerlakuan))+
  geom_line() +
  geom_point() + 
  theme_classic()

## tambahkan judul, xlab dan ylab

line_perlakuan_ikan +
  labs(title="Grafik Garis Perlakuan Ikan Nasional") +
  xlab("Tahun") + ylab("Rata-rata Volume")

## semangat ^^

