turn1 <- read.csv("FITN Turnstile 1.csv")
turn2 <- read.csv("FITN Turnstile 2.csv")
turn <- rbind(turn1,turn2)

turn$Customer.Number[turn$Customer.Number=="{null}"] <- NA
turn <- turn[!is.na(turn$Customer.Number),]
cbind(unique(turn$Customer.Number),1:length(unique(turn$Customer.Number)))

un <- unique(turn$Customer.Number)
for (i in 7053:length(unique(turn$Customer.Number))){
  turn$anonID[turn$Customer.Number==un[i]] <- i
  print(paste(i,"/",length(unique(turn$Customer.Number))))
}

turn.anon <- turn[,-2]

write.csv(turn.anon[,c(5,1,2,3,4)],"data.csv",row.names=FALSE)
