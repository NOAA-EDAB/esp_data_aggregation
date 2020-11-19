
# source data to get list of what species to run reports on

data <- readRDS(here::here("data", "survdat.RDS"))
data <- tibble::as.tibble(data$survdat)

list_species <- split(unique(data$SVSPP), f = list(unique(data$SVSPP)))

# render some reports

test_species <- list_species[1:8] # fails on 008 - not enough data for smoothing?
purrr::map(test_species, ~rmarkdown::render(here::here("R", "survdat_report_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          data_source = data), 
                                            output_dir = here::here("abby_reports"),
                                            output_file = paste(.x, ".html", sep = "")))

# testing geom_gls()

m <- 0.1
a <- 1:30
b <-  m*a + rnorm(30, sd = 0.35)

data2 <- data.frame(x = x,
                   y = y)

#Plot series with trend 
ggplot2::ggplot(data = data2,aes(x = a, y = b)) +
  geom_line() +
  ecodata::geom_gls()