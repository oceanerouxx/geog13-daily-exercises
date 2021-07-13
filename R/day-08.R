# CONUS Day 8 Exercise
# Oceane Roux
# July 13th, 2020


#Libraries
library(tidyverse)
library(USAboundaries)
library(dplyr)
library(sf)


#Step 1

conus = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico",
                            "Alaska",
                            "Hawaii"))
#Step 2

us_c_ml = st_combine(conus) %>%
  st_cast("MULTILINESTRING")

plot(us_c_ml)


#Step 3

us_u_ml = st_union(conus) %>%
  st_cast("MULTILINESTRING")

plot(us_u_ml)
