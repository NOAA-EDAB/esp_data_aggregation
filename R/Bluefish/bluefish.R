`%>%` <- dplyr::`%>%`

ecodata::cold_pool
# V_max; Definition: yearly-max cold pool vertical distribution relative to depth; Units: meter/meter.

bluefish <- assessmentdata::stockAssessmentData %>% 
  dplyr::filter(Species == "Bluefish", AssessmentYear == 2019) %>%
  dplyr::rename(Time = Year)

library(ggplot2)

ggplot(ecodata::cold_pool,
       aes(x = Time,
           y = Val,
           color = Var))+
  geom_line()

data <- dplyr::left_join(bluefish, ecodata::cold_pool,
                         by = "Time")

ggplot(data %>%
         dplyr::filter(is.na(Var) == FALSE)
       ,
       aes(x = Val,
           y = Value))+
  geom_line()+
  stat_smooth(method = "lm")+
  facet_grid(rows = vars(Metric),
             cols = vars(Var),
             scales = "free")+
  theme_bw()

data2 <- dplyr::left_join(bluefish %>%
                           dplyr::mutate(Time = Time + 1), # try a lag
                         ecodata::cold_pool,
                         by = "Time")

ggplot(data2 %>%
         dplyr::filter(is.na(Var) == FALSE)
       ,
       aes(x = Val,
           y = Value))+
  geom_line()+
  stat_smooth(method = "lm")+
  facet_grid(rows = vars(Metric),
             cols = vars(Var),
             scales = "free")+
  theme_bw()