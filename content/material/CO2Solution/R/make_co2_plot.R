here::i_am("R/make_co2_plot.R")
library(here)
library(data.table)
library(ggplot2)
library(icaeDesign)

co2_data_tidy <- fread(here("data/co2_tidy.csv"))

co2_plot <- ggplot(
  data = co2_data_tidy,
  mapping = aes(
    x = year, 
    y = co2_percap, 
    color=country)
  ) +
  geom_point() +
  geom_line(key_glyph=draw_key_rect) +
  scale_color_euf(palette = "mixed") +
  labs(
    title = "CO2 per capita",
    x = "Year", y = "Metric tons per capita") +
  theme_icae()

co2_plot

ggsave(
  filename = here("output/co2_plot.pdf"), 
  width = 6, height = 4)
  