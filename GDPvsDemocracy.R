# Exploring the relationship between GDP per Capita and Democracy Scores for countries of the world using World Development Indicators and Polity IV data
library(tidyverse)
library(dplyr)
library(readxl)

p5v2018 <- read_excel("Downloads/p5v2018.xls")
install.packages("WDI")
# Question: Is there a relationship between level of democracy and GDP per capita? 
# Data merging and initial plotting
merged_data <- merge(wdi_data, p5v2018, by = c("country", "year"))
ggplot(merged_data, aes(x = NY.GDP.PCAP.CD, y = polity)) + geom_point(color = "blue", size = 3) + labs(x = "GDP per Capita", y = "Democracy Score", title = "GDP vs. Democracy")
# Cleaning data for better plotting
cleaned_data <- na.omit(merged_data[, c("NY.GDP.PCAP.CD", "polity")])
# Plotting data and enhancing chart for efficacy
ggplot(cleaned_data, aes(x = NY.GDP.PCAP.CD, y = polity)) +
  +     geom_point(color = "steelblue", size = 2, alpha = 0.7) +  
  +     scale_x_log10(labels = comma) +                                          
  +     geom_smooth(method = "lm", color = "red", se = FALSE) +     # Linear trendline
  +     labs(x = "GDP per Capita", y = "Democracy Score", 
             +          title = "GDP vs. Democracy", 
             +          subtitle = "Exploring the Relationship Between GDP per Capita and Democracy Scores",
             +          caption = "Source: World Development Indicators & Polity IV") + scale_y_continuous(breaks = seq(-75, 100, by = 20)) +   theme_minimal() +                                           
  +     theme(plot.title = element_text(face = "bold", size = 14), 
              +           plot.subtitle = element_text(size = 10, face = "italic"),  
              +           plot.caption = element_text(face = "italic", size = 8),    
              +           axis.text = element_text(size = 10),                       
              +           axis.title = element_text(face = "bold")) 