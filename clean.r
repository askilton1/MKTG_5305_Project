clean <- function(x){
  suppressMessages(library(dplyr))
  print("cleaning data")
  data <- tbl_df(x) %>% 
    mutate(class = Classification,
           tunstile_1 = as.factor(ifelse(Door.Name == "FITN-TRN1",1,0)),
           anonID = as.factor(anonID)) %>%
    select(-Result,-Door.Name,-Classification)

  print("done")
  return(data)
}

