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

plot_correlation <- function(bluefish, eco, lag){
  bluefish2 <- bluefish %>%
    dplyr::mutate(Time = Time + lag)
  
  data <- dplyr::left_join(bluefish2, eco,
                           by = "Time") %>%
    dplyr::filter(is.na(Var) == FALSE) %>%
    dplyr::group_by(Metric, Var) %>%
    dplyr::mutate(pval = coefficients(summary(lm(Value ~ Val)))[2,4],
                  sig = pval < 0.05)

  fig <- ggplot(data,
                aes(x = Val,
                    y = Value,
                    color = sig))+
    geom_line(lty = 2)+
    geom_point()+
    stat_smooth(method = "lm")+
    facet_grid(rows = vars(Metric),
               cols = vars(Var),
               scales = "free")+
    scale_color_manual(values = c("black", "#B2292E"),
                       name = "Statistically significant\n(p < 0.05)")+
    theme_bw()+
    theme(axis.title = element_blank(),
          legend.position = "bottom")
  
  # test correlations

  for(i in unique(data$Metric)){
    for(j in unique(data$Var)){
      dat <- data %>%
        dplyr::filter(Metric == i, Var == j)

      results <- lm(Value ~ Val, 
                    data = dat) %>%
        summary

      if(results[[4]][2,4] < 0.05){
        print(paste(i, j, sep = " vs "))
        print(results)
      }
    }
  }
  
  return(fig)
}

plot_correlation(bluefish = bluefish, 
                 eco = ecodata::cold_pool, 
                 lag = 0)

plot_correlation(bluefish = bluefish, 
                 eco = ecodata::heatwave %>%
                   dplyr::rename(Val = Value), 
                 lag = 0)

plot_correlation(bluefish = bluefish, 
                 eco = ecodata::bottom_temp_glorys %>%
                   dplyr::rename(Val = Value), 
                 lag = 0)

plot_correlation(bluefish = bluefish, 
                 eco = ecodata::forage_anomaly %>%
                   dplyr::rename(Val = Value), 
                 lag = 0)

