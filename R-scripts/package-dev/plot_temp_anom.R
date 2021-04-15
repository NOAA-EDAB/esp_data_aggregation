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
      ggplot2::facet_grid(rows = ggplot2::vars(Pattern_check %>%
                                                 stringr::str_wrap(20)),
                          cols = ggplot2::vars(Var)) +
      ggplot2::theme_bw() +
      ggplot2::xlab("Year") +
      ggplot2::ylab(ylabel)
    
    ecodat <- data %>%
      dplyr::distinct() %>%
      dplyr::group_by(Pattern_check, Var) %>%
      dplyr::mutate(nyear = length(Time)) %>%
      dplyr::filter(nyear > 30)
    
    # add if statement to check N > 30
    if(nrow(ecodat) > 0){
      fig <- fig + ecodata::geom_gls(data = ecodat)
    }
    
    return(fig)
  } else("NO DATA")
}
