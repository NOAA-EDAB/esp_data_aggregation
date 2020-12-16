
source(here::here("R/rank_species_indicators", "ranking_functions.R"))

# most recent measurement ----
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


# mean of past 5 years ----
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

# max of all time ----
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

# mean of past 10 years as % of historical ----
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

# calculated from all time ----
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

all_ind <- rbind(b, f, catch, recruit, abun, biomass_f, biomass_s,
                 avg_len_f, avg_len_s, max_len_f, max_len_s, diet)

unique(all_ind$Region)

all_ind$Region <- stringr::str_replace(all_ind$Region, "Mid", "Mid-Atlantic")
all_ind$Region <- stringr::str_replace(all_ind$Region, "Mid-Atlantic-Atlantic", "Mid-Atlantic")

unique(all_ind$Region)

write.csv(all_ind, here::here("docs/risk_ranking", "preliminary_risk_ranking.csv"))

# replace "all" with region name
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

id <- paste(fixed_data$Species, fixed_data$Region, fixed_data$Indicator)

id == unique(id)

cbind(id[484:514], unique(id)[484:514])

# add dummy rec regions and add
rec_new <- dplyr::left_join( 
  fixed_data %>% 
    dplyr::select(Species, Region) %>% 
    dplyr::distinct(), 
  rec,
  by = "Species") %>%
  dplyr::select(-Region.y) %>%
  dplyr::filter(Value > 0, is.na(Region.x) == FALSE) %>%
  dplyr::rename("Region" = "Region.x")

fixed_data <- rbind(fixed_data, rec_new)
head(fixed_data)

fixed_data <- fixed_data %>%
  dplyr::group_by(Indicator) %>%
  dplyr::mutate(n_stocks = max(rank))

write.csv(fixed_data, file = here::here("data/risk_ranking", "full_data.csv"))

# fill in missing values
data <- fixed_data %>%
  dplyr::select(Species, Region, Indicator, norm_rank) %>%
  tidyr::pivot_wider(names_from = "Indicator",
                     values_from = "norm_rank")
data$Region <- data$Region %>% tidyr::replace_na("Unknown")
data[is.na(data)] <- 0.5

data <- data %>% tidyr::pivot_longer(cols = colnames(data[3:15]),
                             names_to = "Indicator",
                             values_to = "norm_rank") %>%
  dplyr::group_by(Species, Region) %>%
  dplyr::mutate(total_risk = sum(norm_rank),
                stock = paste(Species, Region, sep = " - "),
                label = paste(Species, 
                      total_risk %>% round(digits = 2), 
                      sep = ", "))
data 

write.csv(data, file = here::here("data/risk_ranking", "plot_data.csv"))

overall_rank <- data %>%
  dplyr::select(Species, Region, total_risk) %>%
  dplyr::distinct() %>%
  dplyr::ungroup() %>%
  dplyr::mutate(rank = rank(total_risk),
                norm_rank = rank/max(rank),
                n_stocks = length(total_risk),
                Indicator = "overall",
                Year = "all") %>%
  dplyr::rename("Value" = "total_risk") %>%
  dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank, n_stocks)
  

write.csv(rbind(fixed_data, overall_rank), 
          file = here::here("data/risk_ranking", "full_data.csv"))

# figure
fig <- ggplot(data,
              aes(x = reorder(stock, -total_risk),
                  y = Indicator,
                  fill = norm_rank))+
  geom_raster(stat = "identity")+
  geom_text(aes(x = reorder(stock, -total_risk),
                y = 0.5,
                label = label),
            angle = 90,
            hjust = 0,
            cex = 3,
            color = "black")+
  theme_bw()+
  scale_fill_gradient2(high = "darkred", mid = "beige", low = "forestgreen", midpoint = 0.5)+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        legend.position = "bottom"
  )+
  facet_wrap(facets = vars(Region),
             scales = "free_x")
fig

pdf(here::here("docs/risk_ranking", "preliminary_risk_ranking.pdf"),
    height = 6.5, width = 9)
fig
dev.off()

