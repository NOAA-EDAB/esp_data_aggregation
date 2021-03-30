
#source(here::here("R/rank_species_indicators", "preliminary_ranking_functions.R"))
source(here::here("R/rank_species_indicators", "get_risk.R"))
`%>%` <- dplyr::`%>%`

# read in data from spreadsheets
source(here::here("R/full_report_functions", "read_data.R"))

# remove survey data outside stock areas
survey <- survey %>%
  dplyr::filter(Region != "Outside stock area")

# rank data ----

# * most recent measurement ----
### B/Bmsy ----
b <- get_risk(data = asmt_sum,
              year_source = "Assessment Year",
              value_source = "B/Bmsy", 
              analysis = "most_recent",
              high = "low_risk",
              indicator_name = "bbmsy")

### F/Fmsy ----
f <- get_risk(data = asmt_sum,
              year_source = "Assessment Year",
              value_source = "F/Fmsy",
              analysis = "most_recent",
              high = "high_risk",
              indicator_name = "ffmsy")

### climate vulnerability ----
data <- read.csv(here::here("data", "Hare_et_al_2016_overall.csv"))

# only ECSA species
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence()

# turn categories into numerics
clim_vul <- data %>%
  dplyr::mutate(Region = NA,
                Indicator = "climate_vulnerability",
                Year = "Hare et al. 2016",
                Value = Overall_climate_vulnerability  %>% 
                  stringr::str_replace("Very high", "4") %>%
                  stringr::str_replace("High", "3") %>%
                  stringr::str_replace("Moderate", "2") %>%
                  stringr::str_replace("Low", "1") %>%
                  as.numeric(),
                rank = dplyr::dense_rank(Value), 
                norm_rank = rank/max(rank),
                rank = paste(rank, "(dense rank)")) %>%
  dplyr::filter(Species %in% all_species) %>%
  dplyr::arrange(Species) %>%
  dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)

### habitat vulnerability ----
hab_vul <- ecodata::habitat_vulnerability %>%
  # no difference in score for species in both EPUs - remove EPU
  dplyr::select(Species, `Species Vulnerability Rank (FCVA)`) %>%
  dplyr::filter(Species %in% all_species) %>%
  dplyr::distinct() %>%
  dplyr::mutate(Region = NA,
                Indicator = "habitat_vulnerability",
                Year = "ecodata",
                Value = `Species Vulnerability Rank (FCVA)`  %>% 
                  stringr::str_replace("Very high", "4") %>%
                  stringr::str_replace("High", "3") %>%
                  stringr::str_replace("Moderate", "2") %>%
                  stringr::str_replace("Low", "1") %>%
                  as.numeric(),
                rank = dplyr::dense_rank(Value), 
                norm_rank = rank/max(rank),
                rank = paste(rank, "(dense rank)")) %>%
  dplyr::arrange(Species) %>%
  dplyr::select(-`Species Vulnerability Rank (FCVA)`)
hab_vul

### NRCC risk ranking ----
nrcc <- read.csv(here::here("data/risk_ranking", "NRCC_total_scores.csv")) %>%
  dplyr::filter(Species != "Jonah crab") # no region specified

# * mean of past 5 years ----
### rec catch ----
rec$Region <- NA
rec_sum <- rec %>%
  dplyr::group_by(Species, Region, year) %>%
  dplyr::summarise(total_catch = sum(lbs_ab1))

rec <- get_risk(data = rec_sum,
                year_source = "year",
                value_source = "total_catch",
                analysis = "past5",
                high = "high_risk",
                indicator_name = "rec_catch")

# * max of all time ----
### total catch ----

# units standardized in read_data script
dat <- asmt %>% dplyr::filter(Metric == "Catch",
                              Units == "Metric Tons")
# function filters to take only most recent assessment
catch <- get_risk(data = dat,
                  year_source = "Year",
                  value_source = "Value",
                  analysis = "max_alltime",
                  high = "high_risk",
                  indicator_name = "asmt_catch") 

# * mean of past 10 years as % of historical - magnitude ----
### abundance, recruitment, biomass, mean length, max length ----

