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
luas_segitiga(9,10)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(10, 2)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(7, 13)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(8, 8)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(6, 14)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(7, 7)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(3, 6)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(8, 7)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(10, 18)

luas_segitiga <- function(alas, tinggi){
1/2*alas*tinggi
}
luas_segitiga(7, 18)



luas <- c(45, 10, 45.4, 32, 42, 24.5, 9, 28, 90, 63)
	for(luas in luas) 
{
	if(luas %% 2 == 0){
	print(paste(luas, 'adalah bilangan genap'))
} else{
	print(paste(luas, 'adalah bilangan ganjil'))
}
}