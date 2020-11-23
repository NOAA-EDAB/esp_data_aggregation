library(assessmentdata)
data <- assessmentdata::stockAssessmentSummary

ne_data <- filter(data, Jurisdiction == "NEFMC")
head(ne_data)

list_species <- split(unique(ne_data$`Stock Name`), f = list(unique(ne_data$`Stock Name`)))

# render some reports

test_species <- list_species
purrr::map(test_species, ~rmarkdown::render(here::here("R", "assessmentdata_report_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          data_source = ne_data), 
                                            output_dir = here::here("docs"),
                                            output_file = paste(stringr::str_replace(.x, "/", "&"), 
                                                                ".html", sep = "")))

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

setwd(here::here("data"))
write.csv("results", file = "bbmsy_ffmsy_summary.csv")
#####
