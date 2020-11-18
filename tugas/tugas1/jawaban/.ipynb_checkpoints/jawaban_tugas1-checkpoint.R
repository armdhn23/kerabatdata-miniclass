# mendefinisikan variabel

money <- 50000
banana_price <- 5000
amount_banana <- 6

#buat total price
total_price <- banana_price * amount_banana

##membuat program if

if(money >= total_price){
  print(paste('You bought', amount_banana, 'bananas'))
  money <- money - total_price
} else{
  print('Your money is not enough')
}

print(paste('your remaining money Rp',money))
