
source(here::here("R/full_report_functions", "get_length.R"))
source(here::here("R/full_report_functions", "get_survdat_info.R"))
source(here::here("R/rank_species_indicators", "get_species_risk.R"))
`%>%` <- dplyr::`%>%`

# read in data from spreadsheets
source(here::here("R/full_report_functions", "read_data.R"))

# remove survey data outside stock areas
survey <- survey %>%
  dplyr::filter(Region != "Outside stock area")

# risk within each stock ----

# avg & max lengths of past 5 years compared to mean of all years previous (fall and spring)
length <- survey %>% dplyr::filter(LENGTH > 0, ABUNDANCE > 0) %>%
  dplyr::select(Species, YEAR, SEASON, Region, fish_id, LENGTH, NUMLEN) %>%
  dplyr::distinct() %>% # problem with repeat rows
  dplyr::group_by(Species, YEAR, SEASON, Region) %>%
  dplyr::mutate(n_fish = sum(NUMLEN)) %>%
  dplyr::filter(n_fish > 10) %>% # only year-season-region with >10 fish
  dplyr::group_by(Species, YEAR, SEASON, Region) %>%
  dplyr::summarise(mean_len = sum(LENGTH*NUMLEN)/sum(NUMLEN),
                   min_len = min(LENGTH),
                   max_len = max(LENGTH)
  )

avg_len_f <- get_species_risk(data = length %>% 
                                dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                              year_source = "YEAR", 
                              value_source = "mean_len", 
                              high = "low_risk",
                              indicator_name = "avg_length_fall")
avg_len_s <- get_species_risk(data = length %>% 
                                dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                              year_source = "YEAR", 
                              value_source = "mean_len", 
                              high = "low_risk",
                              indicator_name = "avg_length_spring")

max_len_f <- get_species_risk(data = length %>% 
                                dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                              year_source = "YEAR", 
                              value_source = "max_len", 
                              high = "low_risk",
                              indicator_name = "max_length_fall")
max_len_s <- get_species_risk(data = length %>% 
                                dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                              year_source = "YEAR", 
                              value_source = "max_len", 
                              high = "low_risk",
                              indicator_name = "max_length_spring")

# survey abundance of past 5 years compared to mean of all years previous (fall and spring)
abun_survey <- survey %>% 
  get_var_data2(variable = "ABUNDANCE")
abun_survey$YEAR <- as.numeric(abun_survey$YEAR)

abun_f <- get_species_risk(data = abun_survey %>% 
                             dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                           year_source = "YEAR", 
                           value_source = "variable", 
                           high = "low_risk",
                           indicator_name = "abundance_fall")
abun_s <- get_species_risk(data = abun_survey %>% 
                             dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                           year_source = "YEAR", 
                           value_source = "variable", 
                           high = "low_risk",
                           indicator_name = "abundance_spring")

# survey biomass of past 5 years compared to mean of all years previous (fall and spring)
biomass_surv <- survey %>% 
  get_var_data2(variable = "BIOMASS")
biomass_surv
biomass_surv$YEAR <- as.numeric(biomass_surv$YEAR)

biomass_f <- get_species_risk(data = biomass_surv %>% 
                                dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                              year_source = "YEAR", 
                              value_source = "variable", 
                              high = "low_risk",
                              indicator_name = "biomass_fall")
biomass_s <- get_species_risk(data = biomass_surv %>% 
                                dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                              year_source = "YEAR", 
                              value_source = "variable", 
                              high = "low_risk",
                              indicator_name = "biomass_spring")


# asmt recruitment of past 5 years compared to mean of all years previous 
dat <- asmt %>% dplyr::filter(Metric == "Recruitment")
recruit <- get_species_risk(data = dat, 
                            year_source = "Year", 
                            value_source = "Value", 
                            high = "low_risk",
                            indicator_name = "recruitment")

# asmt abundance of past 5 years compared to mean of all years previous 
dat <- asmt %>% dplyr::filter(Metric == "Abundance")
abun <- get_species_risk(data = dat, 
                         year_source = "Year", 
                         value_source = "Value", 
                         high = "low_risk",
                         indicator_name = "asmt_abundance")

# asmt biomass of past 5 years compared to mean of all years previous 
dat <- asmt %>% dplyr::filter(Metric == "Biomass")
biomass <- get_species_risk(data = dat, 
                            year_source = "Year", 
                            value_source = "Value", 
                            high = "low_risk",
                            indicator_name = "asmt_biomass")

# asmt catch of past 5 years compared to mean of all years previous 
dat <- asmt %>% dplyr::filter(Metric == "Catch",
                              Units == "Metric Tons")
