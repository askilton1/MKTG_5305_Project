calendar_fun <- function(data){
  library(dplyr);library(tidyr)
  data %>%
    mutate(
      date = as.POSIXct((Door.Access.Actual.DateTime),origin = "1960-01-01",format="%A, %B %d, %Y"),
      year = as.factor(strftime(date,"%Y")),
      month = factor(months(date,abbreviate=TRUE),levels=c("Sep","Oct","Nov","Dec","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug"),ordered=TRUE),
      dow = factor(weekdays(date,abbreviate=TRUE),levels=rev(c("Mon","Tue","Wed","Thu","Fri","Sat","Sun")),ordered=TRUE),
      week = as.numeric(format(date,"%W")),
      weekend = ifelse(dow=="Sat" | dow=="Sun",1,0),
      before_anonID = ifelse(date >= "2014-09-15",1,0)) %>%
    unite(yearmonth, year, month, sep="-", remove=FALSE) %>%
    group_by(yearmonth) %>% mutate(monthweek=ifelse(1+week-min(week) == 6, 5, 1+week-min(week))) %>% ungroup() %>%
    filter(before_anonID==1,date >= "2014-09-15" & date <= "2015-06-30") %>% 
    mutate(yearmonth = factor(yearmonth,levels=c("2014-Sep","2014-Oct","2014-Nov","2014-Dec","2015-Jan","2015-Feb","2015-Mar","2015-Apr","2015-May","2015-Jun"))) %>%
    select(-Door.Access.Actual.DateTime,-before_anonID) %>%
  return()
}