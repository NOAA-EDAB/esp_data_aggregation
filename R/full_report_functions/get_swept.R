
# not sure how survdat deals with seasons 

plot_swept <- function(x, var){
  
  if(var == "biomass") {
    x <- x %>%
      dplyr::rename(value = tot.biomass,
                    error = tot.bio.SE)
    name <- "Survey biomass estimate (kg)"
  }
    
  if(var == "abundance") {
    x <- x %>%
      dplyr::rename(value = tot.abundance,
                    error = tot.abund.SE)

    name <- "Survey abundance estimate"
  }
    
  if(nrow(x) > 0){
    fig <- ggplot(x)+
      geom_ribbon(aes(x = YEAR,
                      ymin = value - 2*error,
                      ymax = value + 2*error,
                      fill = Season),
                  alpha = 0.5)+
      geom_line(aes(x = YEAR,
                    y = value,
                    color = Season),
                cex = 2)+
      nmfspalette::scale_color_nmfs("regional web")+
      nmfspalette::scale_fill_nmfs("regional web")+
      theme_bw()+
      scale_y_continuous(name = name,
                         labels = scales::comma)
    
    y <- x %>%
      dplyr::filter(is.na(value) == FALSE)
    
    if (nrow(y) > 30) { 
      fig <- fig + 
        ecodata::geom_gls(aes(x = YEAR,
                              y = value,
                              color = Season)) 
    }
    
    return(fig)
    
  } else print("NO DATA")

}

