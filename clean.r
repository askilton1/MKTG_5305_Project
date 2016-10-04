clean <- function(x){
  suppressMessages(library(dplyr))
  print("cleaning data")
  data <- x %>% 
    mutate(date = as.POSIXct((Door.Access.Actual.DateTime),origin = "1960-01-01",format="%A, %B %d, %Y"),
           dow = weekdays(date,abbreviate=TRUE),
           month = months(date),
           weekend = ifelse(dow=="Sat" | dow=="Sun",1,0),
           class = Classification,
           turn1 = ifelse(Door.Name == "FITN-TRN1",1,0),
           anonID = as.factor(anonID)) %>%
    select(-Door.Access.Actual.DateTime,-Result,-Door.Name,-Classification) %>%
    filter(date >= "2014-09-15" & date <= "2015-06-30")
  
  data$first_time <- 0
  data$first_time[match(unique(data$anonID),data$anonID)] <- 1
  
  print("done")
  return(data)
  }