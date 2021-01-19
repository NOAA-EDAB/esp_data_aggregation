#rmarkdown::render_site(encoding = 'UTF-8')

# purrr ----

source(here::here("R/full_report_functions", "read_data.R"))

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>% unique() %>% stringr::str_to_sentence()
list_species <- split(all_species, f = list(all_species))

dir.create(here::here("docs/bookdown/Acadian redfish"))
file.create(here::here("docs/bookdown/Acadian redfish", ".nojekyll"))

setwd(here::here("bookdown"))
purrr::map(list_species, 
           ~bookdown::render_book(input = ".",
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
                                               
                                               risk_year_data = risk_year,
                                               
                                               risk_species_data = risk_species,
                                               
                                               com_data = com,
                                               
                                               swept_data = swept
                                 ), 
                                 knit_root_dir = here::here(paste("docs/bookdown/", .x, sep = "")),
                                 output_dir = here::here(paste("docs/bookdown/", .x, sep = ""))
                                 ))

# create .nojekyll file
file.create(here::here("docs/bookdown", ".nojekyll"))

# parallelize all reports ----
# problems with bookdown & paralellization - not reliable
# i think it's fixed now
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
# try copying bookdown .rmd files to new directories
#list.files(here::here("bookdown"), full.names = TRUE)

dir.create(here::here("docs/bookdown/"))
render_par <- function(x){

  tf <- tempfile()
  dir.create(tf)
  
  new_dir <- here::here(paste("docs/bookdown/", x, sep = ""))
  dir.create(new_dir)
  
  file.copy(from = list.files(here::here("bookdown"), full.names = TRUE),
            to = new_dir,
            recursive = FALSE,
            overwrite = TRUE)
  
  setwd(new_dir)
  file.create(".nojekyll")
  
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
                                      
                                      risk_year_data = risk_year,
                                      
                                      risk_species_data = risk_species,
                                      
                                      com_data = com,
                                      
                                      swept_data = swept
                        ),
                        intermediates_dir = tf,
                        knit_root_dir = new_dir,
                        #clean = TRUE,
                        output_dir = new_dir)
  
  # copy images to right folder
  file.copy(from = list.files(here::here(new_dir, "/_bookdown_files/"), full.names = TRUE),
            to = new_dir,
            recursive = TRUE,
            overwrite = TRUE)

  unlink(tf)
  #return("done")
  
}

# read in data
source(here::here("R/full_report_functions", "read_data.R"))

# make cluster
cl <- snow::makeCluster(7) # not the same as cores - can have more than 8??

# export data to cluster
snow::clusterExport(cl, list("survey_big", "asmt", "asmt_sum", "risk",
                             "latlong", "rec", "allfh", "cond", "com",
                             "swept", "risk_species", "risk_year"))

# set up cluster
snow::clusterEvalQ(cl, {
  # load libraries
  library(ggplot2)
  `%>%` <- dplyr::`%>%`
  
  # load shapefile
  shape <- sf::read_sf(here::here("data/strata_shapefiles", "BTS_Strata.shp"))
  
}) %>% invisible()

# generate reports
snow::clusterApply(cl, 
                     all_species,
                     render_par)

# check what data is on clusters
# parallel::clusterCall(cl, print(ls()))

# stop cluster
Sys.time()
snow::stopCluster(cl)
Sys.time()
.restart.R()
Sys.time()

#####
              
