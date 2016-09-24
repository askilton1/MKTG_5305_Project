source("clean.r")
library(dplyr)
library(ggplot2)
library(reshape2)

##----- total visitors, unique visitors, by day
by_day <- data %>%
  group_by(date) %>%
  summarise(All = n(),Unique = length(unique(anonID)),New = sum(first_time))
#-save table as CSV
write.csv(by_day,"tables/by_day.csv",row.names=FALSE) #save table
#-plot
by_day.melt <- melt(by_day,"date") 
ggplot(by_day.melt, aes(x=date,y=value)) + geom_line() + facet_grid(variable~.,scales="free") + 
  ylab("Number of visitors per day") + xlab("date") + theme_minimal()
ggsave("plots/by_day.png",width=6,height=6,units="in")

rm(list=setdiff(ls(), "data"))
##----- total visitors, unique visitors, by day of week
by_dow <- data %>%
  group_by(dow) %>%
  summarise(All = mean(n()), New = mean(first_time)*n()) %>%
  select(dow,All,New) %>%
  slice(c(2,6,7,5,1,3,4)) 
#-save table as CSV
write.csv(by_dow,"tables/by_dow.csv",row.names=FALSE)
#-plot
by_dow.melt <- melt(by_dow,"dow") 
by_dow.melt$dow <- factor(by_dow.melt$dow, levels = by_dow.melt$dow) #reorder months for plot
ggplot(by_dow.melt, aes(x=dow,y=value,fill=variable)) + geom_bar(stat = "identity",position="dodge") +  
  ylab("Average visitors by day") + xlab("date") + theme_minimal() + labs(fill="") + theme(legend.position="top") + scale_fill_grey()
ggsave("plots/by_dow.png",width=6,height=3,units="in")

rm(list=setdiff(ls(), "data"))
##----- total visitors, unique visitors, by month
by_month <- data %>%
  group_by(month) %>%
  summarise(All = mean(n()), New = mean(first_time)*n(),date=mean(date)) %>%
  arrange(date) 
#-save table as CSV
write.csv(select(by_month,-date),"tables/by_month.csv",row.names=FALSE)
#-plot
by_month.melt <- melt(by_month,c("month","date"))
by_month.melt$month <- factor(by_month.melt$month, levels = by_month.melt$month) #reorder months for plot
ggplot(by_month.melt, aes(x=month,y=value,fill=variable)) + geom_bar(stat = "identity",position="dodge") + 
  ylab("Average daily visitors") + xlab("date") + theme_minimal() + theme(axis.text.x = element_text(angle=30),legend.position="top")  + labs(fill="") + 
  scale_fill_grey()
ggsave("plots/by_month.png",width=6,height=3,units="in")
rm(list=ls())
