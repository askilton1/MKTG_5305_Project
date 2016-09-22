library(dplyr)
data <- tbl_df(read.csv("data.csv"))

data <- data %>% 
  mutate(date = as.POSIXct((Door.Access.Actual.DateTime),origin = "1960-01-01",format="%A, %B %d, %Y"),
         dow = weekdays(date), 
         weekend = ifelse(dow=="Saturday" | dow=="Sunday",1,0),
         class = Classification,
         turn1 = ifelse(Door.Name == "FITN-TRN1",1,0)) %>%
  select(-Door.Access.Actual.DateTime,-Result,-Door.Name,-Classification) %>%
  filter(date >= "2013-06-15" & date <= "2014-06-15")


