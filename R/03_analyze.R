library(tidyverse)
#library(rath)

library(dplyr)
library(ggplot2)

data <- read.csv2(file = "data/df_all_laender.csv",stringsAsFactors = F)

data$region %>% unique

head(data)

dataAGG <- 
  data %>% 
  mutate_at(vars(land),funs(as.character(.))) %>% 
  group_by(mondayDate,land) %>% 
  summarise(value = sum(value,na.rm = T)) %>% 
  filter(!is.na(mondayDate)) %>% 
  group_by(land) %>% 
  mutate(reldiff = value/lag(value),
         logdiff = log(value/lag(value)),
         absdiff = value - lag(value)
         )

ggplot(dataAGG,
       aes(x = mondayDate %>% as.Date(),
           value)
       ) + 
  geom_line() + 
  geom_point(alpha = 0.2,size = 0.5) +
  facet_wrap(~ land,ncol = 1,scales = "free") + 
  ggsave(filename = "test.pdf",device = "pdf",
            width = 5, height = 20, dpi = 1000)
