`%>%` <- dplyr::`%>%`

# read in data
#####
data <- assessmentdata::stockAssessmentSummary

ne_data <- dplyr::filter(data, Jurisdiction == "NEFMC")

split_info <- stringr::str_split_fixed(ne_data$`Stock Name`, " - ", n = 2)
ne_data$Species <- split_info[,1]
ne_data$Region <- split_info[,2]

dat <- assessmentdata::stockAssessmentData
head(dat)

recruit <- dplyr::filter(dat, 
                         Metric == "Recruitment",
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
#####

all_species <- unique(c(ne_data$Species, recruit$Species))
list_species <- split(all_species, f = list(all_species))

# render some reports

purrr::map(list_species, ~rmarkdown::render(here::here("R", "assessmentdata_report_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          data_source = ne_data,
                                                          recruit_data_source = recruit,
                                                          nyear = 20), 
                                            output_dir = here::here("docs"),
                                            output_file = paste(.x, "_assessmentdata", 
                                                                ".html", sep = "")))

plot_data <- subset(ne_data, Species == "Atlantic mackerel")
list_regions <- split(unique(plot_data$Region), f = list(unique(plot_data$Region)))
status(list_regions, metric = "bbmsy")
test <- c("GOOD", "BAD", "UNKNOWN")

test <- recruit[recruit$Species == list_species[3],]
lil <- tibble::as_tibble(c(1))

length(test$Species)

# make summary spreadsheet
#####
results <- purrr::map(test_species, function(x){
  
  data <- ne_data[ne_data$`Stock Name` == x,]
  
  # bbmsy
  bbmsy <- data.frame(year = data$`B Year`, 
                      value = data$'B/Bmsy')

  if(sum(is.na(bbmsy$value)) == length(bbmsy$value)){
    b_data <- "MISSING"
  } else b_data <- "PRESENT"
  
  bbmsy <- bbmsy[is.na(bbmsy$value) == FALSE, ]
  
  if(b_data == "PRESENT"){
    b_status <- if((tail(bbmsy$value, n = 1)) > 1) "GOOD" else "DANGER"
  } else b_status <- "UNKNOWN"

  if(b_data == "PRESENT"){
    b_year <- tail(bbmsy$year, n = 1)
  } else b_year <- "UNKNOWN"
  
  if(b_data == "PRESENT"){
    b_recent <- tail(bbmsy$value, n = 1) %>%
      round(digits = 2)
  } else b_recent <- "UNKNOWN"
  
  #ffmsy
  ffmsy <- data.frame(year = data$`F Year`, 
                      value = data$'F/Fmsy')
  
  if(sum(is.na(ffmsy$value)) == length(ffmsy$value)){
    f_data <- "MISSING"
  } else f_data <- "PRESENT"
  
  ffmsy <- ffmsy[is.na(ffmsy$value) == FALSE, ]
  
  if(f_data == "PRESENT"){
    f_status <- if((tail(ffmsy$value, n = 1)) > 1) "DANGER" else "GOOD"
  } else f_status <- "UNKNOWN"
  
  if(f_data == "PRESENT"){
    f_year <- tail(ffmsy$year, n = 1)
  } else f_year <- "UNKNOWN"
  
  if(f_data == "PRESENT"){
    f_recent <- tail(ffmsy$value, n = 1) %>%
      round(digits = 2)
  } else f_recent <- "UNKNOWN"
  
  # results
  results <- c(b_year, b_recent, b_status, f_year, f_recent, f_status)
  return(results)
}) %>% 
  tibble::as_tibble() %>% 
  t()

colnames(results) <- c("B_year", "B_Bmsy", "B_status", "F_year", "F_Fmsy", "F_status")
results

write.csv(results, file = here::here("data", "bbmsy_ffmsy_summary.csv"))
#####
