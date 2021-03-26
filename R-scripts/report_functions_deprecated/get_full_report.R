### packages required

## general packages required
# library(dplyr)
# library(ggplot2)
# library(here)
# library(stringr)
# library(sf)
# library(rmarkdown)
# library(tibble)
# library(knitr)
# library(scales)
# library(ecodata)
# library(DT)

## required to render reports
# library(purrr) # for automated rendering
# library(snow) # for automated and parallelized rendering

## required to recreate data
# library(assessmentdata)
# library(survdat) # or a saved data pull

## required to recreate color palettes
# library(grDevices)
# library(nmfspalette)

###

## render automated reports with purrr
#####
`%>%` <- dplyr::`%>%`

# read in data from spreadsheets
source(here::here("R/full_report_functions", "read_data.R"))

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence()
list_species <- split(all_species, f = list(all_species))

# render some reports
purrr::map(c("Acadian redfish"), ~rmarkdown::render(here::here("R", "full_report_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          
                                                          latlong_data = latlong,
                                                          shape = shape,
                                                          
                                                          asmt_sum_data = asmt_sum,

                                                          survey_data = survey_big,
                                                          
                                                          diet_data = allfh,
                                                          
                                                          rec_data = rec,
                                                          
                                                          asmt_data = asmt,
                                                          
                                                          cond_data = cond,
                                                          
                                                          risk_data = risk,
                                                          
                                                          com_data = com,
                                                          
                                                          swept_data = swept
                                                          ), 
                                            output_dir = here::here("docs/reports"),
                                            output_file = paste(.x, "_full", 
                                                                ".html", sep = "")))
#####

## parallelize reports for faster generation
#####

# using furrr and future doesn't speed up report generation
# use parallel
# cuts batch generation time by ~80%
# but very slow cluster creating and closing - how to speed up??
# make sure there are no NAs in the species name vector or it will break

`%>%` <- dplyr::`%>%`

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence() 
all_species <- all_species[!is.na(all_species)]

# function to save reports, fix temp file problems
render_par <- function(x){

  tf <- tempfile()
  dir.create(tf)

  rmarkdown::render(here::here("R", "full_report_template.Rmd"), 
                    params = list(species_ID = x,
                                  
                                  latlong_data = latlong,
                                  shape = shape,
                                  
                                  asmt_sum_data = asmt_sum,
                                  
                                  survey_data = survey_big,
                                  
                                  diet_data = allfh,
                                  
                                  rec_data = rec,
                                  
                                  asmt_data = asmt,
                                  
                                  cond_data = cond,
                                  
                                  risk_data = risk,
                                  
                                  com_data = com,
                                  
                                  swept_data = swept
                                  ), 
                    intermediates_dir = tf,
                    output_dir = here::here("docs/reports"),
                    output_file = paste(x, "_full", 
                                        ".html", sep = ""))

  unlink(tf)

}

# read in data
source(here::here("R/full_report_functions", "read_data.R"))

# make cluster
cl <- snow::makeCluster(7, # 12.5 min with 4 cores, 7.5 min with 7 cores
                        type = "SOCK",
                        methods = FALSE)

# export data to cluster
snow::clusterExport(cl, list("survey_big", "asmt", "asmt_sum", "risk",
                                 "latlong", "rec", "allfh", "cond", "com",
                                 "swept"))

# set up cluster
snow::clusterEvalQ(cl, {
  # load libraries
  library(ggplot2)
  `%>%` <- dplyr::`%>%`
  
  # load shapefile
  shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
  
}) %>% invisible()

# generate reports
snow::clusterApply(cl, all_species, render_par)

# check what data is on clusters
# parallel::clusterCall(cl, print(ls()))

# stop cluster
snow::stopCluster(cl)

#####

## make summary spreadsheet (old)
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
