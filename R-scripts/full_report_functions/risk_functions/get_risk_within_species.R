# read in key to filter to NE stocks
key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                   Species = stringr::str_to_sentence(unique(key$COMNAME)))  %>%
  dplyr::mutate(Species = Species %>%
                  stringr::str_replace("Goosefish", "Monkfish"))
# rank values within species

get_species_risk <- function(data, year_source, value_source, high, indicator_name, n_run = 5){
  
  data <- data %>%
    dplyr::rename("Value" = value_source, "Year" = year_source)
  
  # select assessmentdata just from most recent assessment for each species
  if(sum(data %>% colnames %>% stringr::str_detect("AssessmentYear")) > 0){
    data <- data %>%
      dplyr::group_by(Species) %>%
      dplyr::mutate(most_recent_asmt = max(AssessmentYear)) %>%
      dplyr::filter(AssessmentYear == most_recent_asmt)
  }
  
  # sum state data for commercial info
  if(sum(data %>% colnames %>% stringr::str_detect("State")) > 0){
    data <- data %>%
      dplyr::group_by(Species, Year) %>%
      dplyr::mutate(Value = sum(Value))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Value, Year) %>%
    dplyr::mutate(ne_stock = (Species %in% key2$Species),
                  Year = as.numeric(Year)) %>%
    dplyr::filter(ne_stock == "TRUE", 
                  is.na(Value) == FALSE, 
                  is.na(Year) == FALSE) %>%
    dplyr::group_by(Species, Region) %>%
    dplyr::distinct(Year, .keep_all = TRUE) %>% # some years have repeats - keep first value only for now
    dplyr::arrange(Year)
  
  years <- data$Year %>% 
    unique() 

  results <- c()
  for(i in 1:((years %>% length) - n_run)){
    new_data <- data %>%
      dplyr::filter(Year <= years[i+n_run],
                    is.na(Value) == FALSE,
                    is.na(Year) == FALSE) %>%
      dplyr::mutate(recent = Year > years[i+n_run] - n_run) %>%
      dplyr::group_by(Species, Region, recent) %>%
      dplyr::mutate(mean_value = mean(Value),
                    Indicator = indicator_name,
                    Year = paste(years[i+1], "-", years[i+n_run], " mean",
                                 sep = "")) %>%
      dplyr::select(Species, Region, recent, mean_value, Indicator, Year) %>%
      dplyr::distinct() %>%
      dplyr::filter(recent == TRUE,
                    is.na(mean_value) == FALSE) %>% # remove missing values
      dplyr::ungroup()
    
    results <- rbind(results, new_data)

  }

  if(high == "low_risk"){
    results <- results %>%
      dplyr::group_by(Species, Region) %>%
      dplyr::mutate(rank = rank(-mean_value), 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "high_risk"){
    results <- results %>%
      dplyr::group_by(Species, Region) %>%
      dplyr::mutate(rank = rank(mean_value), 
                    norm_rank = rank/max(rank))
    
  }
  
  results <- results %>%
    dplyr::ungroup() %>%
    dplyr::select(Species, Region, Indicator, Year, mean_value, rank, norm_rank)  %>%
    dplyr::rename("Value" = "mean_value")

  return(results)
}


  