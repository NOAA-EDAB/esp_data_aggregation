`%>%` <- dplyr::`%>%`

# read in data from spreadsheets

bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))
recruit <- read.csv(here::here("data", "recruitment_data.csv"))
survey <- read.csv(here::here("data", "survey_data.csv"))
#ad <- read.csv(here::here("data", "assessmentdata_ratings.csv"))
latlong <- read.csv(here::here("data", "geo_range_data.csv"))
shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))

all_species <- unique(c(bf$Species, recruit$Species, survey$Species, ad$Species))
list_species <- split(all_species, f = list(all_species))

# column order: species, region, season, year, metric, value, units, note


# shape

get_strata2 <- function(x, data, shapefile){
  
  range_coord <- c()

  data <- dplyr::filter(data, Species == x)

  for(i in unique(data$Region)){
    
    for(j in unique(data$season_)){
      
      data2 <- data %>% dplyr::filter(season_ == j, Region == i)
      
      if(length(data2[,1]) > 0){
        
        log_statement <- paste("STRATA == ", unique(data2$strata), collapse = " | ")
        
        strata <- dplyr::filter(shapefile, eval(parse(text = log_statement)))
        
        value <- round(sf::st_bbox(strata), digits = 2)
        
        reps <- length(as.numeric(value))

        temp <- data.frame(Species = rep(unique(data2$Species), reps),
                           Region = rep(i, reps),
                           Season = rep(j, reps), 
                           Year = rep(NA, reps),
                           Metric = c("lat_min", "long_min", "lat_max", "long_max"),
                           Value = as.numeric(value),
                           Units = rep("coordinates_WGS84", reps))
        
        missing_data <- match(unique(data2$strata), unique(shapefile$STRATA)) %>% 
          is.na() %>% sum()
        
        if(missing_data == 0) {Note <- "none"}
        if(missing_data > 0) {Note <- "shapefile is missing some strata data"}
        
        temp2 <- cbind(temp, rep(Note, reps))
        colnames(temp2)[8] <- "Note"
        
        range_coord <- rbind(range_coord, temp2)
        
      }
    }
  }

  return(range_coord)
}

latlong_tidy <- purrr::map(list_species, ~get_strata2(.x, data = latlong, shapefile = shape))

do.call(rbind, latlong_tidy) %>%
  write.csv(file = here::here("data", "latlong_tidy.csv"))

# bf

get_bf <- function(x, data){
  bf <- c()
  
  data <- dplyr::filter(data, Species == x)
  
  b_value <- data$B.Bmsy
  f_value <- data$F.Fmsy
  years <- c(data$B.Year, data$F.Year)
  
  reps <- length(years)
  
  for(i in unique(data$Region)){
    temp <- data.frame(Species = rep(unique(data$Species), reps),
                       Region = rep(i, reps),
                       Season = rep(NA, reps), 
                       Year = years,
                       Metric = c(rep("BBmsy", length(b_value)),
                                  rep("FFmsy", length(f_value))),
                       Value = c(b_value, f_value),
                       Units = rep("ratio", reps),
                       Note = rep(NA, reps))
    bf <- rbind(bf, temp)
  }
  return(bf)
}

bf_tidy <- purrr::map(list_species, ~get_bf(.x, data = bf))

do.call(rbind, bf_tidy) %>%
  write.csv(file = here::here("data", "bbmsy_ffmsy_tidy.csv"))

# recruitment

reps <- length(recruit$Species)
recruit_tidy <- data.frame(Species = recruit$Species,
                           Region = recruit$Region,
                           Season = rep(NA, reps),
                           Year = recruit$Year,
                           Metric = rep("Recruitment", reps),
                           Value = recruit$Value,
                           Units = recruit$Units,
                           Note = recruit$Description)

recruit_tidy %>%
  write.csv(file = here::here("data", "recruit_tidy.csv"))

# assessmentdata

ad_rating_data <- tibble::tibble(Species = ad$Species,
                                 Region = ad$Region,
                                 `Assessment Year` = ad$Assessment.Year,
                                 `Last Data Year` = ad$Last.Data.Year,
                                 `Biological Data Rating (2019)` = ad$Biological.Input.Data,
                                 `Biological Data Rating (before 2019)` = ad$Life.History.Data,
                                 `Size Data Rating` = ad$Composition.Input.Data,
                                 `Ecosystem Linkage Data Rating` = ad$Ecosystem.Linkage,
                                 `FSSI status` = ad$FSSI.Stock.,
                                 `Review Result` = ad$Review.Result)

get_ad <- function(x, data){
  ad <- c()
  
  data <- dplyr::filter(data, Species == x)
  
  years <- data$Assessment.Year
  
  bio_data2019 <- data$Biological.Input.Data
  bio_data <- data$Life.History.Data
  size_data <- data$Composition.Input.Data
  eco_data <- data$Ecosystem.Linkage
  fssi <- data$FSSI.Stock.
  rev_result <- data$Review.Result

  reps <- length(years)
  
  for(i in unique(data$Region)){
    temp <- data.frame(Species = rep(unique(data$Species), reps*6),
                       Region = rep(i, reps*6),
                       Season = rep(NA, reps*6), 
                       Year = rep(years, 6),
                       Metric = c(rep("Bio_data_rating_2019", length(bio_data2019)),
                                  rep("Bio_data_rating", length(bio_data)),
                                  rep("Size_data_rating", length(size_data)),
                                  rep("Eco_link_data_rating", length(eco_data)),
                                  rep("FSSI", length(fssi)),
                                  rep("Review_result", length(rev_result))
                                  ),
                       Value = c(bio_data2019, bio_data, size_data, eco_data,
                                 fssi, rev_result),
                       Units = rep("qualitative", reps*6),
                       Note = rep(NA, reps*6))
    ad <- rbind(ad, temp)
  }
  return(ad)
}

purrr::map(list_species[1], ~get_ad(.x, data = bf))

ad_tidy <- purrr::map(list_species, ~get_ad(.x, data = bf))

do.call(rbind, ad_tidy) %>%
  write.csv(file = here::here("data", "assessmentdata_tidy.csv"))

all_tidy_data <- rbind(do.call(rbind, latlong_tidy), 
                       recruit_tidy, 
                       do.call(rbind, bf_tidy), 
                       do.call(rbind, ad_tidy))
head(all_tidy_data)

all_tidy_data %>% 
  write.csv(file = here::here("data", "all_tidy_data.csv"))
