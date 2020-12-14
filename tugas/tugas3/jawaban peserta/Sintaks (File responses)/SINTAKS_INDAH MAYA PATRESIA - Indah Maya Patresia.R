library(dplyr)
library(tidyverse)
library(magrittr)
my_data<-read.csv("data/produksiperlakuanikannasional.csv")
my_data
View(my_data)
summary(my_data)

my_data %>%
group_by(Wilayah )%>%
summarize(rata2_VOlume = mean(Volume)

my_data%>%
group_by(Wilayah, JenisPerlakuan)%>%
summarize(rata2_VOlume = mean(Volume))

my_data%>%
group_by(Wilayah, JenisPerairan)%>%
summarize(rata2_VOlume = mean(Volume))

my_data%>%
group_by(Wilayah, JenisPerairan)%>%
summarize(rata2_Tahun = mean(Tahun)))

my_data%>%
group_by(Wilayah, JenisPerlakuan)%>%
summarize(rata2_Tahun = mean(Tahun))

library(ggplot2)
ggplot(my_data, aes(Tahun, Volume, group = Wilayah, color = Wilayah))+
geom_line() +
geom_point()
