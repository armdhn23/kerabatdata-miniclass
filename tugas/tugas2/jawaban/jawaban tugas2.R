set.seed(10)

alas <- c(sample(1:10, 10, replace = TRUE))
tinggi <- c(sample(1:20, 10, replace = TRUE))
segitiga <- c()
for(i in 1:10){
  segitiga[i] = paste('segitiga ke',i)
}
data_segitiga <- data.frame(segitiga, alas, tinggi)
data_segitiga

luas_segitiga <- function(alas, tinggi){
  1/2*alas*tinggi
}

numbers <- c(1:10)
for(i in numbers){
  if(luas_segitiga(alas[i], tinggi[i]) %% 2 == 0){
    print(paste('Luas segitiga ke', i, 'adalah', luas_segitiga(alas[i], tinggi[i]),
                'dan bernilai genap'))
  } else{
    print(paste('Luas segitiga ke', i, 'adalah', luas_segitiga(alas[i], tinggi[i]),
                'dan bernilai ganjil'))
  }
}
