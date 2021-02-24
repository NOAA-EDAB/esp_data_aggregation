`%>%` <- dplyr::`%>%`

source(here::here("R", "update_species_names.R"))

# survey ----
survey <- readRDS(here::here("data", "survey_data.RDS")) %>%
  update_species_names(species_col = "Species")
survey <- survey[-which(survey$Species == "Jonah crab" & survey$LENGTH >= 99.9), ] # remove error jonah crab
# sum(numlen) and abundance may not be equal 
# abundnace has been corrected with conversion factor, but numlen has not

# fix survey numbers treated as characters
survey <- survey %>%
  dplyr::mutate(CRUISE6 = CRUISE6 %>% as.numeric(), 
                STATION = STATION %>% as.numeric(), 
                STRATUM = STRATUM %>% as.numeric(), 
                TOW = TOW %>% as.numeric(), 
                SVSPP = SVSPP %>% as.numeric(), 
                CATCHSEX = CATCHSEX %>% as.numeric(), 
                YEAR = YEAR %>% as.numeric())

survey_ws <- readRDS(here::here("data", "survey_data_02012021_wintersummer.RDS")) %>%
  dplyr::select(colnames(survey))  %>%
  update_species_names(species_col = "Species")

survey_big <- dplyr::union(survey, survey_ws)

ricky_survey <- readRDS(here::here("data", "survdat_pull_bio.rds"))

# assessmentdata summary ----
#asmt_sum <- assessmentdata::stockAssessmentSummary  # summary data from before 2019 has been removed from package, no new data added though
asmt_sum <- read.csv(here::here("data", "assessmentdata_stockAssessmentSummary.csv"), 
                     check.names = FALSE,
                     header = TRUE)[, -1] %>%
  tibble::as_tibble()

asmt_sum <- asmt_sum %>% 
  dplyr::filter(Jurisdiction == "NEFMC" | 
                  Jurisdiction == "NEFMC / MAFMC" | 
                  Jurisdiction == "MAFMC")
 

split_info <- stringr::str_split_fixed(asmt_sum$`Stock Name`, " - ", n = 2)
asmt_sum$Species <- split_info[,1]
asmt_sum$Region <- split_info[,2]

asmt_sum <- asmt_sum %>%
  update_species_names(species_col = "Species")

# latlong ----
latlong <- read.csv(here::here("data", "geo_range_data.csv")) %>%
  dplyr::rename(stock_season = season_) %>%
  update_species_names(species_col = "Species")

shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))

# rec catch ----
rec <- read.csv(here::here("data/MRIP", "all_MRIP_catch_year.csv")) %>%
  dplyr::filter(sub_reg_f == "NORTH ATLANTIC" | 
                  sub_reg_f == "MID-ATLANTIC") %>%
  dplyr::mutate(lbs_ab1 = lbs_ab1 %>%
                  stringr::str_replace_all(",", "") %>%
                  as.numeric()) %>%
  update_species_names(species_col = "Species")

# diet ----
source(here::here("data", "allfh_regions.R"))

# assessmentdata ----
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

asmt <- asmt %>%
  update_species_names(species_col = "Species")

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

category <- c()
for(i in 1:nrow(asmt)){
  if(asmt$Description[i] %>% stringr::str_detect("Mature") == TRUE){
    category[i] <- "Mature"
  } 
  if(asmt$Description[i] %>% stringr::str_detect("Spawning Stock") == TRUE |
     asmt$Description[i] %>% stringr::str_detect("SSB") == TRUE){
    category[i] <- "Spawning Stock"
  }
  if(asmt$Description[i] %>% stringr::str_detect("Survey") == TRUE){
    category[i] <- "Survey"
  }
  if(asmt$Description[i] %>% stringr::str_detect("Survey") == FALSE &
     asmt$Description[i] %>% stringr::str_detect("Mature") == FALSE &
     asmt$Description[i] %>% stringr::str_detect("Spawning Stock") == FALSE &
     asmt$Description[i] %>% stringr::str_detect("SSB") == FALSE
     ){
    category[i] <- "Other"
  }
}
asmt$Category <- category

#asmt$Units <- asmt$Units %>%
 # stringr::str_replace("Thousand Recruits", "Number x 1,000")

# condition ----
cond <- rbind(read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_GB.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_GOM.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_MAB.csv"),
              read.csv("https://raw.githubusercontent.com/Laurels1/Condition/master/data/AnnualRelCond2018_SS.csv")) %>%
  update_species_names(species_col = "Species")
cond$Species <- stringr::str_to_sentence(cond$Species)
cond$Species <- cond$Species %>% stringr::str_replace("Atl cod", "Atlantic cod")
cond$Species <- cond$Species %>% stringr::str_replace("Atl herring", "Atlantic herring")
cond$Species <- cond$Species %>% stringr::str_replace("Yellowtail", "Yellowtail flounder")
cond$Species <- cond$Species %>% stringr::str_replace("Windowpane flounder", "Windowpane")

# risk ----
risk <- read.csv(here::here("data/risk_ranking", "full_risk_data.csv")) %>%
  dplyr::mutate(Species = Species %>% stringr::str_replace("Goosefish", "Monkfish"))
risk_year_hist <- read.csv(here::here("data/risk_ranking", "full_historical_risk_data_over_time.csv")) %>%
  dplyr::mutate(Species = Species %>% stringr::str_replace("Goosefish", "Monkfish"))
risk_year_value <- read.csv(here::here("data/risk_ranking", "full_risk_data_value_over_time.csv")) %>%
  dplyr::mutate(Species = Species %>% stringr::str_replace("Goosefish", "Monkfish"))
risk_species <- read.csv(here::here("data/risk_ranking", "full_risk_data_by_species.csv")) %>%
  dplyr::mutate(Species = Species %>% stringr::str_replace("Goosefish", "Monkfish"))

# commercial ----
com <- read.csv(here::here("data", "com_landings_clean_20201222_formatted.csv")) 
com$Species <- com$Species %>%
  stringr::str_replace("Windowpane flounder", "Windowpane")

# swept ----
swept <- read.csv(here::here("data", "swept_area_info.csv")) %>%
  update_species_names(species_col = "Species")
