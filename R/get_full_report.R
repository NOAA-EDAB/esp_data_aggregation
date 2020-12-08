### packages required

## general packages required
# library(dplyr)
# library(ggplot2)
# library(here)
# library(stringr)
# library(sf)
# library(rmarkdown)
# library(tibble)
# library(knitr)
# library(scales)
# library(ecodata)

## required to render reports
# library(purrr) # for automated rendering
# library(parallel) # for automated and parallelized rendering

## required to recreate data
# library(assessmentdata)
# library(survdat) # or a saved data pull

## required to recreate color palettes
# library(grDevices)
# library(nmfspalette)

###

## render automated reports with purrr
#####
`%>%` <- dplyr::`%>%`

# read in data from spreadsheets

bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))

recruit <- read.csv(here::here("data", "recruitment_data.csv"))
recruit$Units <- stringr::str_replace(recruit$Units, "Thousand Recruits", "Number x 1,000")

survey <- read.csv(here::here("data", "survey_data.csv"))

ad <- read.csv(here::here("data", "assessmentdata_ratings.csv"))

latlong <- read.csv(here::here("data", "geo_range_data.csv"))
shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))

rec <- read.csv(here::here("data/MRIP", "all_MRIP_catch_year.csv")) %>%
  dplyr::filter(sub_reg_f == "NORTH ATLANTIC")

load(here::here("data", "allfh.RData"))
allfh$Species <- stringr::str_to_sentence(allfh$pdcomnam)

asmt <- assessmentdata::stockAssessmentData %>%
  dplyr::filter(Region == "Gulf of Maine / Georges Bank" |
                Region == "Eastern Georges Bank" |
                Region == "Georges Bank" |
                Region == "Gulf of Maine" |
                Region == "Gulf of Maine / Cape Hatteras" |
                Region == "Georges Bank / Southern New England" |
                Region == "Southern New England / Mid" |
                Region == "Gulf of Maine / Northern Georges Bank" |
                Region == "Southern Georges Bank / Mid" |
                Region == "Cape Cod / Gulf of Maine")
asmt$Species <- stringr::str_to_sentence(asmt$Species)

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence()
list_species <- split(all_species, f = list(all_species))

# render some reports
purrr::map(list_species[1], ~rmarkdown::render(here::here("R", "full_report_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          
                                                          latlong_data = latlong,
                                                          shape = shape,
                                                          
                                                          bf_data = bf,
                                                          
                                                          recruit_data = recruit,
                                                          nyear = 20,
                                                          
                                                          survey_data = survey,
                                                          
                                                          ad_rating_data = ad,
                                                          
                                                          diet_data = allfh,
                                                          
                                                          rec_data = rec,
                                                          
                                                          asmt_data = asmt), 
                                            output_dir = here::here("docs"),
                                            output_file = paste(.x, "_full", 
                                                                ".html", sep = "")))
#####

## parallelize reports for faster generation
# having problems with this recently...
#####

# using furrr and future doesn't speed up report generation
# use foreach and doParallel
# cuts batch generation time of all reports from ~10 minutes to ~2 minutes
# make sure there are no NAs in the species name vector or it will break

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence() 
all_species <- all_species[!is.na(all_species)]

# function to save reports, fix temp file problems
render_par <- function(x){

  tf <- tempfile()
  dir.create(tf)

  rmarkdown::render(here::here("R", "full_report_template.Rmd"), 
                    params = list(species_ID = x,
                                  
                                  latlong_data = latlong,
                                  shape = shape,
                                  
                                  bf_data = bf,
                                  
                                  recruit_data = recruit,
                                  nyear = 20,
                                  
                                  survey_data = survey,
                                  
                                  ad_rating_data = ad,
                                  
                                  diet_data = allfh,
                                  
                                  rec_data = rec,
                                  
                                  asmt_data = asmt), 
                    intermediates_dir = tf,
                    output_dir = here::here("docs"),
                    output_file = paste(x, "_full", 
                                        ".html", sep = ""))

  unlink(tf)
}

# make cluster
cl <- parallel::makeCluster(parallel::detectCores() - 1)

# set up cluster
parallel::clusterEvalQ(cl, {
  # load libraries
  library(ggplot2)
  `%>%` <- dplyr::`%>%`
  
  # load data
  bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))
  
  recruit <- read.csv(here::here("data", "recruitment_data.csv"))
  recruit$Units <- stringr::str_replace(recruit$Units, "Thousand Recruits", "Number x 1,000")
  
  survey <- read.csv(here::here("data", "survey_data.csv"))
  
  ad <- read.csv(here::here("data", "assessmentdata_ratings.csv"))
  
  latlong <- read.csv(here::here("data", "geo_range_data.csv"))
  shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
  
  rec <- read.csv(here::here("data/MRIP", "all_MRIP_catch_year.csv")) %>%
    dplyr::filter(sub_reg_f == "NORTH ATLANTIC")
  
  load(here::here("data", "allfh.RData"))
  allfh$Species <- stringr::str_to_sentence(allfh$pdcomnam)
  
  asmt <- assessmentdata::stockAssessmentData %>%
    dplyr::filter(Region == "Gulf of Maine / Georges Bank" |
                    Region == "Eastern Georges Bank" |
                    Region == "Georges Bank" |
                    Region == "Gulf of Maine" |
                    Region == "Gulf of Maine / Cape Hatteras" |
                    Region == "Georges Bank / Southern New England" |
                    Region == "Southern New England / Mid" |
                    Region == "Gulf of Maine / Northern Georges Bank" |
                    Region == "Southern Georges Bank / Mid" |
                    Region == "Cape Cod / Gulf of Maine")
  asmt$Species <- stringr::str_to_sentence(asmt$Species)
  }) %>% invisible()

parallel::parLapply(cl, all_species, render_par)
parallel::stopCluster(cl)
#####

## make summary spreadsheet (old)
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
