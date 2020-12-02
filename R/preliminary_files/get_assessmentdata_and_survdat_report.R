# read in data from spreadsheets

bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))
recruit <- read.csv(here::here("data", "recruitment_data.csv"))
survey <- read.csv(here::here("data", "survey_data.csv"))
ad <- read.csv(here::here("data", "assessmentdata_ratings.csv"))
latlong <- read.csv(here::here("data", "geo_range_data.csv"))
shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))

all_species <- unique(c(bf$Species, recruit$Species, survey$Species, ad$Species))
list_species <- split(all_species, f = list(all_species))

# render some reports

purrr::map(list_species[1], ~rmarkdown::render(here::here("R/preliminary_files", 
                                                          "assessmentdata_and_survdat_report_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          
                                                          latlong_data = latlong,
                                                          shape = shape,
                                                          
                                                          bf_data = bf,
                                                          
                                                          recruit_data = recruit,
                                                          nyear = 20,
                                                          
                                                          survey_data = survey,
                                                          
                                                          ad_rating_data = ad), 
                                            output_dir = here::here("docs"),
                                            output_file = paste(.x, "_assessmentdata_and_survdat", 
                                                                ".html", sep = "")))

# make summary spreadsheet
#####
results <- purrr::map(test_species, function(x){
  
  data <- ne_data[ne_data$`Stock Name` == x,]
  
  # bbmsy
  bbmsy <- data.frame(year = data$`B Year`, 
                      value = data$'B/Bmsy')

  if(sum(is.na(bbmsy$value)) == length(bbmsy$value)){
    b_data <- "MISSING"
  } else b_data <- "PRESENT"
  
  bbmsy <- bbmsy[is.na(bbmsy$value) == FALSE, ]
  
  if(b_data == "PRESENT"){
    b_status <- if((tail(bbmsy$value, n = 1)) > 1) "GOOD" else "DANGER"
  } else b_status <- "UNKNOWN"

  if(b_data == "PRESENT"){
    b_year <- tail(bbmsy$year, n = 1)
  } else b_year <- "UNKNOWN"
  
  if(b_data == "PRESENT"){
    b_recent <- tail(bbmsy$value, n = 1) %>%
      round(digits = 2)
  } else b_recent <- "UNKNOWN"
  
  #ffmsy
  ffmsy <- data.frame(year = data$`F Year`, 
                      value = data$'F/Fmsy')
  
  if(sum(is.na(ffmsy$value)) == length(ffmsy$value)){
    f_data <- "MISSING"
  } else f_data <- "PRESENT"
  
  ffmsy <- ffmsy[is.na(ffmsy$value) == FALSE, ]
  
  if(f_data == "PRESENT"){
    f_status <- if((tail(ffmsy$value, n = 1)) > 1) "DANGER" else "GOOD"
  } else f_status <- "UNKNOWN"
  
  if(f_data == "PRESENT"){
    f_year <- tail(ffmsy$year, n = 1)
  } else f_year <- "UNKNOWN"
  
  if(f_data == "PRESENT"){
    f_recent <- tail(ffmsy$value, n = 1) %>%
      round(digits = 2)
  } else f_recent <- "UNKNOWN"
  
  # results
  results <- c(b_year, b_recent, b_status, f_year, f_recent, f_status)
  return(results)
}) %>% 
  tibble::as_tibble() %>% 
  t()

colnames(results) <- c("B_year", "B_Bmsy", "B_status", "F_year", "F_Fmsy", "F_status")
results

write.csv(results, file = here::here("data", "bbmsy_ffmsy_summary.csv"))
#####
