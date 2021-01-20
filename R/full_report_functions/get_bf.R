plot_msy <- function(x, ytitle, lin = lines, col = colors, type) {
  
  # fix colnames
  x$B.Bmsy <- x$`B/Bmsy`
  x$B.Year <- x$`B Year`
  
  # get data
  year <- x$`Assessment Year`
  Region <- x$Region
  if(type == "b"){
    value <- x$`B/Bmsy`
  } else if(type == "f"){
    value <- x$`F/Fmsy`
  }
  
  data <- data.frame(year = year,
                     value = value,
                     Region = Region)
  
  fig <- ggplot(data,
                aes(x = year,
                    y = value,
                    lty = Region,
                    color = Region))+
    geom_point(cex = 2)+
    geom_line()+
    theme_bw()+
    xlab("Year")+
    ylab(ytitle)+
    theme(legend.position = "bottom")+
    scale_linetype_manual(values = lin)+
    scale_color_manual(values = col)
  
  ecodat <- data %>%
    dplyr::filter(value > 0, year > 0) %>%
    dplyr::group_by(Region) %>%
    dplyr::mutate(num = length(value)) %>%
    dplyr::filter(num > 30)
  
  if (length(ecodat$value) > 1) {
    fig <- fig + 
      ecodata::geom_gls(inherit.aes = FALSE,
                        data = ecodat,
                        mapping = aes(x = year,
                                      y = value,
                                      lty = Region))}
  
  return(fig)
}

status <- function(data, regions, metric){
  
  data <- dplyr::filter(data, Region == regions)
  
  if(metric == "bbmsy") {data <- data$`B/Bmsy`}
  if(metric == "ffmsy") {data <- data$`F/Fmsy`}
  
  if(sum(is.na(data)) == length(data)){
    data_info <- "MISSING"} else data_info <- "PRESENT"
    
    data <- data[is.na(data) == FALSE]
    
    if(data_info == "PRESENT"){
      if(metric == "bbmsy"){
        data_status <- if(tail(data, n = 1) > 1) "GOOD" else "DANGER"
      }
      if(metric == "ffmsy"){
        data_status <- if(tail(data, n = 1) > 1) "DANGER" else "GOOD"
      }
      
    } else data_status <- "UNKNOWN"
    
    return(data_status)
}