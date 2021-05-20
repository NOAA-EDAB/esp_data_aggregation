
DDMMSS_to_DD<-function(df, LAT, LON){
  '%>%' <- magrittr::'%>%'
  
  y<- df %>% tidyr::separate(LAT, into=c("lat.dd","lat.mm","lat.ss"),sep=c(2,4)) %>%
    mutate("lat.d.min"=(as.numeric(lat.mm)/60), "lat.d.sec"=(as.numeric(lat.ss)/3600), "LAT.dd"=(as.numeric(lat.dd)+lat.d.min+lat.d.sec))
  
  x<- df %>% tidyr::separate(LON, into=c("lon.dd","lon.mm","lon.ss"),sep=c(2,4)) %>%
    mutate("lon.d.min"=(as.numeric(lon.mm)/60), "lon.d.sec"=(as.numeric(lon.ss)/3600), "LON.dd"=(as.numeric(lon.dd)+lon.d.min+lon.d.sec))
  
  df$LAT.DD<-y$LAT.dd
  df$LON.DD<-x$LON.dd
  
  return(df)
}

