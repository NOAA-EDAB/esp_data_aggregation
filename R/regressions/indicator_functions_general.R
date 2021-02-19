data_prep <- function(stock_data, eco_data, lag_data){
  stock2 <- stock_data %>%
    dplyr::mutate(Time = as.numeric(Time) - lag_data,
                  facet = paste(Metric, Description, Units, sep = "\n"))
  
  eco_data$Time <- as.numeric(eco_data$Time)
  
  data <- dplyr::left_join(stock2, eco_data,
                           by = "Time") %>%
    dplyr::filter(is.na(Var) == FALSE) %>%
    dplyr::group_by(Metric, Var) %>%
    dplyr::filter(Metric != Var) %>% # remove self-correlations
    dplyr::mutate(pval = coef(summary(lm(Value ~ Val,
                                         singular.ok = TRUE)))[2,4] %>% 
                    suppressWarnings()) %>%
    dplyr::mutate(sig = pval < 0.05)
  
  return(data)
}

plot_correlation <- function(stock, eco, lag){
  # both data sets must have a column called "Time"
  # the stock data should be from assessmentdata::stockAssessmentData
  # the eco data numeric values should be in a column called "Val"
  # the eco data category values should be in a column called "Var"

  data <- data_prep(stock_data = stock, 
                    eco_data = eco, 
                    lag_data = lag)
  
  if(nrow(data) > 0){
    
    my_colors <- c("black", "#B2292E")
    names(my_colors) <- c("FALSE", "TRUE")
    
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
      scale_color_manual(values = my_colors,
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

correlation_data <- function(stock, eco, lag){

  data <- data_prep(stock_data = stock, 
                    eco_data = eco, 
                    lag_data = lag) %>%
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

correlation_summary <- function(stock, eco, lag){

  data <- data_prep(stock_data = stock, 
                    eco_data = eco, 
                    lag_data = lag) %>%
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
  res <- knitr::knit_child(here::here("R/regressions", "general-child-doc.Rmd"), 
                           quiet = TRUE)
  cat(res, sep = '\n')
}
