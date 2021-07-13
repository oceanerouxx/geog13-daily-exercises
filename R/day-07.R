# COVID day 07 example
# Oceane Roux
# July 3, 2021

# Libraries
library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = readr::read_csv(url)

#step 2
(df <- data.frame(abvr = state.abb,
                  state = state.name,
                  region = state.region))
#step 3

raw = inner_join(covid, df, by = "state", copy = TRUE)

#step 4

cc4 = raw %>% group_by(region, date) %>%
  summarise(regionalcases = sum(cases), regionaldeaths = sum(deaths)) %>%
  pivot_longer(cols=c("regionalcases","regionaldeaths")) %>%
  ungroup()


ggplot(cc4, aes(x=date, y=value, group=region)) +
  geom_line(aes(col=region)) +
  facet_grid(name~region, scales="free_y") +
  scale_x_date(date_labels = "%B")+
  theme(axis.text.x = element_text(angle=45, hjust = 1),
        legend.position = "none") +
  labs(title = "Cumulative Cases and Deaths by Region",
       caption = "Daily Exercise 07",
       subtitle = "COVID-19 Data: NY Times",
       x = "Date", y = "Daily Cumulative Count")

max(covid$date)
