`%>%` <- dplyr::`%>%`
library(ggplot2)

load(here::here("data", "allfh.RData"))

class(allfh)
head(allfh)

colnames(allfh)

data <- allfh %>% dplyr::select(pdcomnam, svspp, gensci, pdswgt, year, season)
head(data)
 
test <- data %>% dplyr::filter(svspp == 72 & pdswgt > 0)

ggplot(test,
       aes(x = gensci))+
  geom_histogram(stat = "count")
unique(test$gensci)

ggplot(test,
       aes(x = gensci,
           y = pdswgt))+
  geom_bar(stat = "identity")
min(test$pdswgt)

normalized <- test %>%
  dplyr::group_by(year, season, gensci) %>%
  dplyr::summarise(total_weight = sum(pdswgt)) %>%
  dplyr::mutate(proportion = total_weight/sum(total_weight))
normalized

sum(dplyr::filter(normalized, year == 1973, season == "FALL")$proportion)

ggplot(normalized,
       aes(x = year,
           y = proportion,
           color = gensci))+
  geom_line()+
  geom_point(cex = 2)+
  facet_grid(rows = vars(season))
