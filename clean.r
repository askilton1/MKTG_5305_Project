rm(ls=list())
library(dplyr)
print("reading data")
data <- tbl_df(read.csv("data.csv"))
print("cleaning data")
data <- data %>% 
  mutate(date = as.POSIXct((Door.Access.Actual.DateTime),origin = "1960-01-01",format="%A, %B %d, %Y"),
         dow = weekdays(date), 
         weekend = ifelse(dow=="Saturday" | dow=="Sunday",1,0),
         class = Classification,
         turn1 = ifelse(Door.Name == "FITN-TRN1",1,0),
         first_time = ifelse(1:length(anonID) %in% match(unique(anonID),anonID),0,1)) %>%
  select(-Door.Access.Actual.DateTime,-Result,-Door.Name,-Classification) %>%
  filter(date >= "2013-06-15" & date <= "2014-06-15")
print("done")

