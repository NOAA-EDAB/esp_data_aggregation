get_var_data <- function(x, variable){
  y <- dplyr::filter(x, get(variable) > 0, ABUNDANCE > 0)
  
  # mean by year
  if(variable == "BIOMASS" | variable == "ABUNDANCE"){
    y <- y %>% dplyr::group_by(YEAR, SEASON) %>%
      dplyr::summarise(variable2 = sum(get(variable)))
  } else {
    y <- y %>% dplyr::group_by(YEAR, SEASON) %>%
      dplyr::summarise(variable2 = mean(get(variable)))
  }
  
  colnames(y) <- c("YEAR", "SEASON", "variable")
  
  return(y)
}

plot_variable <- function(x, ytitle) {

  fig <- ggplot(x,
                aes(x = as.numeric(YEAR),
                    y = variable,
                    color = SEASON))+
    geom_point(cex = 2)+
    geom_line()+
    nmfspalette::scale_color_nmfs("regional web")+
    theme_bw()+
    xlab("Year")+
    ylab(ytitle)+
    theme(legend.position = "bottom")
  
  ecodat <- x %>%
    dplyr::filter(YEAR > 0, variable > 0) %>%
    dplyr::group_by(SEASON) %>%
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

data_summary <- function(x, season) {
  
  season_data <- dplyr::filter(x, SEASON == season)
  
  year_data <- format_numbers(season_data$YEAR)
  
  variable_data <- format_numbers(season_data[,3])
  
  all_data <- c(paste(min(year_data), max(year_data), sep = " - "),
                length(year_data),
                round(mean(variable_data, na.rm = TRUE), digits = 2),
                round(sd(variable_data, na.rm = TRUE), digits = 2),
                round(min(variable_data, na.rm = TRUE), digits = 2),
                round(max(variable_data, na.rm = TRUE), digits = 2))
  
  z <- dplyr::filter(season_data, YEAR > (max(year_data) - 5))
  
  five_year_data <- format_numbers(z$YEAR)
  five_variable_data <- format_numbers(z[,3])
  
  five_data <- c(paste(min(five_year_data), max(five_year_data), sep = " - "),
                 length(five_year_data),
                 round(mean(five_variable_data, na.rm = TRUE), digits = 2),
                 round(sd(five_variable_data, na.rm = TRUE), digits = 2),
                 round(min(five_variable_data, na.rm = TRUE), digits = 2),
                 round(max(five_variable_data, na.rm = TRUE), digits = 2))
  
  output <- rbind(c(season, all_data), c(season, five_data))
  
  return(output)
}

generate_info <- function(x, ytitle, variable){
  
  data <- get_var_data(x, variable = variable)
  
  fig <- plot_variable(data, ytitle = ytitle)
  
  table <- rbind(data_summary(data, season = "SPRING"),
                 data_summary(data, season = "FALL"))
  
  colnames(table) <- c("SEASON", "YEARS", "N_YEARS", "MEAN", "SD", "MIN", "MAX")
  
  print(fig)
  return(knitr::kable(table))
}