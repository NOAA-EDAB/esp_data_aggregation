plot_com_money <- function(data){
  
  if(nrow(data) > 0){
    # get order of most important - least important state
    cat <- data %>% dplyr::group_by(State) %>%
      dplyr::summarise(imp = max(Dollars_adj)) %>%
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
                      y = Dollars_adj,
                      fill = State))+
      geom_bar(color = "black", stat = "identity")+
      theme_bw()+
      scale_y_continuous(name = "Total revenue (2019 $)",
                         labels = scales::comma)+
      xlab("Year")+
      scale_fill_manual(name = "State",
                        values = plot_colors)+
      guides(fill=guide_legend(nrow=2, byrow = TRUE, title = "State"))+
      theme(legend.position = "bottom")
    
    return(fig)
  } else print("NO DATA")
  
}