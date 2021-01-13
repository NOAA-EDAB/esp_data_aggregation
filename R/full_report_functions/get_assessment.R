plot_asmt <- function(x, metric, ytitle, lin = lines, col = colors){
  
  x <- x %>% dplyr::filter(Metric == metric)
  
  if(nrow(x) > 0){
 
    x$facet_var <- paste(x$Description, "\n", x$Units, " (", x$AssessmentYear,
                         ")", sep = "")
    
    # mean by year because some years have two measurements?
    x <- x %>%
      dplyr::group_by(Year, Description, Units, AssessmentYear, Region, 
                      Age, facet_var, Category) %>%
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
      scale_shape_manual(values = c(15:18, 0:14))+
      theme(legend.position = "bottom",
            legend.direction = "vertical",
            #label.hjust = 1 # try next time
      )+
      guides(shape = guide_legend(ncol = 2,
                                  title = "Description, units (assessment year)"),
             fill = FALSE)+ # fill is a dummy aes for geom_gls
      ylab(ytitle)
    
    if(metric != "Catch" &
       x$Category %>% unique() %>% length() <= 2){
      fig <- fig +
        facet_grid(rows = vars(Age),
                   scales = "free_y")
    }
    
    if(metric != "Catch" &
       x$Category %>% unique() %>% length() > 2) {
      fig <- fig + 
        facet_grid(rows = vars(Category),
                   scales = "free_y")
    }
    
    # Category - SSB, mature biomass, etc
    
    ecodat <- x %>%
      dplyr::filter(Year > 0, Value > 0) %>%
      dplyr::group_by(Region, facet_var) %>%
      dplyr::mutate(num = length(Value)) %>%
      dplyr::filter(num > 30) 

    if (nrow(ecodat) > 0) {
      fig <- fig + 
        ecodata::geom_gls(inherit.aes = FALSE,
                          data = ecodat,
                          mapping = aes(x = Year,
                                        y = Value,
                                        lty = Region,
                                        fill = facet_var)) 
      # geom_gls doesn't like group aesthetic, use fill instead
      # fill doesn't affect geom_gls
      # error but still showing output
      # could wrap the if loop with a try() statement if the error breaks some graphs
    }
    return(fig)
  } else print("NO DATA")
  
}

