get_var_data <- function(x, variable){
  # remove NA, zero abundance, length 
  y <- dplyr::filter(x, get(variable) > 0, ABUNDANCE > 0) %>%
    dplyr::select(-LENGTH) %>%
    dplyr::select(-NUMLEN)
  
  # mean by year
  if(variable == "BIOMASS" | variable == "ABUNDANCE"){
    y <- y %>% dplyr::group_by(YEAR, SEASON, Region, date, fish_id) %>%
      dplyr::distinct() %>% # remove repeated row info
      dplyr::ungroup() %>%
      dplyr::group_by(YEAR, SEASON, Region) %>% # re-group
      dplyr::summarise(variable2 = sum(get(variable)))
  } else {
    y <- y %>% dplyr::group_by(YEAR, SEASON, Region, date, fish_id) %>%
      dplyr::distinct() %>% # remove repeated row info
      dplyr::summarise(variable2 = mean(get(variable))) %>% # mean by day
      dplyr::ungroup() %>%
      dplyr::group_by(YEAR, SEASON, Region) %>%
      dplyr::summarise(variable3 = mean(variable2)) # mean by season-year
  }
  
  colnames(y) <- c("YEAR", "SEASON", "Region", "variable")
  
  return(y)
}

plot_variable <- function(x, ytitle) {

  fig <- ggplot(x,
                aes(x = as.numeric(YEAR),
                    y = variable,
                    color = SEASON))+
    geom_point(cex = 2)+
    geom_line()+
    facet_grid(rows = vars(Region))+
    nmfspalette::scale_color_nmfs("regional web")+
    scale_y_continuous(labels = scales::comma)+
    theme_bw()+
    xlab("Year")+
    ylab(ytitle)+
    theme(legend.position = "bottom")
  
  ecodat <- x %>%
    dplyr::filter(YEAR > 0) %>%
    dplyr::group_by(SEASON, Region) %>%
    dplyr::mutate(num = length(variable)) %>%
    dplyr::filter(num > 30)
  
  if (length(ecodat$num) > 1) {
    lines <- c(1, 2)
    names(lines) <- c("FALL", "SPRING")
    
    fig <- fig + 
      ecodata::geom_gls(inherit.aes = FALSE,
                        data = ecodat,
                        mapping = aes(x = as.numeric(YEAR),
                                      y = variable,
                                      group = SEASON,
                                      lty = SEASON))+
      scale_linetype_manual(values = lines)
      }
  
 # if (sum(is.na(x$variable) == FALSE) >= 30) 
  #{fig <- fig + ecodata::geom_gls(aes(lty = SEASON))} 
  
  return(fig)
}

format_numbers <- function(x) {as.numeric(as.character(unlist(x)))}

data_summary <- function(x){
  table <- x %>% dplyr::group_by(SEASON, Region) %>%
    dplyr::summarise(mean_value = paste(mean(variable) %>% 
                                          round(digits = 2) %>%
                                          format(big.mark = ","), 
                                        " +- ",
                                        sd(variable) %>% 
                                          round(digits = 2) %>%
                                          format(big.mark = ","),
                                        " (", 
                                        length(variable), 
                                        ") ", 
                                        sep = ""),
                     
                     range_proportion = paste(min(variable) %>% 
                                                round(digits = 2) %>%
                                                format(big.mark = ","),
                                              max(variable) %>% 
                                                round(digits = 2) %>%
                                                format(big.mark = ","),
                                              sep = " - "))
  
  return(table)
  
}

data_summary_5yr <- function(x){
  x$YEAR <- as.numeric(x$YEAR)

  table <- x %>%  dplyr::group_by(SEASON, Region) %>%
    dplyr::mutate(max_year = max(YEAR)) %>%
    dplyr::filter(YEAR > max_year - 5) %>%
    dplyr::summarise(mean_value = paste(mean(variable) %>% 
                                          round(digits = 2) %>%
                                          format(big.mark = ","), 
                                        " +- ",
                                        sd(variable) %>% 
                                          round(digits = 2) %>%
                                          format(big.mark = ","),
                                        " (", 
                                        length(variable), 
                                        ") ", 
                                        sep = ""),
                     
                     range_value = paste(min(variable) %>% 
                                                round(digits = 2) %>%
                                                format(big.mark = ","),
                                              max(variable) %>% 
                                                round(digits = 2) %>%
                                                format(big.mark = ","),
                                              sep = " - "))
  
  return(table)
  
}

generate_info <- function(x, ytitle, variable){
  
  data <- get_var_data(x, variable = variable)

  fig <- plot_variable(data, ytitle = ytitle)
  
  table <- data_summary(data)
  
  table_5yr <- data_summary_5yr(data)
  
  total_table <- cbind(table[, 1:3],
                       table_5yr[, 3],
                       table[, 4],
                       table_5yr[, 4]) %>%
    knitr::kable(col.names = c("Season", "Region",
                               "Mean value +- SD (n years)",
                               "Mean value +- SD (past 5 years)",
                               "Range (total)",
                               "Range (past 5 years)"))

  print(fig)
  return(total_table)
}