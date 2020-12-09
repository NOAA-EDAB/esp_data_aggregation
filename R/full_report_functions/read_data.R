
bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))

recruit <- read.csv(here::here("data", "recruitment_data.csv"))
recruit$Units <- stringr::str_replace(recruit$Units, "Thousand Recruits", "Number x 1,000")

survey <- read.csv(here::here("data", "survey_data.csv"))
date_time <- survey$EST_TOWDATE %>% stringr::str_split(" ", simplify = TRUE)
survey$date <- date_time[, 1]
survey$fish_id <- paste(survey$CRUISE6, survey$STRATUM, 
                        survey$TOW, survey$date, survey$Species,
                        sep = "_")

ad <- read.csv(here::here("data", "assessmentdata_ratings.csv"))

latlong <- read.csv(here::here("data", "geo_range_data.csv"))
shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))

rec <- read.csv(here::here("data/MRIP", "all_MRIP_catch_year.csv")) %>%
  dplyr::filter(sub_reg_f == "NORTH ATLANTIC")

source(here::here("data", "allfh_regions.R"))

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