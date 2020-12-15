`%>%` <- dplyr::`%>%`

survey <- readRDS(here::here("data", "survey_data.RDS"))

asmt_sum <- read.csv(here::here("data", "assessmentdata_ratings.csv"))

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
asmt$Region <- asmt$Region %>% 
  stringr::str_replace("Mid", "Mid-Atlantic")
asmt$Species <- asmt$Species %>% 
  stringr::str_to_sentence()
asmt$Units <- asmt$Units %>%
  stringr::str_replace("Thousand Recruits", "Number x 1,000")

cond <- rbind(read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_GB.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_GOM.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_MAB.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_SS.csv"))
cond$Species <- stringr::str_to_sentence(cond$Species)
cond$Species <- cond$Species %>% stringr::str_replace("Atl cod", "Atlantic cod")
cond$Species <- cond$Species %>% stringr::str_replace("Atl herring", "Atlantic herring")
cond$Species <- cond$Species %>% stringr::str_replace("Yellowtail", "Yellowtail flounder")
cond$Species <- cond$Species %>% stringr::str_replace("Windowpane flounder", "Windowpane")

risk <- read.csv(here::here("data/risk_ranking", "full_data.csv"))
