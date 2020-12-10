source(here::here("R/full_report_functions", "get_survdat_info.R"))

get_len_data <- function(x){
  y <- x %>% dplyr::filter(LENGTH > 0, ABUNDANCE > 0) %>%
    dplyr::group_by(YEAR, SEASON, Region) %>%
    dplyr::mutate(n_fish = sum(NUMLEN)) %>%
    dplyr::filter(n_fish > 10) # only year-season-region with >10 fish
  
  y <- y %>% dplyr::group_by(YEAR, SEASON, Region) %>%
      dplyr::summarise(mean_len = sum(LENGTH*NUMLEN)/sum(NUMLEN),
                       min_len = min(LENGTH),
                       max_len = max(LENGTH)
                       )
  
  y <- tidyr::pivot_longer(y, cols = c("mean_len", "min_len", "max_len"))
  return(y)
}

plot_len <- function(x, season) {
  
  y <- x %>% dplyr::filter(SEASON == season)
  
  fig <- ggplot(y,
                aes(x = as.numeric(YEAR),
                    y = value,
                    color = name))+
    geom_line()+
    geom_point(cex = 2)+
    facet_grid(rows = vars(Region))+
    nmfspalette::scale_color_nmfs("regional web", 
                                  name = "",
                                  label = c("max", "mean", "min"))+
    theme_bw()+
    xlab("Year")+
    ylab("Length")+
    labs(title = season)
  
  ecodat <- y %>%
    dplyr::filter(YEAR > 0) %>%
    dplyr::group_by(Region) %>%
    dplyr::mutate(num = length(value)) %>%
    dplyr::filter(num > 30)

 # if (length(ecodat$num) > 1) {fig <- fig + ecodata::geom_gls()} 

  return(fig)
}

get_len_data_tbl <- function(x){
  x <- x %>% dplyr::filter(LENGTH > 0, ABUNDANCE > 0) %>%
    dplyr::group_by(YEAR, SEASON, Region) %>%
    dplyr::mutate(n_fish = sum(NUMLEN)) %>%
    dplyr::filter(n_fish > 10) # only year-season-region with >10 fish
  
  return(x)
}

len_tbl_data <- function(x){
  x <- x %>% dplyr::group_by(YEAR, SEASON, Region) %>%
    dplyr::mutate(n_fish = sum(NUMLEN)) %>%
    dplyr::filter(n_fish > 10) %>% # only year-season-region with >10 fish
    dplyr::ungroup() %>%
    dplyr::group_by(SEASON, Region) %>%
    dplyr::summarise(mean_len = sum(LENGTH*NUMLEN)/sum(NUMLEN),
                     sd_len = sqrt(sum((LENGTH - mean_len)^2 * NUMLEN) / 
                                     sum(NUMLEN)),
                     n_len = sum(NUMLEN),
                     n_yrs = length(unique(YEAR)),
                     min_len = min(LENGTH),
                     max_len = max(LENGTH)) %>%
    dplyr::ungroup() %>%
    dplyr::group_by(SEASON, Region) %>%
    dplyr::summarise(mean_value = paste(mean_len %>% 
                                          round(digits = 2), 
                                        " +- ",
                                        sd_len %>%
                                          round(digits = 2),
                                        " (", 
                                        n_len %>% format(big.mark = ","), 
                                        ", ",
                                        n_yrs,
                                        ") ", 
                                        sep = ""),
                     
                     range_value = paste(min_len %>% 
                                           round(digits = 2),
                                         max_len %>% 
                                           round(digits = 2),
                                         sep = " - "))
  return(x)
}

len_tbl_data_5yr <- function(x){
  x$YEAR <- as.numeric(x$YEAR)

  x <- x %>% dplyr::group_by(YEAR, SEASON, Region) %>%
    dplyr::mutate(n_fish = sum(NUMLEN)) %>%
    dplyr::filter(n_fish > 10) # only year-season-region with >10 fish
  
  x <- x %>% dplyr::group_by(SEASON, Region) %>%
    dplyr::mutate(max_year = max(YEAR)) %>%
    dplyr::filter(YEAR > max_year - 5) %>%
    dplyr::summarise(mean_len = sum(LENGTH*NUMLEN)/sum(NUMLEN),
                     sd_len = sqrt(sum((LENGTH - mean_len)^2 * NUMLEN) / 
                                     sum(NUMLEN)),
                     n_len = sum(NUMLEN),
                     n_yrs = length(unique(YEAR)),
                     min_len = min(LENGTH),
                     max_len = max(LENGTH)) %>%
    dplyr::ungroup() %>%
    dplyr::group_by(SEASON, Region) %>%
    dplyr::summarise(mean_value = paste(mean_len %>% 
                                          round(digits = 2), 
                                        " +- ",
                                        sd_len %>%
                                          round(digits = 2),
                                        " (", 
                                        n_len %>% format(big.mark = ","), 
                                        ", ",
                                        n_yrs,
                                        ") ", 
                                        sep = ""),
                     
                     range_value = paste(min_len %>% 
                                           round(digits = 2),
                                         max_len %>% 
                                           round(digits = 2),
                                         sep = " - "))
  return(x)
}

generate_len_info <- function(x, ytitle){

  data <- get_len_data(x)
  
  spring_fig <- plot_len(data, season = "SPRING")
  
  fall_fig <- plot_len(data, season = "FALL")
  
  tbl_data <- get_len_data_tbl(x)

  table <- len_tbl_data(tbl_data)
  
  table_5yr <- len_tbl_data_5yr(tbl_data)
  
  total_table <- cbind(table[, 1:3],
                       table_5yr[, 3],
                       table[, 4],
                       table_5yr[, 4]) %>%
    knitr::kable(col.names = c("Season", "Region",
                               "Mean value +- SD (n fish, n years)",
                               "Mean value +- SD (n fish, past 5 years)",
                               "Range (total)",
                               "Range (past 5 years)"))
  
  print(spring_fig)
  print(fall_fig)
  return(total_table)
}