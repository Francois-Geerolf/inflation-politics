rm(list = ls())
library(tidyverse)
library(scales)

load("SLS2010_TC01.RData")

figure2 <- SLS2010_TC01 %>%
  filter(SEXE == "Ensemble") %>%
  select(1, 4, 5, 6) %>%
  setNames(c("date",
             "Change in average annual net salary (in %)",
             "Change in the price index (in %)",
             "Change in the purchasing power of the average annual net salary (in %)")) %>%
  gather(variable, value, -date) %>%
  mutate(value = value / 100) %>%
  ggplot + geom_line(aes(x = date, y = value, color = variable, linetype = variable)) +
  theme_minimal() + xlab("") + ylab("") +
  scale_color_manual(values = c("red", "blue", "blue")) +
  scale_linetype_manual(values = c("dashed", "dotdash", "solid")) +
  scale_x_date(breaks = seq(1940, 2025, 10) %>% paste0("-01-01") %>% as.Date,
               labels = date_format("%Y")) +
  scale_y_continuous(breaks = 0.01*seq(-100, 500, 5),
                     labels = percent_format(accuracy = 1),
                     limits = c(-0.05, 0.25)) +
  theme(legend.position = c(0.6, 0.9),
        legend.title = element_blank(),
        plot.caption = element_text(hjust = 0)) +
  labs(caption = "Source: Insee 2013") +
  geom_hline(yintercept = 0, linetype = "dashed")

figure2
save(figure2, file = "figure2.RData")
ggsave(figure2, file = "figure2.pdf", bg = "white", width = 7, height = 4)
ggsave(figure2, file = "figure2.png", bg = "white", width = 7, height = 4)
ggsave(figure2, file = "figure2.svg", bg = "white", width = 7, height = 4)

