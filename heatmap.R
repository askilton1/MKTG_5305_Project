library(ggplot2);library(dplyr)
source("dateTime.R")
source("AllUniqueNew.R")
source("clean.r")

toPlot <-read.csv("data.csv") %>%
  clean() %>%
  calendar_fun() %>%
  AllUniqueNew()

filter(toPlot, anonID %in% unique(idToExclude)) %>% # removes facility visitors who visited for the first time prior to 14-15 school year
  ggplot(aes(monthweek, dow, fill = New)) + 
      geom_tile(colour = "white") + 
      facet_grid(~yearmonth,scales = "free") + 
      scale_fill_gradient(low="yellow", high="red") +
      ggtitle("Number of New Visitors") +  
      xlab("Week of Month") + ylab("") + 
      theme(legend.position = "bottom") 
ggsave("plots/new_heatmap.png", width = 10, height = 3, units = "in")

ggplot(toPlot,aes(monthweek, dow, fill = Unique)) + 
  geom_tile(colour = "white") + 
  facet_grid(~yearmonth, scales = "free") + 
  scale_fill_gradient(low="yellow", high = "red") +
  ggtitle("Number of Unique Visitors") +  
  xlab("Week of Month") + ylab("") + 
  theme(legend.position = "bottom")
ggsave("plots/unique_heatmap.png", width = 10, height = 3, units = "in")

ggplot(toPlot,aes(monthweek, dow, fill = All-Unique)) + 
  geom_tile(colour = "white") + 
  facet_grid(~yearmonth, scales = "free") + 
  scale_fill_gradient(low="yellow", high = "red") +
  ggtitle("Difference Between All Visitors and Unique Visitors") +  
  xlab("Week of Month") + ylab("") + 
  theme(legend.position = "bottom")
ggsave("plots/all_minus_unique_heatmap.png", width = 10, height = 3, units = "in")