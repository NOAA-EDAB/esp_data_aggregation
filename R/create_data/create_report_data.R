# create data spreadsheets for assessmentdata and survdat reports

`%>%` <- dplyr::`%>%`

## bf data
#####
bf <- assessmentdata::stockAssessmentSummary %>% 
  dplyr::filter(Jurisdiction == "NEFMC")

split_info <- stringr::str_split_fixed(bf$`Stock Name`, " - ", n = 2)
bf$Species <- split_info[,1]
bf$Region <- split_info[,2]

write.csv(bf, file = here::here("data", "bbmsy_ffmsy_data.csv"))
#####

## recruitment data
#####
recruit <- assessmentdata::stockAssessmentData %>%
  dplyr::filter(Metric == "Recruitment",
                Region == "Gulf of Maine / Georges Bank" |
                Region == "Eastern Georges Bank" |
                Region == "Georges Bank" |
                Region == "Gulf of Maine" |
                Region == "Gulf of Maine / Cape Hatteras" |
                Region == "Georges Bank / Southern New England" |
                Region == "Southern New England / Mid" |
                Region == "Gulf of Maine / Northern Georges Bank" |
                Region == "Southern Georges Bank / Mid" |
                Region == "Cape Cod / Gulf of Maine")

write.csv(recruit, file = here::here("data", "recruitment_data.csv"))
#####

## survey data
#####
data <- readRDS(here::here("data", "survdat.RDS"))
data <- tibble::as.tibble(data$survdat)

key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")

# parse out survey data for NE species only, add common name
key2 <- data.frame(SVSPP = unique(key$SVSPP),
                  Species = stringr::str_to_sentence(unique(key$COMNAME)))

matches <- as.numeric(data$SVSPP) %in% as.numeric(key2$SVSPP)

data2 <- data[matches, ]

species_name <- c()
for(i in 1:length(data2$SVSPP)){
  svspp <- as.numeric(data2$SVSPP[i])
  r <- which(key2$SVSPP == svspp)
  species_name[i] <- key2[r, 2]
}

data2$Species <- species_name

# add region to survey data

# rename regions
for(i in 1:length(key$stock_area)){
  if(key$stock_area[i] == "gbk") {key$stock_area[i] <- "Georges Bank"}
  if(key$stock_area[i] == "gom") {key$stock_area[i] <- "Gulf of Maine"}
  if(key$stock_area[i] == "snemab") {key$stock_area[i] <- "Southern New England / Mid-Atlantic"}
  if(key$stock_area[i] == "gbkgom") {key$stock_area[i] <- "Gulf of Maine / Georges Bank"}
  if(key$stock_area[i] == "ccgom") {key$stock_area[i] <- "Cape Cod / Gulf of Maine"}
  if(key$stock_area[i] == "south") {key$stock_area[i] <- "Southern Georges Bank / Mid"}
  if(key$stock_area[i] == "north") {key$stock_area[i] <- "Gulf of Maine / Northern Georges Bank"}
  if(key$stock_area[i] == "sne") {key$stock_area[i] <- "Georges Bank / Southern New England"}
  if(key$stock_area[i] == "unit") {key$stock_area[i] <- "all"}
}

key$Species <- stringr::str_to_sentence(key$COMNAME)
key$spst <- paste(key$Species, key$strata %>% as.numeric())
key3 <- key %>% dplyr::select(spst, stock_area)

data2$spst <- paste(data2$Species, data2$STRATUM %>% as.numeric())

data2$spst %in% key3$spst

data3 <- dplyr::left_join(data2, key3, by = "spst")
data3$Region <- data3$stock_area

# some NAs when survey caught fish outside stock areas - replace
data3$Region <- tidyr::replace_na(data3$Region, "Outside stock area")

# add unique way to identify fish observations
date_time <- data3$EST_TOWDATE %>% stringr::str_split(" ", simplify = TRUE)
data3$date <- date_time[, 1]
data3$fish_id <- paste(data3$CRUISE6, data3$STRATUM, 
                       data3$TOW, data3$date, data3$Species,
                        sep = "_") # unique incidences of observing a species

#write.csv(data3, file = here::here("data", "survey_data.csv"))
saveRDS(data3, file = here::here("data", "survey_data.RDS"))

#####

