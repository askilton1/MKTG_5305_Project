require(quantmod)
require(ggplot2)
require(reshape2)
require(plyr)
require(scales)
library(dplyr)
source("clean.r")

data <- clean(read.csv("data.csv"))

data <- tbl_df(data)
data$year<-as.numeric(as.POSIXlt(data$date)$year+1900)
# the month too 
data$month<-as.numeric(as.POSIXlt(data$date)$mon+1)
# data$weekday <- as.POSIXlt(data$date)$wday
data$weekdayf <- factor(data$dow,levels=c("Mon","Tue","Wed","Thu","Fri","Sat","Sun"),labels=rev(c("Mon","Tue","Wed","Thu","Fri","Sat","Sun")),ordered=TRUE)
data$yearmonth<-as.yearmon(data$date)
data$yearmonthf<-factor(data$yearmonth)
# then find the "week of year" for each day
data$week <- as.numeric(format(data$date,"%W"))
# and now for each monthblock we normalize the week to start at 1 
data<-ddply(data,.(yearmonthf),transform,monthweek=1+week-min(week))
data <- data %>% mutate(monthweek = ifelse(monthweek==6,5,monthweek))
data %>%
  group_by(date) %>%
  summarise(monthweek=unique(monthweek),weekdayf=unique(weekdayf),yearmonthf=unique(yearmonthf),
    All = n(),Unique = length(unique(anonID)),New = sum(first_time)) %>%
  ggplot(aes(monthweek, weekdayf, fill = New)) + 
    geom_tile(colour = "white") + facet_grid(~yearmonthf) + scale_fill_gradient(low="yellow", high="red") +
    ggtitle("Time-Series Calendar Heatmap") +  xlab("Week of Month") + ylab("") + theme(legend.position="bottom")
ggsave("plots/heatmap.png")
