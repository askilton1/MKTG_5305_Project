source("clean.r")
library(dplyr)
library(ggplot2)
library(reshape2)

##----- total visitors, unique visitors, by day
by_day <- data %>%
  group_by(date) %>%
  summarise(totalVisitors = n(),uniqueVisitors = length(unique(anonID)),newVisitors = sum(first_time))
#-save table as CSV
write.csv(by_day,"by_day.csv") #save table
#-plot
by_day.melt <- melt(by_day,"date") 
ggplot(by_day.melt, aes(x=date,y=value)) + geom_line() + facet_grid(variable~.,scales="free") + 
  ylab("") + xlab("date")
ggsave("by_day.jpg")

##----- total visitors, unique visitors, by day of week
by_dow <- data %>%
  group_by(dow) %>%
  summarise(avgVisitors = mean(n()), avgNewVisitors = mean(first_time)*n()) %>%
  select(dow,avgVisitors,avgNewVisitors) %>%
  slice(c(2,6,7,5,1,3,4)) 
#-save table as CSV
write.csv(by_dow,"by_dow.csv")
#-plot
by_dow.melt <- melt(by_dow,"dow") 
ggplot(by_dow.melt, aes(x=dow,y=value,fill=variable)) + geom_bar(stat = "identity",position="dodge") + #facet_grid(variable~.,scales="free") + 
  ylab("") + xlab("date")
ggsave("by_dow")

data %>%
  group_by(month) %>%
  summarise(avgVisitors = mean(n()), prcntNewVisitors = round(mean(first_time),2),date=mean(date)) %>%
  arrange(date) %>% 
  select(-date) %>%
  write.csv(.,"by_month.csv")

