# This is just an R-script version of the lecture notes
# Packages used------------------------
library(DataScienceExercises)
library(ggplot2)
gdp_data <- DataScienceExercises::gdplifexp2007
head(gdp_data, 3)

# 1. Empty plot------------------------

gdp_plot <- ggplot2::ggplot()
typeof(gdp_plot)
str(gdp_plot)
gdp_plot

# 2. Add data------------------------

gdp_plot <- ggplot2::ggplot(
  data = gdp_data
)

# 3. Add mapping of variables to aesthetics---------
# map the variables from the data set onto the plot

gdp_plot <- ggplot2::ggplot(
  data = gdp_data, 
  mapping = ggplot2::aes(
    x = gdpPercap,
    y = lifeExp
  )
)
gdp_plot

# Implicit ranges:
min(gdp_data$lifeExp); max(gdp_data$lifeExp)
min(gdp_data$gdpPercap); max(gdp_data$gdpPercap)

# 4. Add point geoms---------

gdp_plot <- gdp_plot + geom_point()
gdp_plot

# 5. Add color and size mapping-------------

gdp_plot <- ggplot2::ggplot(
  data = gdp_data, 
  mapping = ggplot2::aes(
    x = gdpPercap,
    y = lifeExp,
    size = pop, 
    color = continent
  )
) +
  ggplot2::geom_point()
gdp_plot

# 6. Add point transparency------------
gdp_plot <- ggplot2::ggplot(
  data = gdp_data, 
  mapping = ggplot2::aes(
    x = gdpPercap,
    y = lifeExp,
    size = pop, 
    color = continent
  )
) +
  ggplot2::geom_point(alpha=0.5)
gdp_plot

# 7. Adjust point aesthetic------------

gdp_plot <- ggplot2::ggplot(
  data = gdp_data, 
  mapping = ggplot2::aes(
    x = gdpPercap,
    y = lifeExp,
    size = pop, 
    fill = continent
  )
) +
  ggplot2::geom_point(
    shape=21, color="black", alpha=0.5)
gdp_plot
 
# 8. Fix the labels and annotations------------

gdp_plot <- gdp_plot +
  ggplot2::labs(
    title = "Life expectancy and income per capita", 
    caption = "Note: size of bubbles represents population. Data: Gapminder",
    x = "GDP per capita (int. Dollar)",
    y = "Life expectancy in years"
  )
gdp_plot

# 9. Adjust x-axis ------------

gdp_plot <- gdp_plot +
  ggplot2::scale_x_continuous(
    labels = scales::number_format(scale = 0.001, suffix = "k")
  )
gdp_plot

# 10. Adjust legends--------------
# remove the legend for the bubble size since
# several ways to to this: either we use the `scale_*_*()` function
#  with the argument `guide="none"`:

gdp_plot + ggplot2::scale_size_continuous(guide = "none")
       
# Specific function that allows us to specify all kinds of legend properties:

gdp_plot <- gdp_plot + ggplot2::guides(size = "none")
gdp_plot
       
# `ggplot2::scale_size_continuous()` allows for further adjustments:
#  strech the limits a bit to make the differences more straightforward to see:

gdp_plot <- gdp_plot + 
  ggplot2::scale_size_continuous(
    guide = "none", 
    range = c(0.1, 24)
  )
gdp_plot

# put the remaining legend to the bottom of the plot. 

gdp_plot <- gdp_plot +
  ggplot2::theme(legend.position = "bottom")
gdp_plot

# 11. Use pre-defined theme------------   
gdp_plot <- gdp_plot +
  ggplot2::theme_bw()
gdp_plot

# It makes always sense to first call the default theme, and *then* make further changes via `ggplot::theme()`.

# 12. Use further theme-options--------
# Removing elements of the plot via `ggplot2::theme()` 
#  requires us to set these elements via the function 
#  `ggplot2::element_blank()`:
         
