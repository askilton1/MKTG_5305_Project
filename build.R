source("clean.r")
library(dplyr)
data %>%
  group_by(date) %>%
  summarise(total_swipes = n(),unique_visitors = length(unique(anonID)),sum_first_time = sum(first_time)) %>%
  write.csv(.,"by_day.csv")
