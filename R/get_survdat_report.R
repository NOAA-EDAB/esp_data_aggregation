
# source data to get list of what species to run reports on

data <- readRDS(here::here("data", "survdat.RDS"))
data <- tibble::as.tibble(data$survdat)
list_data <- split(data, 
                   f = list(data$SVSPP, 
                            data$SEASON),
                   drop = TRUE)

list_species <- split(unique(data$SVSPP), f = list(unique(data$SVSPP)))

# render some reports

test_species <- list_species[1:8] # fails on 008 - not enough data for smoothing?
purrr::map(test_species, ~rmarkdown::render(here::here("R", "survdat_testing.Rmd"), 
                                            params = list(species_ID = .x), 
                                            output_dir = here::here("abby_reports"),
                                            output_file = paste(.x, ".html", sep = "")))
           
           