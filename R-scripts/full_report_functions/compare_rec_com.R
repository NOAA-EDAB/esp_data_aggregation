prop_catch <- function(rec, com){
  
  if(nrow(rec) > 0 & nrow(com) > 0){

    rec <- rec %>%
      dplyr::group_by(year) %>%
      dplyr::summarise(tot_catch_rec = sum(lbs_ab1)) %>%
      dplyr::rename("Year" = "year")
    
    com <- com %>%
      dplyr::group_by(Year) %>%
      dplyr::summarise(tot_catch_com = sum(Pounds))
    
    data <- dplyr::full_join(rec, com, by = "Year") %>%
      dplyr::select(Year, tot_catch_rec, tot_catch_com) %>%
      dplyr::filter(is.na(tot_catch_rec) == FALSE &
                      is.na(tot_catch_com) == FALSE) %>%
      dplyr::mutate(total_catch = tot_catch_rec + tot_catch_com,
                    prop_rec = tot_catch_rec/total_catch,
                    prop_com = tot_catch_com/total_catch) %>%
      dplyr::select(Year, prop_rec, prop_com) %>%
      tidyr::pivot_longer(cols = c("prop_rec", "prop_com"))
    
    fig <- ggplot(data,
                  aes(x = Year,
                      y = value,
                      fill = name))+
      geom_bar(color = "black", stat = "identity")+
      theme_bw()+
      nmfspalette::scale_fill_nmfs(palette = "regional web",
                                   name = "Catch",
                                   labels = c("Commercial", "Recreational"))+
      ylab("Proportion of catch")
    
    return(fig)
  } else print("NO DATA")
  
}

prop_catch_data <- function(rec, com){
  if(nrow(rec) > 0 & nrow(com) > 0){
    rec <- rec %>%
      dplyr::group_by(year) %>%
      dplyr::summarise(tot_catch_rec = sum(lbs_ab1)) %>%
      dplyr::rename("Year" = "year")
    
    com <- com %>%
      dplyr::group_by(Year) %>%
      dplyr::summarise(tot_catch_com = sum(Pounds))
    
    data <- dplyr::full_join(rec, com, by = "Year") %>%
      dplyr::select(Year, tot_catch_rec, tot_catch_com) %>%
      dplyr::filter(is.na(tot_catch_rec) == FALSE &
                      is.na(tot_catch_com) == FALSE) %>%
      dplyr::mutate(total_catch = tot_catch_rec + tot_catch_com, 
                    prop_rec = (tot_catch_rec/total_catch) %>%
                      round(digits = 3),
                    prop_com = (tot_catch_com/total_catch) %>%
                      round(digits = 3)) %>%
      dplyr::mutate(tot_catch_rec = tot_catch_rec %>%
                      format(big.mark = ","),
                    tot_catch_com = tot_catch_com %>%
                      format(big.mark = ","),
                    total_catch = total_catch %>%
                      format(big.mark = ","))
    return(data)
  } 

}

