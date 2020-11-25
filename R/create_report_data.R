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
