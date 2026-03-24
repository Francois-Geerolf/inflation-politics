library(dplyr)
library(eurostat)
library(ggplot2)

source("../../code/R-markdown/init_oecd.R")
load_data("oecd/PRICES_CPI_var2.RData")
load_data("oecd/PRICES_CPI.RData")

# Inflation en France vs. Allemagne

PRICES_CPI %>%
  filter(LOCATION %in% c("FRA", "DEU"),
         SUBJECT %in% c("CPALTT01"),
         FREQUENCY == "M",
         MEASURE == "GY") %>%
  month_to_date %>%
  select(date, LOCATION, obsValue) %>%
  mutate(obsValue = obsValue / 100) %>%
  left_join(PRICES_CPI_var$LOCATION, by = "LOCATION") %>%
  left_join(colors, by = c("Location"  = "country")) %>%
  mutate(Location2 = ifelse(LOCATION == "DEU", "Allemagne", Location)) %>%
  ggplot(.) + geom_line(aes(x = date, y = obsValue, color = Location2, linetype = Location2)) + 
  scale_color_manual(values = c("#000000", "#ED2939")) +
  scale_linetype_manual(values = c("dashed", "solid")) +
  add_2flags +
  theme_minimal() + xlab("") + ylab("Inflation, Glissement sur un an (%)") +
  scale_x_date(breaks = seq(1960, 2100, 5) %>% paste0("-01-01") %>% as.Date,
               labels = date_format("%Y")) +
  theme(legend.position = c(0.7, 0.9),
        legend.title = element_blank()) + 
  scale_y_continuous(breaks = 0.01*seq(-100, 200, 1),
                     labels = percent_format(acc = 1))

graphique1
ggsave(graphique1, file = "graphique1.pdf", bg = "white", width = 7, height = 4)
ggsave(graphique1, file = "graphique1.png", bg = "white", width = 7, height = 4)
ggsave(graphique1, file = "graphique1.svg", bg = "white", width = 7, height = 4)

