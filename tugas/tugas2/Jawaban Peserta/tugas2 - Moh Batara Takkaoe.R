set.seed(10)
alas <- c(sample(1:10, 10, replace=T))
tinggi <- c(sample(1:10, 10, replace =T))
luas <- 1/2*alas*tinggi

ket <- if (luas %% 2 == 0){
  print(paste(i , 'dan bernilaigenap'))
}else{
  print(paste(i, 'dan bernilai ganjil'))
}

segitiga <- c()
for (i in 1:10){
  segitiga[i] = paste ('Luas segitiga ke', i , 'adalah')
}
segitiga

data_segitiga <- data.frame(segitiga, ket)
data_segitiga
}