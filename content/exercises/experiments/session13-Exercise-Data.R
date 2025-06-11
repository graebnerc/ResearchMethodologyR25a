# Generates the dataset for the comprehensive exercise in section 13
here::i_am("content/exercises/experiments/session13-Exercise-Data.R")
library(here)
library(readr)

set.seed(123)
creativity_study <- data.frame(
  employee_id = 1:75,
  work_environment = rep(
    c("open_office", "private_office", "flexible_workspace"), each = 25),
  creativity_score = c(
    rnorm(25, mean = 72, sd = 12),    # Open office
    rnorm(25, mean = 78, sd = 10),    # Private office
    rnorm(25, mean = 85, sd = 11)     # Flexible workspace
  ),
  years_experience = sample(1:20, 75, replace = TRUE),
  department = sample(c("Marketing", "IT", "HR", "Finance"), 75, replace = TRUE)
)

write_csv(creativity_study, here("content/exercises/experiments/employee_data.csv"))