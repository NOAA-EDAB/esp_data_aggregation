plot_correlation <- function(bluefish, eco, lag){
  # both data sets must have a column called "Time"
  # the bluefish data should be from assessmentdata::stockAssessmentData
  # the eco data numeric values should be in a column called "Val"
  # the eco data category values should be in a column called "Var"

  bluefish2 <- bluefish %>%
    dplyr::mutate(Time = Time - lag,
                  facet = paste(Metric, Description, Units, sep = "\n"))
  
  data <- dplyr::left_join(bluefish2, eco,
                           by = "Time") %>%
    dplyr::filter(is.na(Var) == FALSE) %>%
    dplyr::group_by(Metric, Var) %>%
    dplyr::mutate(pval = coefficients(summary(lm(Value ~ Val)))[2,4],
                  sig = pval < 0.05)
  
  if(nrow(data) > 0){
    fig <- ggplot(data,
                  aes(x = Val,
                      y = Value,
                      color = sig))+
      geom_line(lty = 2)+
      geom_point()+
      stat_smooth(method = "lm")+
      facet_grid(rows = vars(facet),
                 cols = vars(Var),
                 scales = "free")+
      scale_color_manual(values = c("black", "#B2292E"),
                         name = "Statistically significant\n(p < 0.05)")+
      scale_y_continuous(labels = scales::comma)+
      scale_x_continuous(labels = scales::comma)+
      theme_bw()+
      theme(axis.title = element_blank(),
            legend.position = "bottom")
    
    return(fig)
  } else print("No data under conditions selected")
  
}

#plot_correlation(bluefish = bluefish, 
#                 eco = ecodata::forage_anomaly %>%
#                   dplyr::rename(Val = Value), 
#                 lag = 0)

correlation_data <- function(bluefish, eco, lag){
  bluefish2 <- bluefish %>%
    dplyr::mutate(Time = Time - lag,
                  facet = paste(Metric, Description, Units, sep = "\n"))
  
  data <- dplyr::left_join(bluefish2, eco,
                           by = "Time") %>%
    dplyr::filter(is.na(Var) == FALSE) %>%
    dplyr::group_by(Metric, Var) %>%
    dplyr::mutate(pval = coefficients(summary(lm(Value ~ Val)))[2,4],
                  sig = pval < 0.05) %>%
    dplyr::filter(is.na(sig) == FALSE) # if there are <3 data points, the correlation won't work
  
  # test correlations
  
  if(nrow(data) > 0){
    if(min(data$pval) >= 0.05){
      print("No statistically significant results")
    } else {
      for(i in unique(data$Metric)){
        for(j in unique(data$Var)){
          dat <- data %>%
            dplyr::filter(Metric == i, Var == j)
          
          results <- lm(Value ~ Val, 
                        data = dat) %>%
            summary
          
          if(results[[4]][2,4] < 0.05){
            
            cat('\n\n<!-- -->\n\n')
            
            knitr::kable(
              list(
                results$coefficients %>%
                  round(digits = 2),
                data.frame(Name = c("F-statistic", "df", "R2", "R2-adj"),
                           Value = c(results$fstatistic[1] %>%
                                       round(digits = 2), 
                                     paste(results$fstatistic[2:3], 
                                           collapse = ", "),
                                     results$r.squared %>%
                                       round(digits = 2), 
                                     results$adj.r.squared %>%
                                       round(digits = 2)
                           ))
              ),
              caption = paste(i, j, sep = " vs "), 
              booktabs = TRUE
            ) %>% print()
            
            cat('\n\n<!-- -->\n\n')
            
          }
        }
      }
    }
  } else print("No data under conditions selected")
}

correlation_summary <- function(bluefish, eco, lag){
  bluefish2 <- bluefish %>%
    dplyr::mutate(Time = Time - lag,
                  facet = paste(Metric, Description, Units, sep = "\n"))
  
  data <- dplyr::left_join(bluefish2, eco,
                           by = "Time") %>%
    dplyr::filter(is.na(Var) == FALSE) %>%
    dplyr::group_by(Metric, Var) %>%
    dplyr::mutate(pval = coefficients(summary(lm(Value ~ Val)))[2,4],
                  sig = pval < 0.05,
                  n = length(Val)) %>%
    dplyr::filter(is.na(sig) == FALSE) # if there are <3 data points, the correlation won't work
  
  # test correlations
  
  if(nrow(data) > 0){
    if(min(data$pval) < 0.05){
      
      output <- c()
      
      for(i in unique(data$Metric)){
        
        for(j in unique(data$Var)){
          dat <- data %>%
            dplyr::filter(Metric == i, Var == j)
          
          results <- lm(Value ~ Val, 
                        data = dat) %>%
            summary
          
          if(results[[4]][2,4] < 0.05){
            output <- rbind(output, c(i, 
                                      j, 
                                      length(dat$Metric), # number of points
                                      results$coefficients[2, 1] %>%
                                        signif(digits = 2), # slope
                                      results$coefficients[2, 4] %>%
                                        signif(digits = 2), # p-value
                                      results$adj.r.squared %>%
                                        round(digits = 2))) # adjusted r2
          }
        }
      }
      
      return(output)
    }
  }
}

render_indicator <- function(test){
  res <- knitr::knit_child(here::here("R/Bluefish", "bluefish-child-doc.Rmd"), 
                           quiet = TRUE)
  cat(res, sep = '\n')
}