# since this is a %, it doesn't matter that the units are different by species
# as long as units are consistent within each species

### abundance (asmt) ----
dat <- asmt %>% dplyr::filter(Metric == "Abundance")
# function filters to take only most recent assessment
abun <- get_risk(data = dat,
                 year_source = "Year",
                 value_source = "Value", 
                 analysis = "past10_hist",
                 high = "high_risk",
                 indicator_name = "asmt_abundance")

### biomass (asmt) ----
dat <- asmt %>% dplyr::filter(Metric == "Biomass")
# function filters to take only most recent assessment
biomass <- get_risk(data = dat, 
                    year_source = "Year",
                    value_source = "Value", 
                    analysis = "past10_hist",
                    high = "high_risk",
                    indicator_name = "asmt_biomass")

### recruitment ----
dat <- asmt %>% dplyr::filter(Metric == "Recruitment")
recruit <- get_risk(data = dat,
                    year_source = "Year",
                    value_source = "Value", 
                    analysis = "past10_hist",
                    high = "high_risk",
                    indicator_name = "recruitment")

### biomass (survey) ----
biomass_surv <- survey %>% 
  dplyr::select(Species, Region, YEAR, SEASON, BIOMASS, fish_id) %>%
  dplyr::distinct()
biomass_surv$YEAR <- as.numeric(biomass_surv$YEAR)

biomass_f <- get_risk(data = biomass_surv %>%
                        dplyr::filter(SEASON == "FALL", Region != "Outside stock area"),
                      year_source = "YEAR",
                      value_source = "BIOMASS",
                      analysis = "past10_hist",
                      high = "high_risk",
                      indicator_name = "biomass_fall")
biomass_s <- get_risk(data = biomass_surv %>%
                        dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                      year_source = "YEAR",
                      value_source = "BIOMASS",
                      analysis = "past10_hist",
                      high = "high_risk",
                      indicator_name = "biomass_spring")

### abundance (survey) ----
abun_survey <- survey %>% 
  dplyr::select(Species, Region, YEAR, SEASON, ABUNDANCE, fish_id) %>%
  dplyr::distinct()
abun_survey$YEAR <- as.numeric(abun_survey$YEAR)

abun_f <- get_risk(data = abun_survey %>%
                     dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                   year_source = "YEAR", 
                   value_source = "ABUNDANCE", 
                   analysis = "past10_hist",
                   high = "high_risk",
                   indicator_name = "abundance_fall")
abun_s <- get_risk(data = abun_survey %>% 
                     dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                   year_source = "YEAR", 
                   value_source = "ABUNDANCE", 
                   analysis = "past10_hist",
                   high = "high_risk",
                   indicator_name = "abundance_spring")

### length ----
source(here::here("R/full_report_functions/", "get_length.R"))
length <- survey %>% get_len_data_risk
length$YEAR <- as.numeric(length$YEAR)

avg_len_f <- get_risk(data = length %>%
                        dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                      year_source = "YEAR", 
                      value_source = "mean_len", 
                      analysis = "past10_hist",
                      high = "high_risk",
                      indicator_name = "avg_length_fall")
avg_len_s <- get_risk(data = length %>%
                        dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                      year_source = "YEAR", 
                      value_source = "mean_len", 
                      analysis = "past10_hist",
                      high = "high_risk",
                      indicator_name = "avg_length_spring")

max_len_f <- get_risk(data = length %>%
                        dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                      year_source = "YEAR", 
                      value_source = "max_len", 
                      analysis = "past10_hist",
                      high = "high_risk",
                      indicator_name = "max_length_fall")
max_len_s <- get_risk(data = length %>% 
                        dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                      year_source = "YEAR", 
                      value_source = "max_len", 
                      analysis = "past10_hist",
                      high = "high_risk",
                      indicator_name = "max_length_spring")

# * calculated from all time ----
### number of prey categories, % of rejected stock assessments
### diet ----
diet <- get_risk(data = allfh %>% 
                   dplyr::filter(gensci != "EMPTY", 
                                 gensci != "BLOWN",
                                 gensci != "UNOBS", 
                                 gensci != "ANIMAL REMAINS",
                                 gensci != "MISCELLANEOUS", 
                                 gensci != "",
                                 Region != "Outside stock area"), 
                 value_source = "gensci",
                 year_source = "year",
                 analysis = "diet",
                 high = "low_risk",
                 indicator_name = "diet")

