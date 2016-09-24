source("clean.r")
library(dplyr)
data2 <- data %>%
  group_by(date) %>%
  summarise(total_visitors = n(),unique_visitors = length(unique(anonID)),sum_new_visitors = sum(first_time))
write.csv(data2,"by_day.csv") 
attach(data2)
plot(date,sum_new_visitors,main = "New Visitors by Day \nBetween 6/30/14 and 7/1/15",ylab = "New Visitors")
detach(data2);rm(data2)

data %>%
  group_by(dow) %>%
  summarise(avgVisitors = mean(n()), prcntNewVisitors = mean(first_time)) %>%
  select(dow,avgVisitors,prcntNewVisitors) %>%
  slice(c(2,6,7,5,1,3,4)) %>%
  write.csv(.,"by_dow.csv")

data %>%
  group_by(month) %>%
  summarise(mean_n_visitors = mean(n()), percent_new_visitors = round(mean(first_time),2),date=mean(date)) %>%
  arrange(date) %>% 
  select(-date) %>%
  write.csv(.,"by_month.csv")

