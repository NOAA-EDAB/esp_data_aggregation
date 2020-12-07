source(here::here("R/full_report_functions", "get_survdat_info.R"))

get_len_data <- function(x){
  y <- dplyr::filter(x, LENGTH > 0, ABUNDANCE > 0)
  
  y <- y %>% dplyr::group_by(YEAR, SEASON) %>%
      dplyr::summarise(mean_len = mean(LENGTH),
                       min_len = min(LENGTH),
                       max_len = max(LENGTH)
                       )
  
  y <- tidyr::pivot_longer(y, cols = c("mean_len", "min_len", "max_len"))
  return(y)
}

plot_len <- function(x, season) {
  
  y <- dplyr::filter(x, SEASON == season)
  
  fig <- ggplot(y,
                aes(x = as.numeric(YEAR),
                    y = value,
                    color = name))+
    geom_line()+
    geom_point(cex = 2)+
    nmfspalette::scale_color_nmfs("regional web", 
                                  name = "",
                                  label = c("max", "mean", "min"))+
    theme_bw()+
    xlab("Year")+
    ylab("Length")+
    labs(title = season)

  if (sum(is.na(y$value) == FALSE) >= 90) 
  {fig <- fig + ecodata::geom_gls()} 

  return(fig)
}

generate_len_info <- function(x, ytitle){

  data <- get_len_data(x)
  
  spring_fig <- plot_len(data, season = "SPRING")
  
  fall_fig <- plot_len(data, season = "FALL")
  
  tbl_data <- get_var_data(x, variable = "LENGTH")
  
  table <- rbind(data_summary(tbl_data, season = "SPRING"),
                 data_summary(tbl_data, season = "FALL"))
  
  colnames(table) <- c("SEASON", "YEARS", "N_YEARS", "MEAN", "SD", "MIN", "MAX")
  
  print(spring_fig)
  print(fall_fig)
  return(knitr::kable(table))
}