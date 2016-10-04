calendar_fun <- function(x){
  library(dplyr);library(tidyr)
  data %>%
    mutate(
      date = as.POSIXct((Door.Access.Actual.DateTime),origin = "1960-01-01",format="%A, %B %d, %Y"),
      year = as.factor(strftime(date,"%Y")),
      month = as.factor(months(date,abbreviate=TRUE)),
      dow = as.factor(weekdays(date,abbreviate=TRUE)),
      #yearmonth = as.factor(paste(year,month,sep=" ")),
      week = as.numeric(format(date,"%W")),
      weekend = ifelse(dow=="Sat" | dow=="Sun",1,0)) %>%
    unite(yearmonth, year, month, sep="-", remove=FALSE) %>%
    group_by(yearmonth) %>% mutate(monthweek=1+week-min(week)) %>% ungroup() %>%
    #mutate(monthweek=1+week-monthweek) %>%
    filter(date >= "2014-09-15" & date <= "2015-06-30") %>%
    select(-Door.Access.Actual.DateTime) %>%
  return()
}

