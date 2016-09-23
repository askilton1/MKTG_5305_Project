source("clean.r")
library(dplyr)
data2 <- data %>%
  group_by(date) %>%
  summarise(total_visitors = n(),unique_visitors = length(unique(anonID)),sum_new_visitors = sum(first_time)) %>%
  write.csv(.,"by_day.csv")

plot(data2$date,data2$sum_new_visitors)

data %>%
  group_by(dow) %>%
  summarise(mean_number_visitors = mean(n()), percent_new_visitors = mean(first_time)) %>%
  write.csv(.,"by_dow.csv")