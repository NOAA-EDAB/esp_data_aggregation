plot_recruit <- function(x, n, lin = lines, col = colors){
  
  if(n == "all"){x <- x} else {
    min_year <- max(x$Year - n)
    x <- dplyr::filter(x, Year > min_year)
  }
  
  x$Units <- paste("log", x$Units)
  
  fig <- ggplot(x,
                aes(x = Year,
                    y = log(Value),
                    lty = Region,
                    color = Region))+
    geom_point(cex = 2)+
    geom_line()+
    facet_grid(rows = vars(Units),
               scales = "free_y")+
    theme_bw()+
    labs(title = paste("Past", n, "years recruitment data"))+
    scale_y_continuous(label = scales::comma)+
    scale_linetype_manual(values = lin)+
    scale_color_manual(values = col)+
    theme(legend.position = "bottom")+
    ylab("log(Abundance)")
  
  ecodat <- x %>%
    dplyr::filter(Year > 0, Value > 0) %>%
    dplyr::group_by(Region, Units) %>%
    dplyr::mutate(num = length(Value)) %>%
    dplyr::filter(num > 30)
  
  if (length(ecodat$num) > 1) {

    fig <- fig + 
      ecodata::geom_gls(inherit.aes = FALSE,
                        data = ecodat,
                        mapping = aes(x = Year,
                                      y = log(Value),
                                      lty = Region))
  }
  
  return(fig)
}

