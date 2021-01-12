plot_relw<- function(x){
  
  if(nrow(x) > 1){
    ecodat <- x %>% 
      dplyr::group_by(EPU, sex) %>%
      dplyr::mutate(n_year = length(YEAR)) %>%
      dplyr::filter(n_year > 30)
    
    fig <- ggplot(x,
                  aes(x = YEAR,
                      y = MeanCond,
                      color = EPU,
                      shape = sex,
                      lty = sex))+
      geom_line()+
      geom_point()+
      nmfspalette::scale_color_nmfs("regional web")+
      theme_bw()+
      facet_grid(rows = vars(EPU))+
      ylab("Mean relative weight")+
      xlab("Year")
    
    if(length(ecodat$n_year > 1)) {
      fig <- fig + ecodata::geom_gls(inherit.aes = FALSE,
                                     data = ecodat,
                                     aes(x = YEAR,
                                         y = MeanCond,
                                         lty = sex))}
    
    return(fig)
  } else print("NO DATA")
  
}