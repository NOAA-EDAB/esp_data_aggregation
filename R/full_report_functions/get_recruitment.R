plot_all <- function(x){
  
  max_y <- max(x$Value)
  median_x <- median(unique(x$Year))
  
  x$facet_row <- paste(x$Description, x$Units, sep = "\n")
  
  all_sd <- x %>% dplyr::group_by(Region, facet_row) %>%
    dplyr::summarise(sd_all = sd(Value, na.rm = TRUE) %>% round(digits = 2) %>% prettyNum(big.mark = ","),
                     x_coord = median_x,
                     y_coord = max_y * 0.85)
  
  fig <- ggplot(x,
                aes(x = Year,
                    y = Value))+
    geom_point(color = "navyblue", cex = 2)+
    geom_line()+
    geom_text(data = all_sd,
              aes(x = x_coord,
                  y = y_coord,
                  label = sd_all))+
    geom_text(aes(x = median(Year),
                  y = max(Value) * 0.95,
                  label = "St Dev:"))+
    facet_grid(rows = vars(facet_row),
               cols = vars(Region))+
    theme_bw()+
    labs(title = "All Recruitment Data")+
    scale_y_continuous(label = scales::comma)
  
  if (sum(is.na(x$Value) == FALSE) >= 30) 
  {fig <- fig + ecodata::geom_gls()} 
  
  return(fig)
}

plot_short <- function(x, n = nyear){
  
  min_year <- max(x$Year - n)
  x <- dplyr::filter(x, Year > min_year)
  
  max_y <- max(x$Value)
  median_x <- median(unique(x$Year))
  
  x$facet_row <- paste(x$Description, x$Units, sep = "\n")
  
  all_sd <- x %>% dplyr::group_by(Region, facet_row) %>%
    dplyr::summarise(sd_all = sd(Value, na.rm = TRUE) %>% 
                       round(digits = 2) %>% 
                       prettyNum(big.mark = ","),
                     x_coord = median_x,
                     y_coord = max_y * 0.85)
  
  fig <- ggplot(x,
                aes(x = Year,
                    y = Value))+
    geom_point(color = "navyblue", cex = 2)+
    geom_line()+
    geom_text(data = all_sd,
              aes(x = x_coord,
                  y = y_coord,
                  label = sd_all))+
    geom_text(aes(x = median(Year),
                  y = max(Value) * 0.95,
                  label = "St Dev:"))+
    facet_grid(rows = vars(facet_row),
               cols = vars(Region))+
    theme_bw()+
    labs(title = paste("Last", n, "Years of Recruitment Data"))+
    scale_y_continuous(label = scales::comma)
  
  if (sum(is.na(x$Value) == FALSE) >= 30) 
  {fig <- fig + ecodata::geom_gls()} 
  
  return(fig)
}