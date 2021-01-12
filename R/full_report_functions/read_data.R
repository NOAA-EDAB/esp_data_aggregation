`%>%` <- dplyr::`%>%`

survey <- readRDS(here::here("data", "survey_data.RDS"))
survey <- survey[-which(survey$Species == "Jonah crab" & survey$LENGTH >= 99.9), ] # remove error jonah crab

survey_ws <- readRDS(here::here("data", "survey_data_12292020_wintersummer.RDS")) %>%
  dplyr::select(colnames(survey))

survey_big <- dplyr::union(survey, survey_ws)

asmt_sum <- read.csv(here::here("data", "assessmentdata_ratings.csv"))

latlong <- read.csv(here::here("data", "geo_range_data.csv")) %>%
  dplyr::rename(stock_season = season_)
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
                  Region == "Cape Cod / Gulf of Maine" |
                  Region == "Northwestern Atlantic Coast" |
                  Region == "Atlantic" |
                  Region == "Western Atlantic" |
                  Region == "Atlantic Coast"  |
                  Region == "Georges Bank / Cape Hatteras" |
                  Region == "Northwestern Atlantic" |
                  Region == "Mid")
asmt$Region <- asmt$Region %>% 
  stringr::str_replace("Mid", "Mid-Atlantic")
asmt$Species <- asmt$Species %>% 
  stringr::str_to_sentence()

for(i in 1:nrow(asmt)){
  if(asmt$Metric[i] == "Abundance"){
    if(asmt$Units[i] == "Metric Tons" |
       asmt$Units[i] == "Kilograms/Tow" |
       asmt$Units[i] == "Kilograms / Tow" |
       asmt$Units[i] == "Thousand Metric Tons" |
       asmt$Units[i] == "Average Kilograms / Tow" |
       asmt$Units[i] == "mt" |
       asmt$Units[i] == "Average Kilograms/Tow") {
      asmt$Metric[i] <- "Biomass"
    }
  } 
}

# standardize units...
for(i in 1:nrow(asmt)){
  if(asmt$Units[i] == "Number x 1,000" |
     asmt$Units[i] == "Number x 1000" |
     asmt$Units[i] == "Thousand Recruits"){
    asmt$Value[i] <- asmt$Value[i]*10^3
    asmt$Units[i] <- "Number"
  } 
  if(asmt$Units[i] == "Million Recruits" |
     asmt$Units[i] == "Number x 1,000,000"){
    asmt$Value[i] <- asmt$Value[i]*10^6
    asmt$Units[i] <- "Number"
  }
  if(asmt$Units[i] == "Number x 10,000"){
    asmt$Value[i] <- asmt$Value[i]*10^4
    asmt$Units[i] <- "Number"
  }
  if(asmt$Units[i] == "Recruits"){
    asmt$Units[i] <- "Number"
  }
  if(asmt$Units[i] == "Thousand Metric Tons"){
    asmt$Value[i] <- asmt$Value[i]*10^3
    asmt$Units[i] <- "Metric Tons"
  }
  if(asmt$Units[i] == "mt"){
    asmt$Units[i] <- "Metric Tons"
  }
  if(asmt$Units[i] == "Million Metric Tons"){
    asmt$Value[i] <- asmt$Value[i]*10^6
    asmt$Units[i] <- "Metric Tons"
  }
}

asmt$Description <- asmt$Description %>%
 stringr::str_replace(" - ", ", ") %>%
  stringr::str_replace("e Age", "e, Age")

new_desc <- asmt$Description %>% 
  stringr::str_split_fixed(" \\(", 2)

details <- new_desc[ , 2] %>%
  stringr::str_replace("\\)", "")

new_desc2 <- new_desc[, 1] %>%
  stringr::str_split_fixed(", ", 2)

basic <- new_desc2[ , 1]
detail_or_age <- new_desc2[ , 2]

age <- c()
for(i in 1:length(details)){
  if(detail_or_age[i] %>% stringr::str_detect("Age") == TRUE){
    age[i] <- detail_or_age[i]
  }
  if(details[i] %>% stringr::str_detect("Age") == TRUE){
    age[i] <- details[i]
  }
  if(details[i] %>% stringr::str_detect("Age") == FALSE &
     detail_or_age[i] %>% stringr::str_detect("Age") == FALSE){
    age[i] <- "No age"
  }
}

asmt$Age <- age

#asmt$Units <- asmt$Units %>%
 # stringr::str_replace("Thousand Recruits", "Number x 1,000")

cond <- rbind(read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_GB.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_GOM.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_MAB.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_SS.csv"))
cond$Species <- stringr::str_to_sentence(cond$Species)
cond$Species <- cond$Species %>% stringr::str_replace("Atl cod", "Atlantic cod")
cond$Species <- cond$Species %>% stringr::str_replace("Atl herring", "Atlantic herring")
cond$Species <- cond$Species %>% stringr::str_replace("Yellowtail", "Yellowtail flounder")
cond$Species <- cond$Species %>% stringr::str_replace("Windowpane flounder", "Windowpane")

risk <- read.csv(here::here("data/risk_ranking", "full_risk_data.csv"))

com <- read.csv(here::here("data", "com_landings_clean_20201222_formatted.csv"))
com$Species <- com$Species %>%
  stringr::str_replace("Windowpane flounder", "Windowpane") %>%
  stringr::str_replace("Monkfish", "Goosefish")

swept <- read.csv(here::here("data", "swept_area_info.csv"))
