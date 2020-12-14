T_3 <- read.csv('KBR/tugas/tugas3/data/produkolahanikan.csv', stringsAsFactors = T)
View(T_3)

library(dplyr)
group_data <- T_3 %>%
  group_by(Wilayah)%>%
  summarise(rata_rata_volume = mean(Volume))
group_data

library(ggplot2)
ggplot(group_data, aes(Wilayah, rata_rata_volume, fill=Wilayah)) +
  geom_bar(stat = 'identity')