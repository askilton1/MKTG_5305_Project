clean <- function(x){
  suppressMessages(library(dplyr))
  print("cleaning data")
  data <- tbl_df(x) %>% 
    mutate(class = Classification,
           tunstile_1 = ifelse(Door.Name == "FITN-TRN1",1,0),
           anonID = as.factor(anonID)) %>%
    select(-Door.Access.Actual.DateTime,-Result,-Door.Name,-Classification)

  print("done")
  return(data)
}

x <- read.csv("data.csv")
