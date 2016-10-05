library(ggplot2);library(dplyr)
source("dateTime.R")
source("AllUniqueNew.R")
source("clean.r")

toPlot <-read.csv("data.csv") %>%
  clean() %>%
  calendar_fun() %>%
  AllUniqueNew()

ggplot(toPlot,aes(monthweek, dow, fill = New)) + 
    geom_tile(colour = "white") + 
    facet_grid(~yearmonth,scales = "free") + 
    scale_fill_gradient(low="yellow", high="red") +
    ggtitle("Time-Series Calendar Heatmap") +  
    xlab("Week of Month") + ylab("") + 
    theme(legend.position="bottom")
ggsave("plots/new_heatmap.png",width=10,height=3,units="in")

ggplot(toPlot,aes(monthweek, dow, fill = Unique)) + 
  geom_tile(colour = "white") + 
  facet_grid(~yearmonth, scales = "free") + 
  scale_fill_gradient(low="yellow", high = "red") +
  ggtitle("Time-Series Calendar Heatmap") +  
  xlab("Week of Month") + ylab("") + 
  theme(legend.position="bottom")
ggsave("plots/unique_heatmap.png",width=10,height=3,units="in")

ggplot(toPlot,aes(monthweek, dow, fill = All-Unique)) + 
  geom_tile(colour = "white") + 
  facet_grid(~yearmonth, scales = "free") + 
  scale_fill_gradient(low="yellow", high = "red") +
  ggtitle("Time-Series Calendar Heatmap") +  
  xlab("Week of Month") + ylab("") + 
  theme(legend.position="bottom")
ggsave("plots/all_minus_unique_heatmap.png",width=10,height=3,units="in")