# * com data (multiple rankings) ----
com$Region <- NA
com_sum <- com %>%
  dplyr::group_by(Species, Region, Year) %>%
  dplyr::summarise(total_catch = sum(Pounds),
                   total_dollars = sum(Dollars_adj))

com_max <- get_risk(data = com_sum, 
                    year_source = "Year", 
                    value_source = "total_catch", 
                    analysis = "max_alltime",
                    high = "high_risk",
                    indicator_name = "com_catch_max")

rev_max <- get_risk(data = com_sum, 
                    year_source = "Year", 
                    value_source = "total_dollars", 
                    analysis = "max_alltime",
                    high = "high_risk",
                    indicator_name = "revenue_max")

com_5yr <- get_risk(data = com_sum, 
                    year_source = "Year", 
                    value_source = "total_catch", 
                    analysis = "past5",
                    high = "high_risk",
                    indicator_name = "com_catch_5yr")

rev_5yr <- get_risk(data = com_sum, 
                    year_source = "Year", 
                    value_source = "total_dollars", 
                    analysis = "past5",
                    high = "high_risk",
                    indicator_name = "revenue_5yr")

com_hist <- get_risk(data = com_sum, 
                     year_source = "Year", 
                     value_source = "total_catch", 
                     analysis = "past10_hist",
                     high = "high_risk",
                     indicator_name = "com_catch_hist")

rev_hist <- get_risk(data = com_sum, 
                     year_source = "Year", 
                     value_source = "total_dollars", 
                     analysis = "past10_hist",
                     high = "high_risk",
                     indicator_name = "revenue_hist")

# * merge everything except rec, com, clim_vul, hab_vul ----
all_ind <- rbind(b, f, catch, recruit, abun, biomass, biomass_f, biomass_s,
                 abun_f, abun_s, avg_len_f, avg_len_s, max_len_f, max_len_s, 
                 nrcc, diet)

# data wrangling -----

# * standardize region names ----
#all_ind$Region %>% unique() %>% stringr::str_sort() %>% View

all_ind$Region <- all_ind$Region %>%
  stringr::str_replace("Atlantic Coast", "Atlantic") %>%
  stringr::str_replace("Northwestern Atlantic Coast", "Atlantic") %>%
  stringr::str_replace("Northwestern Atlantic", "Atlantic") %>%
  stringr::str_replace("Mid-Atlantic Coast", "Mid-Atlantic") %>%
  stringr::str_replace("Southern New England / Mid-Atlantic", 
                       "Southern New England / Mid") %>%
  stringr::str_replace("Southern Georges Bank / Mid-Atlantic", 
                       "Southern Georges Bank / Mid")

all_ind$Region %>% unique() %>% stringr::str_sort() %>% View

# * replace "all" with region name ----
missing_names <- all_ind %>%
  dplyr::filter(Region == "all") %>%
  dplyr::select(-Region)

has_names <- all_ind %>%
  dplyr::filter(Region != "all")

region_key <- has_names %>%
  dplyr::select(Species, Region) %>%
  dplyr::distinct()

names_added <- dplyr::left_join(missing_names, region_key,
                                by = "Species") %>%
  dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)

fixed_data <- rbind(has_names, names_added)

# replace any NA Region with "Unknown"
fixed_data$Region <- fixed_data$Region %>% 
  tidyr::replace_na("Unknown")

# * create dummy rec and com regions and add rec and com to the rest of the data ----
missing_region <- rbind(rec, com_max, com_5yr, com_hist,
                        rev_max, rev_5yr, rev_hist,
                        clim_vul, hab_vul)

regions <-  fixed_data %>% 
  dplyr::ungroup() %>%
  dplyr::select(Species, Region) %>% 
  dplyr::distinct()

