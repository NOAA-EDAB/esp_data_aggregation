`%>%` <- dplyr::`%>%`

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>% 
  unique() %>% 
  stringr::str_to_sentence() %>%
  stringr::str_replace("Goosefish", "Monkfish") # change goosefish to monkfish
all_species <- all_species[!is.na(all_species)]

# function to save reports, fix temp file problems
# try copying bookdown .rmd files to new directories
#list.files(here::here("bookdown"), full.names = TRUE)

dir.create(here::here("docs/action_reports/"))
render_par <- function(x){
  
  tf <- tempfile()
  dir.create(tf)
  
  new_dir <- here::here(paste("docs/action_reports/", x, sep = ""))
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
                                      
                                      ricky_survey_data = ricky_survey,
                                      
                                      diet_data = allfh,
                                      
                                      rec_data = rec,
                                      
                                      asmt_data = asmt,
                                      
                                      cond_data = cond,
                                      
                                      risk_data = risk,
                                      
                                      risk_year_hist_data = risk_year_hist,
                                      
                                      risk_year_value_data = risk_year_value,
                                      
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
  
  # remove temp files and extra images
  unlink(tf)
  unlink(here::here(new_dir, "/_bookdown_files/"))
  
  # remove .Rmd and yml files in docs folders
  rmds <- dir() %>%
    stringr::str_subset(".Rmd")
  
  ymls <- dir() %>%
    stringr::str_subset(".yml")
  
  file.remove(c(rmds, ymls))
}

# read in data
source(here::here("R/full_report_functions", "read_data.R"))

# make cluster
cl <- parallel::makeCluster(8, 
                  type = "FORK")

# don't have to set up clusters when using forking (global environment is accessible)

# generate reports
parallel::parLapply(cl, 
                all_species,
                render_par)

# stop cluster
parallel::stopCluster(cl)
