# dataset: https://www.kaggle.com/stefanoleone992/imdb-extensive-dataset
# code modified from http://gradientdescending.com/adding-custom-fonts-to-ggplot-in-r/

library(readr)
library(dplyr)
library(ggplot2)

col_types = cols(year = col_character(), date_published = col_character())
dat = read_csv("IMDb movies.csv", col_types = col_types)

set.seed(123)
horror = dat %>%
    filter(grepl("horror", genre, ignore.case = TRUE),
           grepl("^[[:digit:]]+$", year)) %>%
    mutate(year = as.integer(year)) %>%
    select(year, avg_vote) %>%
    sample_n(1000)

ggplot(horror, aes(x = year, y = avg_vote)) +
    geom_point(alpha = 0.3) +
    geom_smooth(size = 1.5) +
    xlim(1910, 2025) +
    labs(
        title = "HORROR MOVIES!",
        subtitle = "Average critics ratings of horror films and relationship over time",
        x = "YEAR", 
        y = "RATING", 
        caption = "Data from IMDB\nCode derived from @danoehm | gradientdescending.com"
    ) +
    theme_minimal() +
    theme(
        text = element_text(size = 18),
        plot.title = element_text(size = 48, hjust = 0.5),
        plot.subtitle = element_text(size = 18, hjust = 0.5, margin = margin(t = 10)),
        plot.caption = element_text(size = 8),
        axis.title = element_text(size = 26),
        axis.title.y = element_text(margin = margin(r = 15))
    )
ggsave("horror.png", width = 12, height = 7, dpi = 96, type = "cairo")



library(showtext)
font_add("swamp-witch", regular = "../fonts/Swamp Witch.ttf")
font_add_google(name = "Montserrat", family = "montserrat")
showtext_auto()

ggplot(horror, aes(x = year, y = avg_vote)) +
    geom_point(col = "white", alpha = 0.3) +
    geom_smooth(col = "#003300", size = 1.5) +
    xlim(1910, 2025) +
    labs(
        title = "HORROR MOVIES!",
        subtitle = "Average critics ratings of horror films and relationship over time",
        x = "YEAR", 
        y = "RATING", 
        caption = "Data from IMDB\nCode derived from @danoehm | gradientdescending.com"
    ) +
    theme_minimal() +
    theme(
        text = element_text(family = "swamp-witch", size = 18, color = "#006600"),
        plot.title = element_text(size = 48, hjust = 0.5),
        plot.subtitle = element_text(family = "montserrat", size = 18, hjust = 0.5, margin = margin(t = 10)),
        plot.caption = element_text(family = "montserrat", size = 8),
        panel.grid = element_line(color = "grey30"),
        axis.title = element_text(size = 26),
        axis.title.y = element_text(margin = margin(r = 15)),
        axis.text = element_text(color = "#006600"),
        plot.background = element_rect(fill = "black")
    )
ggsave("horror-showtext.png", width = 12, height = 7, dpi = 96, type = "cairo")
