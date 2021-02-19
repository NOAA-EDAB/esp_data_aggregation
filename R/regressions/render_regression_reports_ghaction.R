`%>%` <- dplyr::`%>%`

# get list of species and regions, manually assign to EPUs
#assessmentdata::stockAssessmentData %>% 
#  dplyr::select(Species, Region) %>% 
#  dplyr::distinct() %>% 
#  dplyr::filter(Species %in% 
#                  all_species | Species == "Goosefish") %>% 
#  write.csv(here::here("R/regressions", "regression_species_regions.csv"))

info <- read.csv(here::here("R/regressions", "regression_species_regions.csv"))

render_reg_report <- function(stock_var, epus_var, region_var, lag_var, parent_folder){
  
  new_dir <- here::here("Regressions", parent_folder, paste(stock_var, region_var))
  dir.create(new_dir, 
             recursive = TRUE)
  
  file.create(here::here(new_dir, ".nojekyll"))
  
  file.copy(from = list.files(here::here("R/regressions/bookdown/"),
                              full.names = TRUE),
            to = here::here(new_dir),
            overwrite = TRUE)
  
  setwd(here::here(new_dir))
  bookdown::render_book(input = ".",
                        params = list(lag = lag_var,
                                      stock = stock_var,
                                      region = region_var,
                                      epu = c(epus_var, c("All", "all", "NE")),
                                      path = here::here(new_dir, "figures//")),
                        output_dir = new_dir,
                        intermediates_dir = new_dir,
                        knit_root_dir = new_dir,
                        clean = TRUE,
                        quiet = TRUE) %>% 
    suppressMessages() %>%
    suppressWarnings()
  
  # clean up files
  list.files(here::here(new_dir),
             full.names = TRUE) %>%
    stringr::str_subset(".Rmd") %>% 
    file.remove()

  list.files(here::here(new_dir),
             full.names = TRUE) %>%
    stringr::str_subset(".yml") %>% 
    file.remove()
  
  print(paste("Done with", parent_folder, stock_var, "!"))
}


for(i in 1:nrow(info)){
  # make 0 lag reports
  render_reg_report(stock_var = info[i, 1], 
                    epus_var = info[i, 3],
                    region_var = info[i, 2],
                    lag_var = 0,
                    parent_folder = "zero_lag")
  
  # make 1 year lag reports
  render_reg_report(stock_var = info[i, 1], 
                    epus_var = info[i, 3],
                    region_var = info[i, 2],
                    lag_var = 1,
                    parent_folder = "one_year_lag")
  
  # make 1 year lag, minus 10 recent years reports
  render_reg_report(stock_var = info[i, 1], 
                    epus_var = info[i, 3],
                    region_var = info[i, 2],
                    lag_var = 1,
                    parent_folder = "one_year_lag_remove_recent",
                    remove_recent = TRUE)
}

