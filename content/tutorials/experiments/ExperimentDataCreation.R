here::i_am("content/tutorials/experiments/ExperimentDataCreation.R")
library(here)
library(tibble)
library(readr)


# Dataset 1: Simple two-group experiment
# Research question: Does leadership training improve team performance?
set.seed(123)
leadership_study_between <- tibble(
  participant_id = 1:60,
  group = rep(c("control", "training"), each = 30),
  team_performance = c(
    rnorm(30, mean = 75, sd = 10),      # Control group
    rnorm(30, mean = 82, sd = 10)       # Training group
  )
)

leadership_study_within <- leadership_study_between |> 
  mutate(
    pre_performance = rnorm(60, mean = 70, sd = 8),
    post_performance = ifelse(
      group == "training",
      team_performance, NA
      ) 
    ) |> 
  filter(group=="training") |> 
  select(participant_id, pre_performance, post_performance)


write_csv(leadership_study_between, file = here("content/tutorials/experiments/leadership_study_between.csv"))
write_csv(leadership_study_within, file = here("content/tutorials/experiments/leadership_study_within.csv"))


# Dataset 2: Multi-group experiment  
# Research question: Which communication method is most effective?
set.seed(456)
communication_study <- data.frame(
  participant_id = 1:90,
  communication_method = rep(c("face_to_face", "video_call", "email"), each = 30),
  satisfaction_score = c(
    rnorm(30, mean = 7.2, sd = 1.2),    # Face-to-face
    rnorm(30, mean = 6.8, sd = 1.3),    # Video call  
    rnorm(30, mean = 5.9, sd = 1.4)     # Email
  ),
  task_completion_time = c(
    rnorm(30, mean = 25, sd = 5),       # Face-to-face
    rnorm(30, mean = 28, sd = 6),       # Video call
    rnorm(30, mean = 35, sd = 7)        # Email
  )
)
write_csv(communication_study, file = here("content/tutorials/experiments/communication_study.csv"))


# Dataset 3: 2x2 Factorial design
# Research question: How do feedback type and experience level affect performance?
set.seed(789)
factorial_study <- data.frame(
  participant_id = 1:120,
  feedback_type = rep(c("positive", "critical"), each = 60),
  experience_level = rep(c("novice", "expert"), times = 60),
  performance_improvement = c(
    # Positive feedback
    rnorm(30, mean = 8, sd = 3),   # Positive + Novice
    rnorm(30, mean = 6, sd = 2.5), # Positive + Expert
    # Critical feedback  
    rnorm(30, mean = 3, sd = 3),   # Critical + Novice
    rnorm(30, mean = 9, sd = 2.5)  # Critical + Expert
  )
)
write_csv(factorial_study, file = here("content/tutorials/experiments/factorial_study.csv"))
