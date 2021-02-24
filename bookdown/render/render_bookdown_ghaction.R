`%>%` <- dplyr::`%>%`

if(!"papeR" %in% installed.packages()){
  install.packages("papeR")
}

# get NE stock names
names <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
# tilefish has is NA in COMNAME column? omit for now

all_species <- names$COMNAME %>% 
  unique() %>% 
  stringr::str_to_sentence() %>%
  stringr::str_replace("Goosefish", "Monkfish") # change goosefish to monkfish
all_species <- all_species[!is.na(all_species)]

# remove any existing reports that could cause a conflict (?)
unlink(here::here("action_reports"))

dir.create(here::here("action_reports"))

render_bks <- function(x, trouble){
  
  new_dir <- here::here("action_reports/", x)
  dir.create(new_dir)
  
  file.create(here::here(new_dir, ".nojekyll")) %>%
    invisible()
  
  bookdown_template <- c(list.files(here::here("bookdown/"),
                                    full.names = TRUE) %>%
                           stringr::str_subset(".Rmd"),
                         list.files(here::here("bookdown/"),
                                    full.names = TRUE) %>%
                           stringr::str_subset(".yml"))

  file.copy(from = bookdown_template,
            to = here::here(new_dir),
            overwrite = TRUE) %>%
    invisible()
  
  setwd(here::here(new_dir))
  
  if(trouble == FALSE){
    bookdown::render_book(input = ".",
                          params = list(species_ID = x,
                                        
                                        path = here::here(new_dir, "figures//"),
                                        
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
                          intermediates_dir = new_dir,
                          knit_root_dir = new_dir,
                          output_dir = new_dir,
                          clean = TRUE,
                          quiet = TRUE) %>%
      suppressWarnings() %>%
      suppressMessages()
  }

  if(trouble == TRUE){
    bookdown::render_book(input = ".",
                          params = list(species_ID = x,
                                        
                                        path = here::here(new_dir, "figures//"),
                                        
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
                          intermediates_dir = new_dir,
                          knit_root_dir = new_dir,
                          output_dir = new_dir,
                          clean = TRUE,
                          quiet = FALSE) 
  }
  
  # clean up files
  clean <- c(list.files(here::here(new_dir),
                        full.names = TRUE) %>%
               stringr::str_subset(".Rmd"),
             list.files(here::here(new_dir),
                        full.names = TRUE) %>%
               stringr::str_subset(".yml"))
  
  file.remove(clean) %>%
    invisible()
  
  print(paste("Done with", x, "!"))
  
}

# read in data
source(here::here("R/full_report_functions", "read_data.R"))

# generate reports
#nums <- 1
lapply(all_species[nums],
       render_bks,
       trouble = FALSE)