gdp_plot <- gdp_plot +
  ggplot2::theme_bw() +
  theme(
    legend.position = "bottom",
    panel.border = ggplot2::element_blank()
  )
gdp_plot

# Adjust lines:    
gdp_plot <- gdp_plot +
  ggplot2::theme(
    axis.line = ggplot2::element_line(colour = "grey"))
gdp_plot

# The ticks of the values should have the same color as the axis lines!!!
         
gdp_plot <- gdp_plot +
  ggplot2::theme(
    axis.ticks = ggplot2::element_line(colour = "grey"))
gdp_plot

# Adjust ugly title of the legend
         
gdp_plot <- gdp_plot +
  ggplot2::theme(legend.title = ggplot2::element_blank())
gdp_plot

# 13. Use color pallettes---------

gdp_plot <- gdp_plot +
  ggplot2::scale_fill_brewer(palette = "Dark2")
gdp_plot

       
# 14. Whole code-----------------------
gdp_plot <- ggplot2::ggplot(
  data = gdp_data, 
  mapping = ggplot2::aes(
    x = gdpPercap,
    y = lifeExp,
    size = pop, 
    fill = continent
  )
) +
  ggplot2::geom_point(
    shape=21, color="black", alpha=0.5) +
  ggplot2::labs(
    title = "Life expectancy and income per capita", 
    caption = "Note: size of bubbles represents population. Data: Gapminder",
    x = "GDP per capita (int. Dollar)",
    y = "Life expectancy in years"
  ) +
  ggplot2::scale_x_continuous(
    labels = scales::number_format(scale = 0.001, suffix = "k")
  ) + 
  ggplot2::scale_size_continuous(
    guide = "none", 
    range = c(0.1, 24)
  ) +
  ggplot2::scale_fill_brewer(
    palette = "Dark2"
  ) +
  ggplot2::theme_bw() +
  ggplot2::theme(
    legend.position = "bottom",
    legend.title = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    axis.line = ggplot2::element_line(colour = "grey"),
    axis.ticks = ggplot2::element_line(colour = "grey")
  )

# 15. An alternativ line plot--------------

gdp_data_agg <- DataScienceExercises::aggGDPlifexp
head(gdp_data_agg, 3)
       
# just replace the name of the data set and the variable names:
         
gdp_dyn_plot <- ggplot2::ggplot(
  data = gdp_data_agg, # <- Replaced 
  mapping = ggplot2::aes(
    x = year, # <- Replaced 
    y = gdpPercap, # <- Replaced 
    color = continent#, 
    #fill = continent # <- Not necessary 
  )
) +
  ggplot2::geom_point() 
gdp_dyn_plot

# add an additional geom that connects the dots with lines. No problem, simply add `ggplot2::geom_line()` to the plot:

gdp_dyn_plot <- gdp_dyn_plot +
  geom_line()
gdp_dyn_plot

# Adjust number format and palette:
gdp_dyn_plot <- gdp_dyn_plot +
  ggplot2::scale_y_continuous(
    labels = scales::number_format(scale = 0.001, suffix = "k")
  ) + 
  ggplot2::scale_color_brewer(
    palette = "Dark2"
  )
gdp_dyn_plot

# Re-use basicalle everything:

gdp_dyn_plot <- gdp_dyn_plot +
  labs(
    title = "The divergence of income per capita", 
    caption = "Note: country data averaged over continants. Data: Gapminder",
    y = "GDP per capita (int. Dollar)"
  ) +
  ggplot2::theme_bw() +
  theme(
    legend.position = "bottom",
    legend.title = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    axis.line = ggplot2::element_line(colour = "grey"),
    axis.ticks = ggplot2::element_line(colour = "grey"),
    axis.title.x = ggplot2::element_blank()
  )
gdp_dyn_plot

# Saving your plot --------------------

ggplot2::ggsave(
  plot = gdp_plot, 
  filename = "gdp_plot.pdf", 
  width = 6, height = 4.2)
