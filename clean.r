rm(list=ls())
library(dplyr)
print("reading data")
data <- tbl_df(read.csv("data.csv"))
print("cleaning data")
data <- data %>% 
  mutate(date = as.POSIXct((Door.Access.Actual.DateTime),origin = "1960-01-01",format="%A, %B %d, %Y"),
         dow = weekdays(date), 
         month = months(date),
         weekend = ifelse(dow=="Saturday" | dow=="Sunday",1,0),
         class = Classification,
         turn1 = ifelse(Door.Name == "FITN-TRN1",1,0),
         anonID = as.factor(anonID)) %>%
  select(-Door.Access.Actual.DateTime,-Result,-Door.Name,-Classification) %>%
  filter(date >= "2014-07-01" & date <= "2015-06-30")
print("done")

data$first_time <- 0
data$first_time[match(unique(data$anonID),data$anonID)] <- 1
