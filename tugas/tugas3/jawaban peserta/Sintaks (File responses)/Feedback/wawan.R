T_3 <- read.csv('data/produkolahanikan.csv', stringsAsFactors = T)
View(T_3)

library(dplyr)
group_data <- T_3 %>%
  group_by(Wilayah)%>%
  summarise(rata_rata_volume = mean(Volume))
group_data

library(ggplot2)
ggplot(group_data, aes(Wilayah, rata_rata_volume, fill=Wilayah)) +
  geom_bar(stat = 'identity')

## Supaya grafiknya lebih bagus lagi bisa tambahkan judul, xlab, ylab
## Bisa juga ganti theme atau kostum warna

ggplot(group_data, aes(Wilayah, rata_rata_volume, fill=Wilayah)) +
  geom_bar(stat = 'identity') +
  scale_fill_brewer(palette="Set1") + # costum warna lain, Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd
  theme_minimal() # costum theme, masih banyak tema yg lain

## penamaan variabel harus jelas, supaya orang lain yang mau baca kodemu,
## mudah mengerti
## nama variabel T_3 itu tidak jelas.
## keep learning