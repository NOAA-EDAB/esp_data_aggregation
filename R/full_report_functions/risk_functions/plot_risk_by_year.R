plot_risk_by_year <- function(data, indicator, title, include_legend){

  # filter data
  if(indicator != "all"){
    data <- data %>%
      dplyr::mutate(include = Indicator %in% indicator) %>%
      dplyr::filter(include == TRUE)
  }
  
  if(nrow(data) > 0){
    # format year
    year <- data$Year %>%
      stringr::str_trunc(9, "right", ellipsis = "") %>%
      stringr::str_split_fixed("-", n = 2)
    data$new_year <- year[ , 2]

    # plot
    for(i in unique(data$Region)){
      
      new_data <- data %>%
        dplyr::filter(Region == i)
      
      if(sum(new_data$norm_rank == 0.5) != nrow(new_data)){
        fig <- ggplot(data,
                      aes(x = new_year %>% as.numeric,
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
          theme(legend.position = "top")+
          ylab("Indicator")+
          xlab("Year")+
          labs(title = title,
               subtitle = i)
        
        n_category <- data$category %>% unique() %>% length()
        if(n_category > 1){
          fig <- fig +
            facet_grid(rows = vars(category),
                       scales = "free_y",
                       space = "free_y")
        }
        
        if(include_legend == "no"){
          fig <- fig +
            theme(legend.position = "none")
        }
        
        return(fig)
          
      } else print("NO DATA")
      
    }
   
  } else print("NO DATA")
  
}


