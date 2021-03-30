source("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/R/map_strata.R")
library(ggplot2)
library(dplyr)

map_strata_ecsa <- function(data, species_name){
  
  data <- data %>%
    dplyr::filter(is.na(stock_season) == FALSE)
  
  stock_season <- data$stock_season %>% unique
  
  map_strata(stock_name = species_name, 
             common_name = species_name,
             strata = data,
             stock_season = stock_season,
             save_plot = FALSE)
}

