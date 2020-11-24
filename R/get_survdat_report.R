
# source data to get list of what species to run reports on

data <- readRDS(here::here("data", "survdat.RDS"))
data <- tibble::as.tibble(data$survdat)

key <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/seasonal_stock_strata.csv")
key <- data.frame(SVSPP = unique(key$SVSPP),
                  Species = stringr::str_to_sentence(unique(key$COMNAME)))

data2 <- dplyr::filter(data, SVSPP == key$SVSPP)

species_name <- c()
for(i in 1:length(data2$SVSPP)){
  svspp <- as.numeric(data2$SVSPP[i])
  r <- which(key$SVSPP == svspp)
  species_name[i] <- key[r, 2]
}

head(species_name)
unique(species_name)

data2$Species <- species_name

list_species <- split(unique(data$SVSPP), f = list(unique(data$SVSPP)))

# render some reports

test_species <- list_species[9:20] 
purrr::map(test_species, ~rmarkdown::render(here::here("R", "survdat_report_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          data_source = data), 
                                            output_dir = here::here("docs"),
                                            output_file = paste(.x, ".html", sep = "")))