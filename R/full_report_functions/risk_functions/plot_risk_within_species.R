plot_risk_by_stock <- function(data, indicator){
  
  # filter data
  if(indicator != "all"){
    data <- data %>%
      dplyr::mutate(include = Indicator %in% indicator) %>%
      dplyr::filter(include == TRUE)
  }
  
  if(nrow(data) > 0){

    # plot
    for(i in unique(data$Region)){
      
      new_data <- data %>%
        dplyr::filter(Region == i)
      
      if(sum(new_data$norm_rank == 0.5) != nrow(new_data)){
        fig <- ggplot(new_data,
                      aes(x = Year %>% as.numeric,
                          y = Indicator %>% 
                            stringr::str_replace_all("_", " "),
                          fill = norm_rank ))+
          geom_raster(stat = "identity")+
          theme_bw()+
          scale_fill_gradient2(high = "darkred", 
                               mid = "beige", 
                               low = "forestgreen", 
                               midpoint = 0.5,
                               name = "Normalized rank",
                               breaks = c(0, 0.5, 1),
                               limits = c(0, 1))+
          theme(legend.position = "bottom")+
          ylab("Indicator")+
          xlab("Year")+
          labs(title = "Within-stock risk over time",
               subtitle = i)
        
        n_category <- data$category %>% unique() %>% length()
        if(n_category > 1){
          fig <- fig +
            facet_grid(rows = vars(category),
                       scales = "free_y",
                       space = "free_y")
        }
        
        return(fig) 
      } else print("NO DATA")
      
    }
    
  } else print("NO DATA")
  
}

