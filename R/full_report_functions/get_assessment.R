plot_asmt <- function(x, metric, ytitle, lin = lines, col = colors){
  
  if(nrow(x) > 0){
    
    x <- x %>% dplyr::filter(Metric == metric)
    
    x$facet_var <- paste(x$Description, "\n", x$Units, " (", x$AssessmentYear,
                         ")", sep = "")
    
    # mean by year because some years have two measurements?
    x <- x %>%
      dplyr::group_by(Year, Description, Units, AssessmentYear, Region, Age, facet_var) %>%
      dplyr::summarise(Value = mean(Value))
    
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
    
    if(metric != "Catch"){
      fig <- fig +
        facet_grid(rows = vars(Age),
                   scales = "free_y")
    }
    
    ecodat <- x %>%
      dplyr::filter(Year > 0, Value > 0) %>%
      dplyr::group_by(Region, facet_var) %>%
      dplyr::mutate(num = length(Value)) %>%
      dplyr::filter(num > 30) 
    
   # ecodat %>% dplyr::select(Year, Region, Value, facet_var) %>% View
    # breaking on goosefish
    
    if (nrow(ecodat) > 0 & 
        (ecodat$facet_var %>% unique %>% length) > 1) {
      
      fig <- fig + 
        ecodata::geom_gls(inherit.aes = FALSE,
                          data = ecodat,
                          mapping = aes(x = Year,
                                        y = Value,
                                        lty = Region,
                                        group = facet_var))
    }
    
    if (nrow(ecodat) > 0 & 
        (ecodat$facet_var %>% unique %>% length) == 1) {
      
      fig <- fig + 
        ecodata::geom_gls(inherit.aes = FALSE,
                          data = ecodat,
                          mapping = aes(x = Year,
                                        y = Value,
                                        lty = Region))
    }
    
    return(fig)
  } else print("NO DATA")
  
}

