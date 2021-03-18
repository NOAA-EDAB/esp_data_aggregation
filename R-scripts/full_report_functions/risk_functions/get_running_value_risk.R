# read in key to filter to NE stocks
key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                   Species = stringr::str_to_sentence(unique(key$COMNAME)))  %>%
  dplyr::mutate(Species = Species %>%
                  stringr::str_replace("Goosefish", "Monkfish"))

# mean of past 5 years (running time) ----

get_running_value_risk <- function(data, year_source, value_source, 
                             high, indicator_name, n_run){
  
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
    dplyr::filter(Species %in% key2$Species,
                  is.na(Value) == FALSE, 
                  is.na(Year) == FALSE)
  
  data <- data %>%
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
      dplyr::mutate(score = mean(Value)) %>%
      dplyr::select(Species, Region, recent, score) %>%
      dplyr::distinct() %>%
      dplyr::filter(recent == TRUE,
                    is.na(score) == FALSE) %>% # remove missing values
      dplyr::ungroup() 
    
    if(high == "low_risk"){
      new_data <- new_data %>%
        dplyr::mutate(Indicator = indicator_name,
                      Year = paste(years[i+1], "-", years[i+n_run], " mean",
                                   sep = ""),
                      rank = rank(-score), 
                      norm_rank = rank/max(rank))
    }
    
    if(high == "high_risk"){
      new_data <- new_data %>%
        dplyr::mutate(Indicator = indicator_name,
                      Year = paste(years[i+1], "-", years[i+n_run], " mean",
                                   sep = ""),
                      rank = rank(score), 
                      norm_rank = rank/max(rank))
      
    }
    
    new_data <- new_data %>%
      dplyr::group_by(Year) %>%
      dplyr::mutate(n_stocks = length(rank)) %>%
      dplyr::filter(n_stocks >= 5) %>% # only include years with 5+ stocks
      dplyr::ungroup() %>%
      dplyr::select(Species, Region, Indicator, Year, score, rank, norm_rank) %>%
      dplyr::rename("Value" = "score")
    
    results <- rbind(results, new_data)
    
  }
  
  return(results)
}
