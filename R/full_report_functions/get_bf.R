plot_bbmsy <- function(x, ytitle, lin = lines, col = colors) {

  fig <- ggplot(x,
                aes(x = B.Year,
                    y = B.Bmsy,
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
  
  ecodat <- x %>%
    dplyr::select(B.Bmsy, B.Year, Region) %>%
    dplyr::filter(B.Bmsy > 0, B.Year > 0) %>%
    dplyr::group_by(Region) %>%
    dplyr::mutate(num = length(B.Bmsy)) %>%
    dplyr::filter(num > 30)
  
  if (length(ecodat$B.Bmsy) > 1) {
    fig <- fig + 
      ecodata::geom_gls(inherit.aes = FALSE,
                        data = ecodat,
                        mapping = aes(x = B.Year,
                                      y = B.Bmsy,
                                      lty = Region))}
  
  return(fig)
}

plot_ffmsy <- function(x, ytitle, lin = lines, col = colors) {

  fig <- ggplot(x,
                aes(x = F.Year,
                    y = F.Fmsy,
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
  
  ecodat <- x %>%
    dplyr::select(F.Fmsy, F.Year, Region) %>%
    dplyr::filter(F.Fmsy > 0, F.Year > 0) %>%
    dplyr::group_by(Region) %>%
    dplyr::mutate(num = length(F.Fmsy)) %>%
    dplyr::filter(num > 30)
  
  if (length(ecodat$F.Fmsy) > 1) {
    fig <- fig + 
      ecodata::geom_gls(inherit.aes = FALSE,
                        data = ecodat,
                        mapping = aes(x = F.Year,
                                      y = F.Fmsy,
                                      lty = Region))}
  
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