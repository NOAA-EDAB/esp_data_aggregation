#' Plot temperature anomalies from `ecodata`
#'
#' This function plots stock-level temperature anomalies from `ecodata`
#'
#' @param data `ecodata` temperature anomaly information (`ecodata::ESP_seasonal_oisst_anom`), filtered to the species of interest
#' @return A ggplot
#' @export


plot_temp_anom <- function(data){
  if(nrow(data) > 0){
    fig <- ggplot2::ggplot(data,
                           ggplot2::aes(x = Time,
                                        y = Value))+
      ggplot2::geom_point(cex = 2) +
      ggplot2::geom_line() +
      ggplot2::facet_grid(rows = ggplot2::vars(ESP),
                          cols = ggplot2::vars(Var)) +
      ecodata::geom_gls()+
      ggplot2::theme_bw() +
      ggplot2::xlab("Year") +
      ggplot2::ylab("Temperature Anomaly (degrees C)")
    
    return(fig)
  } else("NO DATA")
}

#' Plot species-level data from `ecodata`
#'
#' This is a generic function to plot species-level data from `ecodata`
#'
#' @param data `ecodata` data aggregated at the species level, filtered to the species of interest
#' @return A ggplot
#' @export


plot_ecodata <- function(data, ylabel = ""){
  if(nrow(data) > 0){
    fig <- ggplot2::ggplot(data,
                           ggplot2::aes(x = Time,
                                        y = Value))+
      ggplot2::geom_point(cex = 2) +
      ggplot2::geom_line() +
      ggplot2::facet_grid(rows = ggplot2::vars(ESP),
                          cols = ggplot2::vars(Var)) +
      # add if statement to check N > 30
      ecodata::geom_gls()+
      ggplot2::theme_bw() +
      ggplot2::xlab("Year") +
      ggplot2::ylab(ylabel)
    
    return(fig)
  } else("NO DATA")
}
