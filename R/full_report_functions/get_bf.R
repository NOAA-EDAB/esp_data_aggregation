plot_bbmsy <- function(x, ytitle) {
  
  fig <- ggplot(x,
                aes(x = B.Year,
                    y = B.Bmsy))+
    geom_point(color = "navyblue", cex = 2)+
    geom_line()+
    theme_bw()+
    xlab("Year")+
    ylab(ytitle)+
    facet_grid(cols = vars(Region))
  
  if (sum(is.na(x$B.Bmsy) == FALSE) >= 30) 
  {fig <- fig + ecodata::geom_gls()}
  
  return(fig)
}

plot_ffmsy <- function(x, ytitle) {
  
  fig <- ggplot(x,
                aes(x = F.Year,
                    y = F.Fmsy))+
    geom_point(color = "navyblue", cex = 2)+
    geom_line()+
    theme_bw()+
    xlab("Year")+
    ylab(ytitle)+
    facet_grid(cols = vars(Region))
  
  if (sum(is.na(x$F.Fmsy) == FALSE) >= 30) 
  {fig <- fig + ecodata::geom_gls()} 
  
  return(fig)
}

status <- function(data, regions, metric){
  
  data <- dplyr::filter(data, Region == regions)
  
  if(metric == "bbmsy") {data <- data$B.Bmsy}
  if(metric == "ffmsy") {data <- data$F.Fmsy}
  
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