missing_region_new <- dplyr::left_join(regions,
                                       missing_region,
                                       by = "Species") %>%
  dplyr::select(-Region.y) %>%
  dplyr::filter(Value > 0, is.na(Region.x) == FALSE) %>%
  dplyr::rename("Region" = "Region.x")

fixed_data <- rbind(fixed_data, missing_region_new)
head(fixed_data)

fixed_data <- fixed_data %>%
  dplyr::group_by(Indicator) %>%
  dplyr::mutate(n_stocks_per_indicator = length(is.na(Value == FALSE)))

# * fill in missing values with 0.5, add total risk and overall rank ----
data <- fixed_data %>%
  dplyr::select(Species, Region, Indicator, norm_rank) %>%
  tidyr::pivot_wider(names_from = "Indicator",
                     values_from = "norm_rank")
data[is.na(data)] <- 0.5

data <- data %>% tidyr::pivot_longer(cols = colnames(data[3:ncol(data)]),
                             names_to = "Indicator",
                             values_to = "norm_rank") %>%
  dplyr::group_by(Species, Region) %>%
  dplyr::mutate(total_risk = sum(norm_rank),
                stock = paste(Species, Region, sep = " - "),
                label = paste(Species, 
                      total_risk %>% round(digits = 2), 
                      sep = ", ")) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(overall_rank = dplyr::dense_rank(total_risk),
                overall_stocks = stock %>% unique() %>% length())

# categorize indicators
data$Indicator %>% unique()

category <- c()
for(i in 1:nrow(data)){
  if(data$Indicator[i] %>% stringr::str_detect("length") == TRUE |
     data$Indicator[i] %>% stringr::str_detect("diet") == TRUE
     ){
    category[i] <- "Biological"
  }
  if(data$Indicator[i] %>% stringr::str_detect("abundance") == TRUE |
     data$Indicator[i] %>% stringr::str_detect("biomass") == TRUE |
     data$Indicator[i] %>% stringr::str_detect("bbmsy") == TRUE |
     data$Indicator[i] %>% stringr::str_detect("recruitment") == TRUE |
     data$Indicator[i] %>% stringr::str_detect("climate") == TRUE
     ){
    category[i] <- "Population"
  }
  if(data$Indicator[i] %>% stringr::str_detect("habitat") == TRUE 
  ){
    category[i] <- "Habitat"
  }
  if(data$Indicator[i] %>% stringr::str_detect("NRCC") == TRUE 
  ){
    category[i] <- "Management"
  }
  if(data$Indicator[i] %>% stringr::str_detect("catch") == TRUE |
     data$Indicator[i] %>% stringr::str_detect("ffmsy") == TRUE |
     data$Indicator[i] %>% stringr::str_detect("revenue") == TRUE 
  ){
    category[i] <- "Socioeconomic"
  }
}

data$category <- category

# join fixed_data (with values and years) to data (with total ranks and labels)
new_data <- dplyr::full_join(data, fixed_data,
                             by = c("Species", "Region", "Indicator", "norm_rank")) %>%
  dplyr::group_by(Region) %>%
  dplyr::mutate(n_stocks_per_region = Species %>% unique %>% length) %>%
  dplyr::select(Species, Region, Indicator, category, Year, Value, rank, 
                n_stocks_per_indicator, n_stocks_per_region, norm_rank, 
                total_risk, overall_rank, overall_stocks, stock, label) 

new_data

new_data$Year <- new_data$Year %>%
  stringr::str_replace("mean of 2010 - 2020", "magnitude of % change, mean of 2010 - 2020 vs historic") %>%
  stringr::str_replace("mean of 2010 - 2020", "magnitude of % change, mean of 2009 - 2019 vs historic")

write.csv(new_data,
          file = here::here("data/risk_ranking", "full_risk_data.csv"))

#write.csv(new_data %>% dplyr::ungroup() %>% dplyr::select(category, Indicator) %>% dplyr::distinct(), 
 #         file = here::here("data/risk_ranking", "indicator_key.csv"))

# render Rmd report ----
rmarkdown::render(here::here("R/rank_species_indicators", "plot_all_risk.Rmd"), 
                                      output_dir = here::here("docs/risk_ranking"))


