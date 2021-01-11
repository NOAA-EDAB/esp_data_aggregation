plot_asmt <- function(x, metric, ytitle, lin = lines, col = colors){
  
  x <- x %>% dplyr::filter(Metric == metric)
  
  # mean by year because some years have two measurements?
  x <- x %>%
    dplyr::group_by(Year, Description, Units, AssessmentYear, Region) %>%
    dplyr::summarise(Value = mean(Value))
  
  x$facet_var <- paste(x$Description, "\n", x$Units, " (", x$AssessmentYear,
                       ")", sep = "")

  fig <- ggplot(x,
                aes(x = Year,
                    y = Value,
                    lty = Region,
                    color = Region,
                    shape = facet_var))+
    geom_point(cex = 2)+
    geom_line()+
   # facet_grid(rows = vars(facet_var))+
    theme_bw()+
    scale_y_continuous(label = scales::comma)+
    scale_linetype_manual(values = lin)+
    scale_color_manual(values = col)+
    theme(legend.position = "bottom",
          legend.direction = "vertical",
          #label.hjust = 1 # try next time
          )+
    guides(shape = guide_legend(ncol = 2,
                                title = "Description, units (assessment year)"))+
    ylab(ytitle)
  
  ecodat <- x %>%
    dplyr::filter(Year > 0, Value > 0) %>%
    dplyr::group_by(Region, Description, Units) %>%
    dplyr::mutate(num = length(Value)) %>%
    dplyr::filter(num > 30)
  
  if (length(ecodat$num) > 1) {
    
    fig <- fig + 
      ecodata::geom_gls(inherit.aes = FALSE,
                        data = ecodat,
                        mapping = aes(x = Year,
                                      y = Value,
                                      lty = Region,
                                      group = AssessmentYear))
  }
  
  return(fig)
}

