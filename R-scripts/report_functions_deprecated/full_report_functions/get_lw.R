plot_lw <- function(x){
  
  data <- x %>%
    dplyr::filter(is.na(pdlen) == FALSE, 
                  is.na(pdwgt) == FALSE) %>%
    dplyr::select(pdlen, pdwgt, season, Region, fish_id, year) %>%
    dplyr::distinct() %>% # remove duplicates
    dplyr::group_by(Region, season) %>%
    dplyr::mutate(n_fish = length(pdlen)) %>%
    dplyr::filter(n_fish > 10) # only region-season with >10 fish
  
  if(nrow(data) > 0){
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
    
    if(unique(data$season) %>% length() > 1) {
      fig <- fig + facet_grid(cols = vars(season), rows = vars(Region))
    } else {fig <- fig + facet_grid(rows = vars(Region))}
    
    return(fig)  
  } else print("NO DATA")
  
}

plot_cond <- function(x){
  
  data <- x %>% 
    dplyr::filter(is.na(pdlen) == FALSE, 
                  is.na(pdwgt) == FALSE) %>%
    dplyr::select(pdlen, pdwgt, season, Region, fish_id, year) %>%
    dplyr::distinct() %>% # remove duplicates
    dplyr::group_by(Region, season) %>%
    dplyr::mutate(n_fish = length(pdlen)) %>%
    dplyr::filter(n_fish > 10) # only region-season with >10 fish
  
  if(nrow(data) > 0){
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
      fig <- fig + facet_grid(cols = vars(season),
                              rows = vars(Region))
    } else { fig <- fig + facet_grid(rows = vars(Region))}
    
    ecodat <- data %>% 
      dplyr::group_by(year, season, Region) %>%
      dplyr::summarise(mean_condition = mean(pdwgt/(pdlen^3))) %>%
      dplyr::ungroup() %>%
      dplyr::group_by(season, Region) %>%
      dplyr::mutate(n_year = length(year)) %>%
      dplyr::filter(n_year > 30)
    
    if(length(ecodat$year) > 1){
      fig <- fig + 
        ecodata::geom_gls(inherit.aes = FALSE,
                          data = ecodat,
                          mapping = aes(x = year,
                                        y = mean_condition))
    }
    
    return(fig) 
  } else print("NO DATA")
 
}