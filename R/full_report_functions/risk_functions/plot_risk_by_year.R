plot_risk_by_year <- function(data, indicator, title, include_legend){

  # filter data
  if(indicator[1] != "all"){
    data <- data %>%
      dplyr::filter(Indicator %in% indicator)
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
      
      if(sum(new_data$norm_rank %>% is.na()) != nrow(new_data)){
        fig <- ggplot(new_data,
                      aes(x = new_year %>% as.numeric,
                          y = Indicator %>% 
                            stringr::str_replace_all("_", " "),
                          fill = norm_rank ))+
          geom_raster(stat = "identity")+
          theme_bw()+
          viridis::scale_fill_viridis(limits = c(0, 1),
                                      breaks = c(0, 0.5, 1),
                                      direction = -1,
                                      na.value = "gray90",
                                      name = "Normalized rank")+
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
        
        print(fig)
          
      } else print(paste("No", i, "data"))
      
    }
   
  } else print("NO DATA")
  
}


