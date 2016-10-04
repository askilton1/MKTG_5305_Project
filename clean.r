clean <- function(x){
  suppressMessages(library(dplyr))
  print("cleaning data")
  data <- tbl_df(x) %>% 
    mutate(date = as.POSIXct((Door.Access.Actual.DateTime),origin = "1960-01-01",format="%A, %B %d, %Y"),
           class = Classification,
           tunstile_1 = ifelse(Door.Name == "FITN-TRN1",1,0),
           anonID = as.factor(anonID),
           first_time = ifelse(1:length(anonID) %in% match(unique(anonID),anonID),1,0)) %>%
    select(-Door.Access.Actual.DateTime,-Result,-Door.Name,-Classification) %>%
    filter(date >= "2014-09-15" & date <= "2015-06-30")

  print("done")
  return(data)
}

