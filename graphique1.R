library(dplyr)
library(eurostat)
library(ggplot2)
load_data("eurostat/nama_10_a10.RData")
load_data("eurostat/geo_fr.RData")

# Inflation en France vs. Allemagne

graphique1
ggsave(graphique1, file = "graphique1.pdf", bg = "white", width = 7, height = 4)
ggsave(graphique1, file = "graphique1.png", bg = "white", width = 7, height = 4)
ggsave(graphique1, file = "graphique1.svg", bg = "white", width = 7, height = 4)

