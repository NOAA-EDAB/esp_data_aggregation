`%>%` <- dplyr::`%>%`

# find min and max latitude

data <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
crs <-  "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" 

shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
head(shape)

dplyr::filter(shape, STRATA == 3820)

# pull out min/max coordinates
sf::st_bbox(shape)

data <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

species <- unique(species$COMNAME) # %>% stringr::str_to_sentence()

get_strata <- function(x, season, shapefile){
  data <- x %>% dplyr::filter(season_ == season)
  strata <- unique(x$strata)
  
  strata <- dplyr::filter(shapefile, STRATA == strata)
}