source("clean.r")
library(dplyr)
data %>%
  group_by(date) %>%
  summarise(total_swipes = n(),unique_visitors = length(unique(anonID)),sum_new_visitors = sum(first_time)) %>%
  write.csv(.,"by_day.csv")

data %>%
  group_by(dow) %>%
  summarise(sum_new_visitors = sum(first_time)) %>%
  write.csv(.,"by_dow.csv")