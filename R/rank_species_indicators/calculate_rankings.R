
source(here::here("R/rank_species_indicators", "ranking_functions.R"))
`%>%` <- dplyr::`%>%`

# read in data and rank ----

# * most recent measurement ----
### B/Bmsy, F/Fmsy
bf <- read.csv(here::here("data", "bbmsy_ffmsy_data.csv"))

b <- recent_indicator(data = bf, 
                 year_source = "B.Year", 
                 value_source = "B.Bmsy", 
                 high = "low_risk",
                 indicator_name = "bbmsy")

f <- recent_indicator(data = bf, 
                 year_source = "F.Year", 
                 value_source = "F.Fmsy", 
                 high = "high_risk",
                 indicator_name = "ffmsy")


# * mean of past 5 years ----
### rec catch
rec <- read.csv(here::here("data/MRIP", "all_MRIP_catch_year.csv")) %>%
  dplyr::filter(sub_reg_f == "NORTH ATLANTIC")
head(rec)
rec$Region <- NA

rec <- yr5mean_indicator(data = rec, 
                  year_source = "year", 
                  value_source = "tot_cat", 
                  high = "high_risk",
                  indicator_name = "rec_catch")

# * max of all time ----
### total catch
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

catch <- maxalltime_indicator(data = asmt %>% dplyr::filter(Metric == "Catch"), 
                     year_source = "Year", 
                     value_source = "Value", 
                     high = "high_risk",
                     indicator_name = "asmt_catch")

# * mean of past 10 years as % of historical ----
### abundance, recruitment, biomass, mean length, max length
dat <- asmt %>% dplyr::filter(Metric == "Abundance", Units == "Metric Tons")
abun <- yr10hist_indicator(data = dat, 
                   year_source = "Year", 
                   value_source = "Value", 
                   high = "low_risk",
                   indicator_name = "abundance")

dat <- asmt %>% dplyr::filter(Metric == "Recruitment")
recruit <- yr10hist_indicator(data = dat, 
                   year_source = "Year", 
                   value_source = "Value", 
                   high = "low_risk",
                   indicator_name = "recruitment")

survey <- readRDS(here::here("data", "survey_data.RDS"))
survey <- survey[-which(survey$Species == "Jonah crab" & survey$LENGTH >= 99.9), ] # remove error jonah crab

biomass <- survey %>% 
  dplyr::select(Species, Region, YEAR, SEASON, BIOMASS, fish_id) %>%
  dplyr::distinct()
biomass$YEAR <- as.numeric(biomass$YEAR)

biomass_f <- yr10hist_indicator(data = biomass %>% 
                     dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                   year_source = "YEAR", 
                   value_source = "BIOMASS", 
                   high = "low_risk",
                   indicator_name = "biomass_fall")
biomass_s <- yr10hist_indicator(data = biomass %>% 
                     dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                   year_source = "YEAR", 
                   value_source = "BIOMASS", 
                   high = "low_risk",
                   indicator_name = "biomass_spring")

length <- survey %>% 
  dplyr::select(Species, Region, YEAR, SEASON, LENGTH, NUMLEN, fish_id) %>%
  dplyr::group_by(fish_id) %>%
  dplyr::mutate(avg_length = sum(LENGTH*NUMLEN)/sum(NUMLEN),
                max_length = max(LENGTH)) %>%
  dplyr::ungroup() %>%
  dplyr::select(Species, Region, YEAR, SEASON, avg_length, max_length) %>%
  dplyr::distinct()
length$YEAR <- as.numeric(length$YEAR)

avg_len_f <- yr10hist_indicator(data = length %>% 
                     dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                   year_source = "YEAR", 
                   value_source = "avg_length", 
                   high = "low_risk",
                   indicator_name = "avg_length_fall")
avg_len_s <- yr10hist_indicator(data = length %>% 
                     dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                   year_source = "YEAR", 
                   value_source = "avg_length", 
                   high = "low_risk",
                   indicator_name = "avg_length_spring")

max_len_f <- yr10hist_indicator(data = length %>% 
                     dplyr::filter(SEASON == "FALL", Region != "Outside stock area"), 
                   year_source = "YEAR", 
                   value_source = "max_length", 
                   high = "low_risk",
                   indicator_name = "max_length_fall")
max_len_s <- yr10hist_indicator(data = length %>% 
                     dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"), 
                   year_source = "YEAR", 
                   value_source = "max_length", 
                   high = "low_risk",
                   indicator_name = "max_length_spring")

# * calculated from all time ----
### number of prey categories, % of rejected stock assessments
source(here::here("data", "allfh_regions.R"))
diet <- alltime_indicator_diet(data = allfh %>% 
                                dplyr::filter(gensci != "EMPTY", gensci != "BLOWN",
                                              gensci != "UNOBS", gensci != "ANIMAL REMAINS",
                                              gensci != "MISCELLANEOUS", gensci != "",
                                              Region != "Outside stock area"),  
                              value_source = "gensci", 
                              high = "low_risk",
                              indicator_name = "diet")
