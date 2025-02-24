here::i_am("2024Spring/material/session12-material/session12-data.R")
library(dplyr)
library(data.table)
library(here)
library(tidyr)

# Education--------
education_data_raw <- WDI::WDI(
  start = 2010, end = 2020,
  indicator = c(
    "EducationSpending"="SE.XPD.TOTL.GD.ZS",
    "GDPpc"="NY.GDP.PCAP.PP.CD"),
  extra = TRUE)

education_data <- education_data_raw %>% 
  select(iso3c, year, EducationSpending, GDPpc, income) %>% 
  filter(income!="Aggregates", income!="Not classified")

fwrite(education_data, 
       here("2024Spring/material/session12-material/education_income.csv"))

# Child mortality------------
child_mortality_raw <- WDI::WDI(
  start = 2000, end = 2021,
  indicator = c(
    "ChildMortality"="SH.DYN.MORT",
    "GDPpc"="NY.GDP.PCAP.PP.CD"),
  extra = TRUE)

child_mortality <- child_mortality_raw %>% 
  filter(income!="Aggregates", income!="Not classified") %>% 
  select(iso3c, year, ChildMortality, GDPpc)
 
fwrite(child_mortality, 
       here("2024Spring/material/session12-material/child_mortality.csv"))

  
