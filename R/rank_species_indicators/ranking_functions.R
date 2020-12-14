
## types of indicator analysis

# most recent measurement
### B/Bmsy, F/Fmsy

# mean of past 5 years
### rec catch

# max of all time
### total catch

# mean of past 10 years as % of historical
### abundance, recruitment. biomass, mean length, max length

# from all time
### number of prey categories, % of rejected stock assessments

recent_indicator <- function(data, year_source, value_source, high, indicator_name){

  data <- data %>%
    dplyr::select(Species, Region, value_source, year_source) %>%
    dplyr::rename("Value" = value_source, "Year" = year_source) %>%
    dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
    dplyr::filter(ne_stock == "TRUE", Value > 0) %>%
    
    dplyr::group_by(Species, Region) %>%
    dplyr::mutate(most_recent_year = max(Year)) %>%
    dplyr::ungroup() %>%
    
    dplyr::distinct() %>%
    dplyr::filter(Year == most_recent_year) %>% 
    dplyr::select(Species, Region, Value, Year) %>%
    dplyr::ungroup()

  if(high == "good"){
      data <- data %>%
        dplyr::mutate(Indicator = indicator_name,
                      rank = rank(-Value), 
                      norm_rank = rank/max(rank))
  }
    
  if(high == "bad"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    rank = rank(Value), 
                    norm_rank = rank/max(rank))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)

    return(data)
}

bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))

recent_indicator(data = bf, 
                 year_source = "B.Year", 
                 value_source = "B.Bmsy", 
                 high = "good",
                 indicator_name = "bbmsy")

recent_indicator(data = bf, 
                 year_source = "F.Year", 
                 value_source = "F.Fmsy", 
                 high = "bad",
                 indicator_name = "ffmsy")

yr5mean_indicator <- function(data, year_source, value_source, high, indicator_name){
  
  data <- data %>%
    dplyr::select(Species, Region, value_source, year_source) %>%
    dplyr::rename("Value" = value_source, "Year" = year_source) %>%
    dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
    dplyr::filter(ne_stock == "TRUE", Value > 0)
  
  max_yr <- max(data$Year)
  
  data <- data %>%
    dplyr::filter(Year > max_yr - 5) %>%
    dplyr::group_by(Species, Region) %>%
    dplyr::summarise(Value2 = max(Value)) %>%
    dplyr::rename("Value" = "Value2") %>%
    dplyr::ungroup() %>%
    dplyr::distinct() %>%
    dplyr::select(Species, Region, Value)
  
  if(high == "good"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    Year = paste("average of", 
                                 max_year - 5, "-", max_year, 
                                 "data"),
                    rank = rank(-Value), 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "bad"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    Year = paste("average of", 
                                 max_year - 5, "-", max_year, 
                                 "data"),
                    rank = rank(Value), 
                    norm_rank = rank/max(rank))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)
  
  return(data)
}

rec <- read.csv(here::here("data/MRIP", "all_MRIP_catch_year.csv")) %>%
  dplyr::filter(sub_reg_f == "NORTH ATLANTIC")
head(rec)
rec$Region <- NA

yr5mean_indicator(data = rec, 
                  year_source = "year", 
                  value_source = "tot_cat", 
                  high = "bad",
                  indicator_name = "rec_catch")

maxalltime_indicator <- function(data, year_source, value_source, high, indicator_name){
  
  data <- data %>%
    dplyr::select(Species, Region, value_source, year_source) %>%
    dplyr::rename("Value" = value_source, "Year" = year_source) %>%
    dplyr::mutate(ne_stock = (Species %in% key2$Species)) %>%
    dplyr::filter(ne_stock == "TRUE", Value > 0) %>%
    dplyr::group_by(Species, Region) %>%
    dplyr::mutate(max_value = max(Value)) %>%
    dplyr::filter(Value == max_value) %>%
    dplyr::select(Species, Region, Year, Value) %>%
    dplyr::ungroup()
  
  if(high == "good"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    rank = rank(-Value), 
                    norm_rank = rank/max(rank))
  }
  
  if(high == "bad"){
    data <- data %>%
      dplyr::mutate(Indicator = indicator_name,
                    rank = rank(Value), 
                    norm_rank = rank/max(rank))
  }
  
  data <- data %>%
    dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)
  
  return(data)
}

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

# standardize units
for(i in 1:nrow(asmt)){
  if(asmt$Units[i] == "Thousand Metric Tons"){
    asmt$Value [i] <- 1000 * asmt$Value[i]
    asmt$Units[i] <- "Metric Tons"
  }
}

maxalltime_indicator(data = asmt %>% dplyr::filter(Metric == "Catch"), 
                     year_source = "Year", 
                     value_source = "Value", 
                     high = "bad",
                     indicator_name = "asmt_catch")



