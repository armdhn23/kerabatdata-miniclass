library(dplyr)
library(tidyverse)
## kalo sudah load tidyverse, tidak usah lagi load dplyr dan ggplot2 krn sudah sepaket

produksiperlakuanikannasional_csv <- read.csv("data/produksiperlakuanikannasional.csv")

data_rekap<-produksiperlakuanikannasional_csv%>%
  group_by(Wilayah,JenisPerairan)%>%
  summarise(rata_rata_volume=mean(Volume))

## sudah pasti error
## object 'produksiperlakuanikannasional_csv' not found
## datanya di import dulu dek
## saya tambahkan sintaks import data di atas, silahkan sesuaikan path nya

library(ggplot2)
ggplot(data=data_rekap)+
  geom_col(mapping = aes(data_rekap$Wilayah,data_rekap$rata_rata_volume,fill=data_rekap$JenisPerairan))+
  coord_flip()+
  ggtitle('data produksi perlakuan ikan nasional')

## menarik karena beda sendiri pke geom_col dan pke fungsi coord_flip()
## dan ggtitle

## penulisan sintaksnya masih kurang efektif
## kalo sudah didefinisikan ggplot(data=data_rekap)
## tidak perlu lagi pke tanda $, data_rekap$Wilayah
## bisa langsung Wilayah

ggplot(data=data_rekap)+
  geom_col(mapping = aes(Wilayah,rata_rata_volume,fill=JenisPerairan))+
  coord_flip()+
  ggtitle('data produksi perlakuan ikan nasional')

## Supaya grafiknya lebih bagus lagi bisa tambahkan xlab, ylab
## Bisa juga ganti theme atau kostum warna
## Kalo grafiknya horizontal, lebih rapi kalo di urutkan dari terbesar ke terkecil

ggplot(data=data_rekap)+
  geom_col(mapping = aes(reorder(Wilayah,rata_rata_volume),rata_rata_volume,fill=JenisPerairan))+
  coord_flip()+
  scale_fill_brewer(palette="Oranges") + # costum warna lain, Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd
  ggtitle('Data Produksi Perlakuan Ikan Nasional') + 
  xlab(label = "Wilayah") +
  ylab(label = "Rata-rata Volume") +
  theme_classic()

## semangat ^^