diet <- diet %>%
  dplyr::mutate(Year = "all") %>%
  dplyr::rename("Value" = "diet_diversity") %>%
  dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)


# * com data (multiple rankings) ----
com <- read.csv(here::here("data", "com_landings_clean_20201222_formatted.csv"))
com$Region <- NA

com_max <- maxalltime_indicator(data = com, 
                                year_source = "Year", 
                                value_source = "Pounds", 
                                high = "high_risk",
                                indicator_name = "com_catch_max")

rev_max <- maxalltime_indicator(data = com, 
                                year_source = "Year", 
                                value_source = "Dollars_adj", 
                                high = "high_risk",
                                indicator_name = "revenue_max")

com_5yr <- yr5mean_indicator(data = com, 
                             year_source = "Year", 
                             value_source = "Pounds", 
                             high = "high_risk",
                             indicator_name = "com_catch_5yr")

rev_5yr <- yr5mean_indicator(data = com, 
                             year_source = "Year", 
                             value_source = "Dollars_adj", 
                             high = "high_risk",
                             indicator_name = "revenue_5yr")

com_hist <- yr10hist_indicator(data = com, 
                               year_source = "Year", 
                               value_source = "Pounds", 
                               high = "low_risk",
                               indicator_name = "com_catch_hist")

rev_hist <- yr10hist_indicator(data = com, 
                               year_source = "Year", 
                               value_source = "Dollars_adj", 
                               high = "low_risk",
                               indicator_name = "revenue_hist")

# * merge everything except rec and com ----
all_ind <- rbind(b, f, catch, recruit, abun, biomass_f, biomass_s,
                 avg_len_f, avg_len_s, max_len_f, max_len_s, diet)

# data wrangling -----

# * standardize "Mid" "Mid-Atlantic" ----
unique(all_ind$Region)

all_ind$Region <- stringr::str_replace(all_ind$Region, "Mid", "Mid-Atlantic")
all_ind$Region <- stringr::str_replace(all_ind$Region, "Mid-Atlantic-Atlantic", "Mid-Atlantic")

unique(all_ind$Region)

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
fixed_data$Region <- fixed_data$Region %>% tidyr::replace_na("Unknown")

# * create dummy rec and com regions and add rec and com to the rest of the data ----
all_catch <- rbind(rec, com_max, com_5yr, com_hist, 
                   rev_max, rev_5yr, rev_hist)

all_catch_new <- dplyr::left_join( 
  fixed_data %>% 
    dplyr::select(Species, Region) %>% 
    dplyr::distinct(), 
  all_catch,
  by = "Species") %>%
  dplyr::select(-Region.y) %>%
  dplyr::filter(Value > 0, is.na(Region.x) == FALSE) %>%
  dplyr::rename("Region" = "Region.x")

fixed_data <- rbind(fixed_data, all_catch_new)
head(fixed_data)

fixed_data <- fixed_data %>%
  dplyr::group_by(Indicator) %>%
  dplyr::mutate(n_stocks_per_indicator = max(rank))

# * fill in missing values with 0.5, add total risk and overall rank ----
data <- fixed_data %>%
  dplyr::select(Species, Region, Indicator, norm_rank) %>%
  tidyr::pivot_wider(names_from = "Indicator",
                     values_from = "norm_rank")
data[is.na(data)] <- 0.5

data <- data %>% tidyr::pivot_longer(cols = colnames(data[3:21]),
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
                overall_stocks = stock %>% unique() %>% length(),
                category = ifelse(Indicator == "ffmsy" |
                                    Indicator == "asmt_catch" |
                                    Indicator == "rec_catch" |
                                    Indicator == "com_catch_max" |
                                    Indicator == "revenue_max" |
                                    Indicator == "com_catch_5yr" |
                                    Indicator == "revenue_5yr" |
                                    Indicator == "com_catch_hist" |
                                    Indicator == "revenue_hist",
                                  "Social", "Biological"))
data 

# join fixed_data (with values and years) to data (with total ranks and labels)
new_data <- dplyr::full_join(data, fixed_data,
                             by = c("Species", "Region", "Indicator", "norm_rank")) %>%
  dplyr::group_by(Region) %>%
  dplyr::mutate(n_stocks_per_region = Species %>% unique %>% length) %>%
  dplyr::select(Species, Region, Indicator, category, Year, Value, rank, 
                n_stocks_per_indicator, n_stocks_per_region, norm_rank, 
                total_risk, overall_rank, overall_stocks, stock, label) 

new_data

write.csv(new_data,
          file = here::here("data/risk_ranking", "full_risk_data.csv"))

# render Rmd report ----
rmarkdown::render(here::here("R/rank_species_indicators", "plot_all_risk.Rmd"), 
                                      output_dir = here::here("docs/risk_ranking"))


