
# read in key to filter to NE stocks
key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                   Species = stringr::str_to_sentence(unique(key$COMNAME))) %>%
  dplyr::mutate(Species = Species %>% stringr::str_replace("Goosefish", "Monkfish"))

# most recent measurement ----
get_risk <- function(data, year_source, value_source, 
                             analysis, high, indicator_name){
  
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
    dplyr::filter(Species %in% key2$Species, 
                  is.na(Value) == FALSE, 
                  is.na(Year) == FALSE)
    
  if(analysis == "most_recent"){
      data <- data %>%
        dplyr::group_by(Species, Region) %>%
        dplyr::mutate(most_recent_year = max(Year)) %>%
        dplyr::ungroup() %>%
        
        dplyr::distinct() %>%
        dplyr::filter(Year == most_recent_year) %>% 
        dplyr::select(Species, Region, Value, Year) %>%
        dplyr::ungroup() %>%
        
        # mean value because yellowtail flounder has two ffmsys
        
        dplyr::group_by(Species, Region, Year) %>%
        dplyr::summarise(Value2 = mean(Value, na.rm = TRUE)) %>%
        dplyr::ungroup() %>%
        dplyr::rename("Value" = "Value2")
    }
  
  if(analysis == "past5"){
    max_yr <- max(data$Year)
    
    data <- data %>%
      dplyr::filter(Year > max_yr - 5) %>%
      dplyr::group_by(Species, Region) %>%
      dplyr::summarise(Value2 = mean(Value, na.rm = TRUE)) %>%
      dplyr::rename("Value" = "Value2") %>%
      dplyr::mutate(Year = paste("mean of", max_yr - 5, "-", max_yr)) %>%
      dplyr::ungroup() %>%
      dplyr::select(Species, Region, Year, Value) %>%
      dplyr::distinct()

  }
  
  if(analysis == "max_alltime"){
    data <- data %>%
      dplyr::group_by(Species, Region) %>%
      dplyr::mutate(max_value = max(Value)) %>%
      dplyr::filter(Value == max_value) %>%
      dplyr::select(Species, Region, Year, Value) %>%
      dplyr::ungroup()
  }

  if(analysis == "past10_hist"){
    max_yr <- max(data$Year)
    
    data <- data %>%
      dplyr::mutate(recent = Year > max_yr - 10) %>%
      dplyr::group_by(Species, Region, recent) %>%
      dplyr::mutate(mean_abun = mean(Value, na.rm = TRUE)) %>%
      dplyr::select(Species, Region, recent, mean_abun) %>%
      dplyr::distinct() %>%
      tidyr::pivot_wider(names_from = recent,
                         values_from = mean_abun,
                         names_prefix = "recent_") %>%
      dplyr::mutate(Value = abs(recent_TRUE - recent_FALSE)/recent_FALSE) %>% # magnitude of % change
      dplyr::select(Species, Region, Value) %>%
      dplyr::mutate(Year = paste("mean of", max_yr - 10, "-", max_yr)) %>%
      dplyr::ungroup()
  }
  
  if(analysis == "diet"){
    data <- data %>%
      dplyr::group_by(Species, Region) %>%
      dplyr::mutate(Value = length(unique(Value)),
                    Year = "all time") %>%
      dplyr::select(Species, Region, Value, Year) %>%
      dplyr::distinct() %>%
      dplyr::ungroup()
  }
  
  if(high == "low_risk" & analysis != "diet"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    rank = rank(-Value), 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "high_risk" & analysis != "diet"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    rank = rank(Value), 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "low_risk" & analysis == "diet"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    norm_diversity = Value - min(Value) + 1,
                    rank = max(Value) - Value + 1, 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "high_risk" & analysis == "diet"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    norm_diversity = diet_diversity - min(diet_diversity) + 1,
                    rank = norm_diversity,
                    norm_rank = rank/max(rank))
  }
  
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)
  
  return(data)
}
