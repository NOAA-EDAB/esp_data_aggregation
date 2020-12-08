get_var_data <- function(x, variable){
  y <- dplyr::filter(x, get(variable) > 0, ABUNDANCE > 0)
  
  # mean by year
  if(variable == "BIOMASS" | variable == "ABUNDANCE"){
    y <- y %>% dplyr::group_by(YEAR, SEASON, Region) %>%
      dplyr::summarise(variable2 = sum(get(variable)))
  } else {
    y <- y %>% dplyr::group_by(YEAR, SEASON, Region) %>%
      dplyr::summarise(variable2 = mean(get(variable)))
  }
  
  colnames(y) <- c("YEAR", "SEASON", "Region", "variable")
  
  return(y)
}

plot_variable <- function(x, ytitle) {
  
  x <- x %>% dplyr::filter(variable > 0)

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
    dplyr::summarise(mean_value = paste(mean(variable) %>% round(digits = 2), 
                                             " +- ",
                                             sd(variable) %>% round(digits = 2),
                                             " (", length(variable), ") ", 
                                             sep = ""),
                     
                     range_proportion = paste(min(variable) %>% round(digits = 2),
                                              max(variable) %>% round(digits = 2),
                                              sep = " - "))
  
  return(table)
  
}

generate_info <- function(x, ytitle, variable){
  
  data <- get_var_data(x, variable = variable)

  fig <- plot_variable(data, ytitle = ytitle)
  
  table <- data_summary(data)
  
#  colnames(table) <- c("SEASON", "YEARS", "N_YEARS", "MEAN", "SD", "MIN", "MAX")
  
  print(fig)
  return(knitr::kable(table, 
                      col.names = c("Season", "Region",
                                    "Mean value +- SD (n years)", 
                                    "Range")))
}