catch <- get_species_risk(data = dat, 
                          year_source = "Year", 
                          value_source = "Value", 
                          high = "high_risk",
                          indicator_name = "asmt_catch") 

# com catch & revenue of past 5 years compared to mean of all years previous 
com$Region <- NA
com_run <- get_species_risk(data = com, 
                            year_source = "Year", 
                            value_source = "Pounds", 
                            high = "high_risk",
                            indicator_name = "com_catch")

rev_run <- get_species_risk(data = com, 
                            year_source = "Year", 
                            value_source = "Dollars_adj", 
                            high = "high_risk",
                            indicator_name = "revenue")

# rec catch of past 5 years compared to mean of all years previous 
rec$Region <- NA
rec <- get_species_risk(data = rec, 
                        year_source = "year", 
                        value_source = "tot_cat", 
                        high = "high_risk",
                        indicator_name = "rec_catch")

# bbmsy compared to mean of all years previous
b <- get_species_risk(data = asmt_sum, 
                      year_source = "B Year", 
                      value_source = "B/Bmsy", 
                      high = "low_risk",
                      indicator_name = "bbmsy")

# ffmsy compared to mean of all years previous
f <- get_species_risk(data = asmt_sum, 
                      year_source = "F Year", 
                      value_source = "F/Fmsy", 
                      high = "high_risk",
                      indicator_name = "ffmsy")

# * merge everything except rec and com ----
avg_len_f$Year <- avg_len_f$Year %>% as.numeric()
avg_len_s$Year <- avg_len_s$Year %>% as.numeric()
max_len_f$Year <- max_len_f$Year %>% as.numeric()
max_len_s$Year <- max_len_s$Year %>% as.numeric()

all_ind <- rbind(b, f, catch, recruit, abun, biomass, biomass_f, biomass_s,
                 abun_f, abun_s, avg_len_f, avg_len_s, max_len_f, max_len_s)

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
  dplyr::ungroup() %>%
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
all_catch <- rbind(rec, com_run, rev_run)

regions <-  fixed_data %>% 
  dplyr::ungroup() %>%
  dplyr::select(Species, Region) %>% 
  dplyr::distinct()

all_catch_new <- dplyr::left_join(regions, 
                                  all_catch,
                                  by = "Species") %>%
  dplyr::select(-Region.y) %>%
  dplyr::filter(Value > 0, is.na(Region.x) == FALSE) %>%
  dplyr::rename("Region" = "Region.x")

fixed_data <- rbind(fixed_data, all_catch_new)
head(fixed_data)

fixed_data <- fixed_data %>%
  dplyr::group_by(Indicator, Year) %>%
  dplyr::mutate(n_years_per_indicator = max(rank))

# * fill in missing values with 0.5, add total risk and overall rank by year ----
fixed_data$Indicator <- paste("break", fixed_data$Indicator)
data <- fixed_data %>%
  dplyr::select(Species, Region, Indicator, Year, norm_rank) %>%
  tidyr::pivot_wider(names_from = c("Year", "Indicator"),
                     values_from = "norm_rank")
data[is.na(data)] <- 0.5

data <- data %>% tidyr::pivot_longer(cols = colnames(data[3:ncol(data)]),
                                     names_to = "Indicator",
                                     values_to = "norm_rank") 
info <- stringr::str_split_fixed(data$Indicator, "_break ", n = 2)
data$Indicator <- info[ , 2]
data$Year <- info[ , 1]

data <- data %>%
  dplyr::group_by(Species, Region, Year) %>%
  dplyr::mutate(total_risk = sum(norm_rank)) %>%
  dplyr::ungroup() %>%
  dplyr::group_by(Year) %>%
  dplyr::mutate(overall_rank = dplyr::dense_rank(total_risk))

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
     data$Indicator[i] %>% stringr::str_detect("recruitment") == TRUE
  ){
    category[i] <- "Population"
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
fixed_data$Indicator <- fixed_data$Indicator %>% stringr::str_replace("break ", "")
data$Year <- as.numeric(data$Year)

new_data <- dplyr::full_join(data, fixed_data,
                             by = c("Species", "Region", "Indicator", "Year", "norm_rank")) %>%
  dplyr::group_by(Region, Year) %>%
  dplyr::mutate(n_stocks_per_region = Species %>% unique %>% length) %>%
  dplyr::select(Species, Region, Indicator, category, Year, Value, rank, 
                n_years_per_indicator, n_stocks_per_region, norm_rank, 
                total_risk, overall_rank) 

new_data

write.csv(new_data,
          file = here::here("data/risk_ranking", "full_risk_data_by_species.csv"))
