plot_com <- function(data){
  
  if(nrow(data) > 0){
    # get order of most important - least important state
    cat <- data %>% dplyr::group_by(State) %>%
      dplyr::summarise(imp = max(Pounds)) %>%
      dplyr::arrange(dplyr::desc(imp))
    
    data$State <- factor(data$State,
                         cat$State)
    
    # assign colors based on nmfs color palette
    
    colors <- read.csv(here::here("data", "com_color_palette.csv"))
    
    plot_colors <- colors$color
    names(plot_colors) <- colors$state_id
    
    # plot
    fig <- ggplot(data,
                  aes(x = Year,
                      y = Pounds,
                      fill = State))+
      geom_bar(color = "black", stat = "identity")+
      theme_bw()+
      scale_y_continuous(name = "Total catch (lb)",
                         labels = scales::comma,
                         sec.axis = sec_axis(trans = ~./2204.6, 
                                             name = "Total catch (metric tons)",
                                             labels = scales::comma))+
      xlab("Year")+
      scale_fill_manual(name = "State",
                        values = plot_colors)+
      guides(fill=guide_legend(nrow=2, byrow = TRUE, title = "State"))+
      theme(legend.position = "bottom")
    
    return(fig)
  } else print("NO DATA")
   
}

