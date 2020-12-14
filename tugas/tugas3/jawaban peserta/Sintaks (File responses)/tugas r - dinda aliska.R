library(dplyr)
library(tidyverse)
data_rekap<-produksiperlakuanikannasional_csv%>%
  group_by(Wilayah,JenisPerairan)%>%
  summarise(rata_rata_volume=mean(Volume))
library(ggplot2)
ggplot(data=data_rekap)+
  geom_col(mapping = aes(data_rekap$Wilayah,data_rekap$rata_rata_volume,fill=data_rekap$JenisPerairan))+
  coord_flip()+
  ggtitle('data produksi perlakuan ikan nasional')
