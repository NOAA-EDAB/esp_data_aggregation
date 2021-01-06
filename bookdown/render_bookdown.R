#rmarkdown::render_site(encoding = 'UTF-8')

source(here::here("R/full_report_functions", "read_data.R"))

setwd(here::here("bookdown"))
bookdown::render_book(input = ".",
                      params = list(species_ID = "Acadian redfish",
                                    
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
                      output_dir = here::here("docs/bookdown/Acadian redfish"),
                      output_file = "Acadian_redfish_bookdown")

# create .nojekyll file
file.create(here::here("docs/bookdown", ".nojekyll"))

# parallelize all reports
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
  setwd(here::here("bookdown"))
  
  tf <- tempfile()
  dir.create(tf)
  
  bookdown::render_book(input = ".",
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
                        output_dir = here::here(paste("docs/bookdown/", x, sep = "")),
                        output_file = paste(x, "bookdown", sep = "_"))

  unlink(tf)
  return("done")
  
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
.rs.restartR()

#####

                      