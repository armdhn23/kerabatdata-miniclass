set.seed(10)

alas <- c (sample(1:10, 10, replace = TRUE))
tinggi <- c(sample(1:20, 10, replace = TRUE))
segitiga <- c()
for (i in 1:10) {
  segitiga[i] = paste('segitiga ke', i)
}
 data_segitiga <- data.frame(segitiga, alas, tinggi)
data_segitiga 
