get_latlong <- function(x, data, shapefile){
  
  range_coord <- c()
  
  data <- dplyr::filter(data, Species == x)
  
  for(i in unique(data$Region)){
    
    for(j in unique(data$stock_season)){
      
      data2 <- data %>% dplyr::filter(stock_season == j, Region == i)
      
      if(nrow(data2) > 0){
        
        log_statement <- paste("STRATA == ", unique(data2$strata), collapse = " | ")
        
        strata <- dplyr::filter(shapefile, eval(parse(text = log_statement)))
        
        temp <- c(i, j, round(sf::st_bbox(strata), digits = 2))
        
        missing_data <- match(unique(data2$strata), unique(shapefile$STRATA)) %>% 
          is.na() %>% sum()
        
        if(missing_data == 0) {warning <- "none"}
        if(missing_data > 0) {warning <- "shapefile is missing some strata data"}
        
        range_coord <- rbind(range_coord, c(temp, warning))
        
      }
    }
  }
  
  if(length(range_coord) > 0) {
    colnames(range_coord) <- c("Region", "Season", "Lat_min", 
                               "Long_min", "Lat_max", "Long_max", "Warning")
  }
  
  return(range_coord)
}