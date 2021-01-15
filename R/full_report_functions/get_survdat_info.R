get_var_data <- function(x, variable){
  # remove NA, zero abundance, length 
  y <- x %>% dplyr::filter(get(variable) > 0, ABUNDANCE > 0) %>%
    dplyr::select(YEAR, SEASON, Region, fish_id, date, variable) %>%
    dplyr::distinct() # remove repeated row info
  
  # mean by year
  if(variable == "BIOMASS" | variable == "ABUNDANCE"){
    y <- y %>% dplyr::group_by(YEAR, SEASON, Region) %>% 
      dplyr::summarise(variable2 = sum(get(variable))) %>%
      dplyr::select(YEAR, SEASON, Region, variable2)
  } else {
    y <- y %>% dplyr::group_by(YEAR, SEASON, Region, fish_id, date) %>%
      dplyr::summarise(variable2 = mean(get(variable))) %>% # mean by day
      dplyr::ungroup() %>%
      dplyr::group_by(YEAR, SEASON, Region) %>%
      dplyr::summarise(variable3 = mean(variable2)) %>% # mean by season-year
      dplyr::select(YEAR, SEASON, Region, variable3)
  }
  
  colnames(y) <- c("YEAR", "SEASON", "Region", "variable")
  
  return(y)
}

get_var_data2 <- function(x, variable){
  # remove NA, zero abundance, length 
  y <- x %>% dplyr::filter(get(variable) > 0, ABUNDANCE > 0) %>%
    dplyr::select(Species, YEAR, SEASON, Region, fish_id, date, variable) %>%
    dplyr::distinct() # remove repeated row info
  
  # mean by year
  if(variable == "BIOMASS" | variable == "ABUNDANCE"){
    y <- y %>% dplyr::group_by(Species, YEAR, SEASON, Region) %>% 
      dplyr::summarise(variable2 = sum(get(variable))) %>%
      dplyr::select(YEAR, SEASON, Species, Region, variable2)
  } else {
    y <- y %>% dplyr::group_by(Species, YEAR, SEASON, Region, fish_id, date) %>%
      dplyr::summarise(variable2 = mean(get(variable))) %>% # mean by day
      dplyr::ungroup() %>%
      dplyr::group_by(Species, YEAR, SEASON, Region) %>%
      dplyr::summarise(variable3 = mean(variable2)) %>% # mean by season-year
      dplyr::select(YEAR, SEASON, Species, Region, variable3)
  }
  
  colnames(y) <- c("YEAR", "SEASON","Species",  "Region", "variable")
  
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
    lines <- c(1:4)
    names(lines) <- c("FALL", "SPRING", "WINTER", "SUMMER")
    
    # override situations where geom_gls doesn't converge
    res <- try({ecodata::geom_gls(inherit.aes = FALSE,
                                  data = ecodat,
                                  mapping = aes(x = as.numeric(YEAR),
                                                y = variable,
                                                group = SEASON,
                                                lty = SEASON))+
        scale_linetype_manual(values = lines)}, silent = TRUE)
    
    if(class(res) != "try-error"){
      fig <- fig + res
      }
    }

  return(fig)
}

format_numbers <- function(x) {as.numeric(as.character(unlist(x)))}

data_summary <- function(x){
  table <- x %>% dplyr::group_by(SEASON, Region) %>%
    dplyr::filter(variable > 0) %>%
    dplyr::summarise(total_years = length(variable),
                     mean_value = mean(variable),
                     sd_value = sd(variable),
                     min_value = min(variable),
                     max_value = max(variable))
  
  return(table)
  
}

data_summary_5yr <- function(x){
  x$YEAR <- as.numeric(x$YEAR)

  table <- x %>%  dplyr::group_by(SEASON, Region) %>%
    dplyr::mutate(max_year = max(YEAR)) %>%
    dplyr::filter(YEAR > max_year - 5,
                  variable > 0) %>%
    dplyr::summarise(mean_value5 = mean(variable),
                     sd_value5 = sd(variable),
                     min_value5 = min(variable),
                     max_value5 = max(variable))
  
  return(table)
  
}

generate_plot <- function(x, ytitle, variable){
  
  data <- get_var_data(x, variable = variable)
  
  if(nrow(data) > 0){
    fig <- plot_variable(data, ytitle = ytitle)
    
    return(fig)
  }
  
  else{print("NO DATA")}
  
}

generate_table <- function(x, variable, cap){
  
  data <- get_var_data(x, variable = variable)
  
  if(nrow(data) > 0){
    table <- data_summary(data)
    table[ , 4:7] <- table[ , 4:7] %>%
      round(digits = 2)
    
    table_5yr <- data_summary_5yr(data)
    table_5yr[ , 3:6] <- table_5yr[ , 3:6] %>%
      round(digits = 2)
    
    total_table <- cbind(table,
                         table_5yr[ , -(1:2)]) %>%
      DT::datatable(rownames = FALSE,
                    colnames = c("Season", "Region", "Total years", "Mean", 
                                 "Standard deviation", "Minimum", "Maximum",
                                 "Mean (past 5 years)", 
                                 "Standard deviation (past 5 years)", 
                                 "Minimum (past 5 years)", 
                                 "Maximum (past 5 years)"),
                    filter = list(position = 'top', 
                                  clear = FALSE),
                    extensions = 'Scroller',
                    caption = cap,
                    options = list(search = list(regex = TRUE),
                                   deferRender = TRUE,
                                   scrollY = 200,
                                   scrollX = TRUE,
                                   scroller = TRUE,
                                   language = list(thousands = ",")))
    
    return(total_table)
  }
  
  else{print("NO DATA")}
  
}

# not used anymore
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