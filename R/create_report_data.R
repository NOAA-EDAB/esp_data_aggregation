# create data spreadsheets for assessmentdata and survdat reports

`%>%` <- dplyr::`%>%`

## bf data
bf <- assessmentdata::stockAssessmentSummary %>% 
  dplyr::filter(Jurisdiction == "NEFMC")

split_info <- stringr::str_split_fixed(bf$`Stock Name`, " - ", n = 2)
bf$Species <- split_info[,1]
bf$Region <- split_info[,2]

write.csv(bf, file = here::here("data", "bbmsy_ffmsy_data.csv"))

## recruitment data
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

## survey data
data <- readRDS(here::here("data", "survdat.RDS"))
data <- tibble::as.tibble(data$survdat)

key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
key <- data.frame(SVSPP = unique(key$SVSPP),
                  Species = stringr::str_to_sentence(unique(key$COMNAME)))

data2 <- dplyr::filter(data, SVSPP == key$SVSPP)

species_name <- c()
for(i in 1:length(data2$SVSPP)){
  svspp <- as.numeric(data2$SVSPP[i])
  r <- which(key$SVSPP == svspp)
  species_name[i] <- key[r, 2]
}

data2$Species <- species_name

write.csv(data2, file = here::here("data", "survey_data.csv"))

# assessmentdata ratings - same as bf data
ad <- assessmentdata::stockAssessmentSummary %>% 
  dplyr::filter(Jurisdiction == "NEFMC")
split_info <- stringr::str_split_fixed(ad$`Stock Name`, " - ", n = 2)
ad$Species <- split_info[,1]
ad$Region <- split_info[,2]
head(ad)
unique(ad$Region)

ad %>% write.csv(here::here("data", "assessmentdata_ratings.csv"))

# lat/long data
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
