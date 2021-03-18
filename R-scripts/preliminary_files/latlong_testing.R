`%>%` <- dplyr::`%>%`

# find min and max latitude

data <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
crs <-  "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" 

head(data)
unique(data$stock_area)

# create stock regions to match other data
unique(data$stock_area)
#Region == "Gulf of Maine / Georges Bank" |
  Region == "Eastern Georges Bank" |
#  Region == "Georges Bank" |
#  Region == "Gulf of Maine" |
  Region == "Gulf of Maine / Cape Hatteras" |
#  Region == "Georges Bank / Southern New England" |
#  Region == "Southern New England / Mid" |
#  Region == "Gulf of Maine / Northern Georges Bank" |
#  Region == "Southern Georges Bank / Mid" |
#  Region == "Cape Cod / Gulf of Maine"

Region <- c()
for(i in 1:length(data$stock_area)){
  if(data$stock_area[i] == "gbk") {Region[i] <- "Georges Bank"}
  if(data$stock_area[i] == "gom") {Region[i] <- "Gulf of Maine"}
  if(data$stock_area[i] == "snemab") {Region[i] <- "Southern New England / Mid"}
  if(data$stock_area[i] == "gbkgom") {Region[i] <- "Gulf of Maine / Georges Bank"}
  if(data$stock_area[i] == "ccgom") {Region[i] <- "Cape Cod / Gulf of Maine"}
  if(data$stock_area[i] == "south") {Region[i] <- "Southern Georges Bank / Mid"}
  if(data$stock_area[i] == "north") {Region[i] <- "Gulf of Maine / Northern Georges Bank"}
  if(data$stock_area[i] == "sne") {Region[i] <- "Georges Bank / Southern New England"}
  if(data$stock_area[i] == "unit") {Region[i] <- "all"}
}
data$Region <- Region

data$Species <- stringr::str_to_sentence(data$COMNAME)

write.csv(data, file = here::here("data", "geo_range_data.csv"))

shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
head(shape)

dplyr::filter(shape, STRATA == 3820) %>% sf::st_bbox()

# pull out min/max coordinates
sf::st_bbox(shape)

get_strata <- function(x, data, shapefile){
  
  range_coord <- c()
  
  data <- dplyr::filter(data, Species == x)
  
  for(i in unique(data$Region)){
    
    for(j in unique(data$season_)){
      
      data2 <- data %>% dplyr::filter(season_ == j, Region == i)

      if(length(data2[,1]) > 0){
        
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

get_strata(x = list_species[2], data = data, shapefile = shape)

list_species <- split(unique(data$Species), f = list(unique(data$Species)))
# goosefish (#16) - strata 1350 is not in shapefile

coord_summary <- purrr::map(list_species, 
                            ~get_strata(.x, data = data, shapefile = shape))

coord_summary

lil <- dplyr::filter(data, Species == list_species[2])

lil %>% dplyr::group_by(season_, Region) %>% dplyr::summarise()

match(unique(lil$strata), unique(shape$STRATA)) %>% 
  is.na() %>% sum()

which(shape$STRATA == 1350)

cbind(sort(unique(lil$strata)),
      sort(unique(shape$STRATA))[c(2:3, 6:7, )])
