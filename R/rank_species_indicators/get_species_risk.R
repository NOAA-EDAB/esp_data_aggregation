# read in key to filter to NE stocks
key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                   Species = stringr::str_to_sentence(unique(key$COMNAME)))
# rank values within species

get_species_risk <- function(data, year_source, value_source, high, indicator_name){
  
  # select assessmentdata just from most recent assessment for each species
  if(sum(data %>% colnames %>% stringr::str_detect("AssessmentYear")) > 0){
    data <- data %>%
      dplyr::group_by(Species) %>%
      dplyr::mutate(most_recent_asmt = max(AssessmentYear)) %>%
      dplyr::filter(AssessmentYear == most_recent_asmt)
  }
  
  data <- data %>%
    dplyr::select(Species, Region, value_source, year_source) %>%
    dplyr::rename("Value" = value_source, "Year" = year_source) %>%
    dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
    dplyr::filter(ne_stock == "TRUE", 
                  is.na(Value) == FALSE, 
                  is.na(Year) == FALSE) %>%
    dplyr::group_by(Species, Region) %>%
    dplyr::distinct(Year, .keep_all = TRUE) # some years have repeats - keep first value only for now
  
  if(high == "low_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    rank = rank(-Value), 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "high_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    rank = rank(Value), 
                    norm_rank = rank/max(rank))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)
  
  return(data)
}

  