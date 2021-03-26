
## types of indicator analysis

# most recent measurement
### B/Bmsy, F/Fmsy

# mean of past 5 years
### rec catch

# max of all time
### total catch

# mean of past 10 years as % of historical
### abundance, recruitment, biomass, mean length, max length

# calculated from all time
### number of prey categories, % of rejected stock assessments

# read in key to filter to NE stocks
key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                   Species = stringr::str_to_sentence(unique(key$COMNAME)))

# most recent measurement ----
recent_indicator <- function(data, year_source, value_source, high, indicator_name){

  data <- data %>%
    dplyr::select(Species, Region, value_source, year_source) %>%
    dplyr::rename("Value" = value_source, "Year" = year_source) %>%
    dplyr::filter(Species %in% key2$Species, 
                  is.na(Value) == FALSE, 
                  is.na(Year) == FALSE) %>%
    
    dplyr::group_by(Species, Region) %>%
    dplyr::mutate(most_recent_year = max(Year)) %>%
    dplyr::ungroup() %>%
    
    dplyr::distinct() %>%
    dplyr::filter(Year == most_recent_year) %>% 
    dplyr::select(Species, Region, Value, Year) %>%
    dplyr::ungroup() %>%
    
    # mean value because yellowtail flounder has two ffmsys
    
    dplyr::group_by(Species, Region, Year) %>%
    dplyr::summarise(Value2 = mean (Value)) %>%
    dplyr::ungroup() %>%
    dplyr::rename("Value" = "Value2")
  
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

# mean of past 5 years ----
yr5mean_indicator <- function(data, year_source, value_source, high, indicator_name){
  
  data <- data %>%
    dplyr::select(Species, Region, value_source, year_source) %>%
    dplyr::rename("Value" = value_source, "Year" = year_source) %>%
    dplyr::filter(Species %in% key2$Species, 
                  is.na(Value) == FALSE, 
                  is.na(Year) == FALSE)
  
  max_yr <- max(data$Year)
  
  data <- data %>%
    dplyr::filter(Year > max_yr - 5) %>%
    dplyr::group_by(Species, Region) %>%
    dplyr::summarise(Value2 = max(Value)) %>%
    dplyr::rename("Value" = "Value2") %>%
    dplyr::ungroup() %>%
    dplyr::distinct() %>%
    dplyr::select(Species, Region, Value)
  
  if(high == "low_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    Year = paste("average of", 
                                 max_yr - 5, "-", max_yr, 
                                 "data"),
                    rank = rank(-Value), 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "high_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    Year = paste("average of", 
                                 max_yr - 5, "-", max_yr, 
                                 "data"),
                    rank = rank(Value), 
                    norm_rank = rank/max(rank))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)
  
  return(data)
}

# max of all time ----
maxalltime_indicator <- function(data, year_source, value_source, high, indicator_name){
  
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
                  is.na(Year) == FALSE) %>%
    dplyr::group_by(Species, Region) %>%
    dplyr::mutate(max_value = max(Value)) %>%
    dplyr::filter(Value == max_value) %>%
    dplyr::select(Species, Region, Year, Value) %>%
    dplyr::ungroup()
  
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

# mean of past 10 years as % of historical ----

yr10hist_indicator <- function(data, year_source, value_source, high, indicator_name){
  
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
  
  max_yr <- max(data$Year)
  
  data <- data %>%
    dplyr::mutate(recent = Year > max_yr - 10) %>%
    dplyr::group_by(Species, Region, recent) %>%
    dplyr::mutate(mean_abun = mean(Value)) %>%
    dplyr::select(Species, Region, recent, mean_abun) %>%
    dplyr::distinct() %>%
    tidyr::pivot_wider(names_from = recent,
                       values_from = mean_abun,
                       names_prefix = "recent_") %>%
    dplyr::mutate(score = recent_TRUE/recent_FALSE) %>%
    dplyr::ungroup()

  if(high == "low_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    Year = "mean of last 10 years vs historic mean",
                    rank = rank(-score), 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "high_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    Year = "mean of last 10 years vs historic mean",
                    rank = rank(score), 
                    norm_rank = rank/max(rank))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, Year, score, rank, norm_rank) %>%
    dplyr::rename("Value" = "score")
  
  return(data)
}


#

# calculated from all time ----
alltime_indicator_diet <- function(data, value_source, year_source, high, indicator_name){
  
  data <- data %>%
    dplyr::select(Species, Region, value_source, year_source) %>%
    dplyr::rename("Value" = value_source,
                  "Year" = year_source) %>%
    dplyr::filter(Species %in% key2$Species, 
                  is.na(Value) == FALSE, 
                  is.na(Year) == FALSE) %>%
    
    dplyr::group_by(Species, Region) %>%
    dplyr::mutate(diet_diversity = length(unique(Value)),
                  diet = paste(stringr::str_sort(unique(Value)), 
                               collapse = ", ")) %>%
    dplyr::select(Species, Region, diet_diversity, diet) %>%
    dplyr::distinct() %>%
    dplyr::ungroup()

  if(high == "low_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    norm_diversity = diet_diversity - min(diet_diversity) + 1,
                    rank = max(norm_diversity) - norm_diversity + 1, 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "high_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    norm_diversity = diet_diversity - min(diet_diversity) + 1,
                    rank = norm_diversity,
                    norm_rank = rank/max(rank))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, diet, diet_diversity, rank, norm_rank)
  
  return(data)
}

alltime_indicator_review <- function(data, value_source, high, indicator_name){
  # not functional yet
  data <- data %>%
    dplyr::select(Species, Region, value_source) %>%
    dplyr::rename("Value" = value_source) %>%
    dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
    dplyr::filter(ne_stock == "TRUE", 
                  is.na(Value) == FALSE, 
                  is.na(Year) == FALSE) %>%
    
    dplyr::group_by(Species, Region) %>%
    dplyr::mutate(diet_diversity = length(unique(Value)),
                  diet = paste(stringr::str_sort(unique(Value)), 
                               collapse = ", ")
    ) %>%
    dplyr::select(Species, Region, diet_diversity, diet) %>%
    dplyr::distinct() %>%
    dplyr::ungroup()
  
  if(high == "low_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    norm_diversity = diet_diversity - min(diet_diversity) + 1,
                    rank = max(norm_diversity) - norm_diversity + 1, 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "high_risk"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    norm_diversity = diet_diversity - min(diet_diversity) + 1,
                    rank = norm_diversity,
                    norm_rank = rank/max(rank))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, diet, diet_diversity, rank, norm_rank)
  
  return(data)
}

#asmt_sum <- read.csv(here::here("data", "assessmentdata_ratings.csv"))
#head(asmt_sum)
#unique(asmt_sum$Review.Result)

#dat <- asmt_sum %>%
#  dplyr::select(Species, Region, Assessment.Year, Review.Result) %>%
#  dplyr::group_by(Species, Region, Review.Result) %>%
#  dplyr::summarise(n_results = length(Assessment.Year)) %>%
#  tidyr::pivot_wider(names_from = Review.Result,
#                     values_from = n_results) %>%
#  dplyr::mutate(prop_full_acc = `Full acceptance` - sum)
#dat[is.na(dat)] <- 0
#dat





