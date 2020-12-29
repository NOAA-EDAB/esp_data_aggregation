
# not sure how survdat deals with seasons 

plot_swept_biomass <- function(x){
  
  fig <- ggplot(x)+
    geom_ribbon(aes(x = YEAR,
                    ymin = tot.biomass - 2*tot.bio.SE,
                    ymax = tot.biomass + 2*tot.bio.SE),
                fill = "gray80")+
    geom_line(aes(x = YEAR,
                  y = tot.biomass),
              cex = 2)+
    theme_bw()+
    scale_y_continuous(name = "Survey biomass estimate",
                       labels = scales::comma)
  
  y <- x %>%
    dplyr::filter(is.na(tot.biomass) == FALSE)
  
  if (nrow(y) > 30) { 
    fig <- fig + 
      ecodata::geom_gls(aes(x = YEAR,
                            y = tot.biomass)) 
    }
  
  return(fig)
}

plot_swept_abun <- function(x){
  
  fig <- ggplot(x)+
    geom_ribbon(aes(x = YEAR,
                    ymin = tot.abundance - 2*tot.abund.SE,
                    ymax = tot.abundance + 2*tot.abund.SE),
                fill = "gray80")+
    geom_line(aes(x = YEAR,
                  y = tot.abundance),
              cex = 2)+
    theme_bw()+
    scale_y_continuous(name = "Survey abundance estimate",
                       labels = scales::comma)
  
  y <- x %>%
    dplyr::filter(is.na(tot.abundance) == FALSE)
  
  if (nrow(y) > 30) { 
    fig <- fig + 
      ecodata::geom_gls(aes(x = YEAR,
                            y = tot.abundance)) 
  }

  return(fig)
}
