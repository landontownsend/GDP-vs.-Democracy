# Install and load the WDI package
install.packages("WDI")  # Run this only once
library(WDI)

# Fetch the WDI data for GDP per capita (use the indicator "NY.GDP.PCAP.CD" for GDP per capita)
wdi_data <- WDI(country = "all", indicator = "NY.GDP.PCAP.CD", start = 2000, end = 2018, extra = TRUE)

# Load the Polity IV data
p5v2018 <- read_excel("Downloads/p5v2018.xls")

# Merge datasets by country and year
merged_data <- merge(wdi_data, p5v2018, by = c("country", "year"))

# Initial plot
library(ggplot2)
ggplot(merged_data, aes(x = NY.GDP.PCAP.CD, y = polity)) + 
  geom_point(color = "blue", size = 3) + 
  labs(x = "GDP per Capita", y = "Democracy Score", title = "GDP vs. Democracy")

# Cleaning data for better plotting
cleaned_data <- na.omit(merged_data[, c("NY.GDP.PCAP.CD", "polity")])

# Enhanced plot with additional formatting
library(scales)
ggplot(cleaned_data, aes(x = NY.GDP.PCAP.CD, y = polity)) +
  geom_point(color = "steelblue", size = 2, alpha = 0.7) +  
  scale_x_log10(labels = comma) +                                          
  geom_smooth(method = "lm", color = "red", se = FALSE) +  # Linear trendline
  labs(x = "GDP per Capita", y = "Democracy Score", 
       title = "GDP vs. Democracy", 
       subtitle = "Exploring the Relationship Between GDP per Capita and Democracy Scores",
       caption = "Source: World Development Indicators & Polity IV") + 
  scale_y_continuous(breaks = seq(-75, 100, by = 20)) +  
  theme_minimal() +                                           
  theme(plot.title = element_text(face = "bold", size = 14), 
        plot.subtitle = element_text(size = 10, face = "italic"),  
        plot.caption = element_text(face = "italic", size = 8),    
        axis.text = element_text(size = 10),                       
        axis.title = element_text(face = "bold"))
