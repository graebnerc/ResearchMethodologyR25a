here:i_am("R/make_co2_data.R")
library(here)
library(data.table)
library(dplyr)
library(tidyr)

# As downloaded from 
# https://data.worldbank.org/indicator/EN.ATM.CO2E.PC
# on April 22, 2024
co2_data_raw <- fread(here("data/co2_raw.csv"), header = TRUE) 

co2_data_tidy <- co2_data_raw %>% 
  select(-c(
    "Indicator Name", "Indicator Code", # unique() tells you there is only one indicator
    "Country Code", 
    "V69" # Sometimes such erroneous columns are part of what you download
  )) %>% 
  pivot_longer(
    cols = -"Country Name", 
    names_to = "year", 
    values_to = "co2_percap") %>% 
  mutate(year = as.double(year)) %>% 
  filter(
    year >= 2000, year<=2020, 
    `Country Name` %in% c(
      "South Africa", "United States", "Sub-Saharan Africa", 
      "European Union", "Germany", "China")
  ) %>% 
  rename(country = `Country Name`)

fwrite(co2_data_tidy, file = here("data/co2_tidy.csv"))
