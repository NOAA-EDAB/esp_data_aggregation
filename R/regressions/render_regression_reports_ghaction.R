
#install.packages("purrr")

`%>%` <- dplyr::`%>%`

# get list of species and regions, manually assign to EPUs
#assessmentdata::stockAssessmentData %>% 
#  dplyr::select(Species, Region) %>% 
#  dplyr::distinct() %>% 
#  dplyr::filter(Species %in% 
#                  all_species | Species == "Goosefish") %>% 
#  write.csv(here::here("R/regressions", "regression_species_regions.csv"))

info <- read.csv(here::here("R/regressions", "regression_species_regions.csv"))

render_reg_report <- function(stock_var, epus_var, region_var, remove_var, 
                              lag_var, parent_folder, trouble, save_var){
  
  new_dir <- here::here("Regressions", parent_folder, 
                        paste(stock_var, region_var 
                              %>% stringr::str_replace_all("/", "-"),
                             epus_var)) %>%
    stringr::str_replace_all(" ", "_")
  dir.create(new_dir, 
             recursive = TRUE)

  file.create(here::here(new_dir, ".nojekyll"))
  
  file.copy(from = list.files(here::here("R/regressions/bookdown/"),
                              full.names = TRUE),
            to = here::here(new_dir),
            overwrite = TRUE)
  
  setwd(here::here(new_dir))
  
  dir.create("data", 
             recursive = TRUE)
  
  if(trouble == FALSE){
    bookdown::render_book(input = ".",
                          params = list(lag = lag_var,
                                        stock = stock_var,
                                        region = region_var,
                                        epu = c(epus_var, c("All", "all", "NE")),
                                        path = here::here(new_dir, "figures//"),
                                        save = save_var,
                                        remove_recent = remove_var),
                          output_dir = new_dir,
                          intermediates_dir = new_dir,
                          knit_root_dir = new_dir,
                          clean = TRUE,
                          quiet = TRUE) %>% 
      suppressMessages() %>%
      suppressWarnings()
  }
  
  if(trouble == TRUE){
    bookdown::render_book(input = ".",
                          params = list(lag = lag_var,
                                        stock = stock_var,
                                        region = region_var,
                                        epu = c(epus_var, c("All", "all", "NE")),
                                        path = here::here(new_dir, "figures//"),
                                        save = save_var,
                                        remove_recent = remove_var),
                          output_dir = new_dir,
                          intermediates_dir = new_dir,
                          knit_root_dir = new_dir,
                          clean = TRUE,
                          quiet = FALSE)
  }

  
  # clean up files
  list.files(here::here(new_dir),
             full.names = TRUE) %>%
    stringr::str_subset(".Rmd") %>% 
    file.remove()

  list.files(here::here(new_dir),
             full.names = TRUE) %>%
    stringr::str_subset(".yml") %>% 
    file.remove()
  
  print(paste(i, "Done with", parent_folder, region_var, epus_var, stock_var, "!",
              sep = ": "))
}

for(i in 1:nrow(info)
    ){
  # make 0 lag reports
  render_reg_report(stock_var = info[i, 1], 
                    epus_var = info[i, 3],
                    region_var = info[i, 2],
                    lag_var = 0,
                    remove_var = FALSE,
                    save_var = TRUE,
                    parent_folder = "zero_lag",
                    trouble = TRUE)
  
  # make 1 year lag reports
  render_reg_report(stock_var = info[i, 1], 
                    epus_var = info[i, 3],
                    region_var = info[i, 2],
                    lag_var = 1,
                    remove_var = FALSE,
                    save_var = FALSE,
                    parent_folder = "one_year_lag",
                    trouble = FALSE)
  
  # make 1 year lag, minus 10 recent years reports
  render_reg_report(stock_var = info[i, 1], 
                    epus_var = info[i, 3],
                    region_var = info[i, 2],
                    lag_var = 1,
                    remove_var = TRUE,
                    save_var = FALSE,
                    parent_folder = "one_year_lag_remove_recent",
                    trouble = FALSE)
}

