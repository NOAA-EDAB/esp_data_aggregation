plot_asmt <- function(x, metric, ytitle, lin = lines, col = colors){
  
  x <- x %>% dplyr::filter(Metric == metric)
  
  x$facet_var <- paste(x$Description, "\n", x$Units, sep = "")

  fig <- ggplot(x,
                aes(x = Year,
                    y = Value,
                    lty = Region,
                    color = Region))+
    geom_point(cex = 2)+
    geom_line()+
    facet_grid(rows = vars(facet_var))+
    theme_bw()+
    scale_y_continuous(label = scales::comma)+
    scale_linetype_manual(values = lin)+
    scale_color_manual(values = col)+
    theme(legend.position = "bottom")+
    ylab(ytitle)
  
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
                                      y = Value,
                                      lty = Region))
  }
  
  return(fig)
}

