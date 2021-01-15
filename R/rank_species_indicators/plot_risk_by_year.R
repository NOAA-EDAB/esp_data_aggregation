plot_risk_by_year <- function(data, indicator){

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
    fig <- ggplot(data,
                  aes(x = new_year %>% as.numeric,
                      y = Indicator %>% 
                        stringr::str_replace_all("_", " "),
                      fill = norm_rank ))+
      geom_raster(stat = "identity")+
      facet_grid(rows = vars(category),
                 scales = "free_y",
                 space = "free_y")+
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
      labs(title = "Risk over time")
    
    return(fig)
  } else print("NO DATA")
  
}


