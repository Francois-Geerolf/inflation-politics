
library(tidyverse)
library(eurostat)


load("colors.RData")
load("PRICES_CPI.RData")
load("PRICES_CPI_var2.RData")
# Inflation en France vs. Allemagne

graphique1 <- PRICES_CPI %>%
  filter(date <= as.Date("2022-05-01")) %>%
  select(date, LOCATION, obsValue) %>%
  mutate(obsValue = obsValue / 100) %>%
  left_join(PRICES_CPI_var$LOCATION, by = "LOCATION") %>%
  mutate(Location2 = ifelse(LOCATION == "DEU", "Allemagne", Location)) %>%
  ggplot(.) + geom_line(aes(x = date, y = obsValue, color = Location2, linetype = Location2)) + 
  scale_color_manual(values = c("#000000", "#ED2939")) +
  ggimage::geom_image(data = . %>%
                        group_by(date) %>%
                        filter(n() == 2) %>%
                        arrange(obsValue) %>%
                        mutate(dist = min(obsValue[2]-obsValue[1])) %>%
                        arrange(-dist, date) %>%
                        head(2) %>%
                        mutate(image = paste0("flags/", str_to_lower(gsub(" ", "-", Location)), ".png")),
                      aes(x = date, y = obsValue, image = image), asp = 1.5) +
  theme(legend.position = "none") +
  scale_linetype_manual(values = c("dashed", "solid")) +
  theme_minimal() + xlab("") + ylab("Inflation, Glissement sur un an (%)") +
  scale_x_date(breaks = seq(1960, 2100, 5) %>% paste0("-01-01") %>% as.Date,
               labels = date_format("%Y")) +
  theme(legend.position = c(0.7, 0.9),
        legend.title = element_blank(),
        plot.caption = element_text(hjust = 0)) +
  labs(caption = "Source: Données de l'OCDE (28 juin 2022)") +
  scale_y_continuous(breaks = 0.01*seq(-100, 200, 1),
                     labels = percent_format(acc = 1))

graphique1
ggsave(graphique1, file = "graphique1.pdf", bg = "white", width = 7, height = 4)
ggsave(graphique1, file = "graphique1.png", bg = "white", width = 7, height = 4)
ggsave(graphique1, file = "graphique1.svg", bg = "white", width = 7, height = 4)

