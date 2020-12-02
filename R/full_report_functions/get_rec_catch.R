`%>%` <- dplyr::`%>%`
library(ggplot2)

get_rec_catch <- function(data){
  
  data <- dplyr::filter(data)
  
  summary <- data %>%
    dplyr::filter(sub_reg_f == "NORTH ATLANTIC") %>%
    dplyr::group_by(mode_fx_f, year) %>%
    dplyr::summarise(total_catch = sum(tot_cat))
  
  fig <- ggplot(summary,
                aes(x = year,
                    y = total_catch,
                    fill = mode_fx_f))+
    geom_area()+
    theme_bw()+
    scale_y_continuous(name = "Total catch (lb)",
                       labels = scales::comma)+
    xlab("Year")+
    labs(fill = "Category")+
    theme(legend.position = "bottom")
  
  return(fig)
  
}