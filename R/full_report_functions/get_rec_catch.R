`%>%` <- dplyr::`%>%`
library(ggplot2)

get_rec_catch <- function(data){

  summary <- data %>%
    dplyr::group_by(mode_fx_f, year) %>%
    dplyr::summarise(total_catch = sum(tot_cat))
  
  # add in zeros
  combo <- expand.grid(year = min(summary$year):max(summary$year),
                       mode_fx_f = unique(summary$mode_fx_f))
  
  summary2 <- dplyr::full_join(summary, combo, 
                               by = c("year" = "year",
                                      "mode_fx_f" = "mode_fx_f")) %>%
    dplyr::mutate(total_catch2 = ifelse(is.na(total_catch), 0, total_catch))
  
  # get order of most important - least important category
  cat <- summary2 %>% dplyr::group_by(mode_fx_f) %>%
    dplyr::summarise(imp = max(total_catch2)) %>%
    dplyr::arrange(dplyr::desc(imp))
  
  summary2$mode_fx_f <- factor(summary2$mode_fx_f, 
                               cat$mode_fx_f)
  
  # plot
  fig <- ggplot(summary2,
                aes(x = year,
                    y = total_catch2,
                    fill = mode_fx_f))+
    geom_area()+
    theme_bw()+
    scale_y_continuous(name = "Total catch (lb)",
                       labels = scales::comma)+
    xlab("Year")+
    ggsci::scale_fill_jco()+
    guides(fill=guide_legend(nrow=2, byrow = TRUE, title = "Category"))+
    theme(legend.position = "bottom")
  
  return(fig)
}