library(ggplot2);library(dplyr)
source("dateTime.R")
source("AllUniqueNew.R")
source("clean.r")
read.csv("data.csv") %>%
  clean() %>%
  calendar_fun() %>%
  AllUniqueNew() %>%
  ggplot(aes(monthweek, dow, fill = New)) + 
    geom_tile(colour = "white") + facet_grid(~yearmonth) + scale_fill_gradient(low="yellow", high="red") +
    ggtitle("Time-Series Calendar Heatmap") +  xlab("Week of Month") + ylab("") + theme(legend.position="bottom")
ggsave("plots/heatmap.png")
