rm(list = ls())
library(tidyverse)
library(scales)

# Inflation, salaires et pouvoir d'achat en France


graphique2
save(graphique2, file = "graphique2.RData")
ggsave(graphique2, file = "graphique2.pdf", bg = "white", width = 7, height = 4)
ggsave(graphique2, file = "graphique2.png", bg = "white", width = 7, height = 4)
ggsave(graphique2, file = "graphique2.svg", bg = "white", width = 7, height = 4)

