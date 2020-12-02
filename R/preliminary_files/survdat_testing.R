# initial survdat data processing
# developing code for Rmarkdown template

library(ggplot2)

data <- readRDS(here::here("data", "survdat.RDS"))
data <- tibble::as.tibble(data$survdat)
head(data)

unique(data$CRUISE6)

# group by cruise, species, season
# plot year vs. surftemp, surfsalin, bottomtemp, botsalin, abundance, biomass, length

list_data <- split(data, 
                   f = list(data$SVSPP, 
                            data$SEASON),
                   drop = TRUE)
head(list_data)
head(list_data[[1]])

# surface temp
variable <- "SURFTEMP"
ytitle <- "Surface temperature"
ggplot(data[data$SVSPP == "000",],
       aes(x = as.numeric(YEAR),
           y = get(variable)))+
  geom_point()+
  stat_smooth()+
  #ecodata::geom_gls()+ # not working...
  facet_grid(rows = vars(SEASON))+
  theme_bw()+
  xlab("Year")+
  ylab(ytitle)

plot_variable <- function(x, variable, ytitle) {
  fig <- ggplot(x,
         aes(x = as.numeric(YEAR),
             y = get(variable)))+
    geom_point()+
    stat_smooth()+
    #ecodata::geom_gls()+ # not working...
    facet_grid(rows = vars(SEASON))+
    theme_bw()+
    xlab("Year")+
    ylab(ytitle) 
  
  return(fig)
}
plot_variable(data[data$SVSPP == "000",],
              variable = "SURFTEMP", 
              ytitle = "Surface temperature")





