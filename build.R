library(tidyverse)
library(lubridate)

#import data
read_csv("data.csv", 
         #n_max = 10, #for testing purposes only
         col_types = cols_only(anonID = col_character(), 
                                           Door.Access.Actual.DateTime = col_character(), #"%A, %B, %e, %Y"
                                           Classification = col_character())) %>%
  rename(date = Door.Access.Actual.DateTime,
         class = Classification,
         id = anonID) %>%
         #change date to POSIXct
  mutate(date = as.POSIXct(date,origin = "1960-01-01",format="%A, %B %d, %Y"),
         #create new column that marks whether or not first time visitor
         first_time = ifelse(1:length(id) %in% match(unique(id),id),1,0)) %>%
         #filter for IDs that first appeared in 14-15 school year
  filter(id %in% ifelse(date <= "2014-09-20" | 
                                     #or appeared on days the facility was closed (to remove staff)
                                     date == "2015-01-19" | date == "2015-04-03",
                                     #and returns id if new, NA if not new
                                     id, NA),
         #also filter for students
         class == "Student") -> df

#Create tables
df %>%
  group_by(month = month(date, label = TRUE)) %>%
  summarise(All = n(), Unique = length(unique(id)), New = sum(first_time)) -> by_month.df

df %>%
  group_by(monthday = day(date)) %>%
  summarise(All = n(), Unique = length(unique(id)), New = sum(first_time)) -> by_day_of_month.df

df %>%
  group_by(weekday = wday(date)) %>%
  summarise(All = n(), Unique = length(unique(id)), New = sum(first_time)) -> by_weekday.df

df %>%
  group_by(week = week(date)) %>%
  summarise(All = n(), Unique = length(unique(id)), New = sum(first_time)) -> by_week_of_year.df

#Sample plot, can be modified for any of above tables
by_week_of_year.df %>%
  gather(key = class, value = visitors, All, Unique, New) %>%
  #use following row with months
  #mutate(month = factor(month, levels = c("Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug"), ordered=TRUE)) %>%
  ggplot(., aes(x=week, y=visitors)) + geom_bar(stat = "identity") + facet_grid(class ~ .,scales="free") + 
    ylab("Number of visitors per month") + xlab("month") + theme_minimal() 
ggsave("plots/by_day.png",width=6,height=6,units="in")