# assessmentdata ratings - same as bf data
#####
ad <- assessmentdata::stockAssessmentSummary %>% 
  dplyr::filter(Jurisdiction == "NEFMC" | 
                  Jurisdiction == "NEFMC / MAFMC" | 
                  Jurisdiction == "MAFMC")
split_info <- stringr::str_split_fixed(ad$`Stock Name`, " - ", n = 2)
ad$Species <- split_info[,1]
ad$Region <- split_info[,2]
head(ad)
unique(ad$Region)

ad %>% write.csv(here::here("data", "assessmentdata_ratings.csv"))
#####

# lat/long data
#####
data <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
crs <-  "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" 

unique(data$stock_area)

# create stock regions to match other data
unique(data$stock_area)
#Region == "Gulf of Maine / Georges Bank" |
Region == "Eastern Georges Bank" |
  #  Region == "Georges Bank" |
  #  Region == "Gulf of Maine" |
  Region == "Gulf of Maine / Cape Hatteras" |
  #  Region == "Georges Bank / Southern New England" |
  #  Region == "Southern New England / Mid" |
  #  Region == "Gulf of Maine / Northern Georges Bank" |
  #  Region == "Southern Georges Bank / Mid" |
  #  Region == "Cape Cod / Gulf of Maine"
  
Region <- c()
for(i in 1:length(data$stock_area)){
  if(data$stock_area[i] == "gbk") {Region[i] <- "Georges Bank"}
  if(data$stock_area[i] == "gom") {Region[i] <- "Gulf of Maine"}
  if(data$stock_area[i] == "snemab") {Region[i] <- "Southern New England / Mid"}
  if(data$stock_area[i] == "gbkgom") {Region[i] <- "Gulf of Maine / Georges Bank"}
  if(data$stock_area[i] == "ccgom") {Region[i] <- "Cape Cod / Gulf of Maine"}
  if(data$stock_area[i] == "south") {Region[i] <- "Southern Georges Bank / Mid"}
  if(data$stock_area[i] == "north") {Region[i] <- "Gulf of Maine / Northern Georges Bank"}
  if(data$stock_area[i] == "sne") {Region[i] <- "Georges Bank / Southern New England"}
  if(data$stock_area[i] == "unit") {Region[i] <- "all"}
}
  
data$Region <- Region
data$Species <- stringr::str_to_sentence(data$COMNAME)

write.csv(data, file = here::here("data", "geo_range_data.csv"))
#####

# recreational catch
#####
files <- dir(here::here("data/MRIP"))
read_files <- files[stringr::str_detect(files, "catch_year") %>% which()]
col_to_keep <-  read.csv(here::here("data/MRIP", read_files[1])) %>%
  colnames()

big_data <- c()
for(i in 1:length(read_files)){
  this_data <- read.csv(here::here("data/MRIP", read_files[i])) %>%
    tibble::as_tibble() %>%
    dplyr::select(col_to_keep)
  big_data <- rbind(big_data, this_data)
}
head(big_data)
tail(big_data)

big_data$tot_cat <- stringr::str_replace_all(big_data$tot_cat, ",", "") #%>%
  as.numeric()
big_data$Species <- stringr::str_to_sentence(big_data$common)

write.csv(big_data, file = here::here("data/MRIP", "all_MRIP_catch_year.csv"))
#####

# commercial catch
com <- read.csv(here::here("data", "com_landings_clean_20201222.csv"))
com$Species <- stringr::str_to_sentence(com$common_name)
com <- com %>%
  dplyr::select(Species, Year, State, Pounds, Dollars) %>%
  dplyr::filter(is.na(Year) == FALSE)

# adjust com for inflation
quantmod::getSymbols("CPIAUCSL", src='FRED')
avg.cpi <- xts::apply.yearly(CPIAUCSL, mean) 
cf <- avg.cpi/as.numeric(avg.cpi['2019']) # using 2019 as the base year 
cf <- cf %>%
  as.data.frame() %>% 
  tibble::rownames_to_column()
cf$Year <- cf$rowname %>% 
  stringr::str_sub(start = 1, end = 4) %>%
  as.numeric()

com <- dplyr::left_join(com, cf, by = "Year")
com$Dollars_adj <- com$Dollars / com$CPIAUCSL

com <- com %>%
  dplyr::select(Species, Year, State, Pounds, Dollars_adj)

write.csv(com, here::here("data", "com_landings_clean_20201222_formatted.csv"))
