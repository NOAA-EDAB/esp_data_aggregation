plot_lw <- function(x){
  
  data <- dplyr::filter(x,
                       is.na(pdlen) == FALSE, 
                       is.na(pdwgt) == FALSE)

  fig <- ggplot(data,
                aes(x = pdlen,
                    y = pdwgt/1000,
                    color =  year))+
    geom_jitter(alpha = 0.5)+
    scale_color_gradientn(colors = nmfspalette::nmfs_palette("regional web")(6),
                          limits = c(1973, 2018))+
    ylab("Weight (kg)")+
    xlab("Length (cm)")+
    theme_bw()
  
  if(unique(data$season) %>% length() > 1 
     & unique(data$decade) %>% length() > 1) {
    fig <- fig + facet_grid(cols = vars(season), rows = vars(decade))
  } else if(unique(data$season) %>% length() == 1 
            & unique(data$decade) %>% length() > 1) {
    fig <- fig + facet_grid(rows = vars(decade))
    }
  
  return(fig)  
}

plot_cond <- function(x){
  
  data <- dplyr::filter(x,
                        season == "FALL" | season == "SPRING",
                        is.na(pdlen) == FALSE, 
                        is.na(pdwgt) == FALSE)
  
  fig <- ggplot(data,
         aes(x = year,
             y = pdwgt/(pdlen^3)))+
    geom_jitter(alpha = 0.5,
                color = nmfspalette::nmfs_palette("regional web")(1))+

    ylab("Weight / Length^3 (g/cm^3)")+
    xlab("Year")+
    labs(title = "Condition factor")+
    theme_bw()
  
  if(unique(data$season) %>% length() > 1) {
    fig <- fig + facet_grid(cols = vars(season))
  }
  
  ecodat <- data %>% 
    dplyr::group_by(year) %>%
    dplyr::summarise(mean_condition = mean(pdwgt/(pdlen^3)))

  if(length(ecodat$year) > 30){
    fig <- fig + 
      ecodata::geom_gls(inherit.aes = FALSE,
                        data = ecodat,
                        mapping = aes(x = year,
                                      y = mean_condition))
  }
  
  return(fig) 
}