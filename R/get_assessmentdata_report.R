library(assessmentdata)
data <- assessmentdata::stockAssessmentSummary

ne_data <- filter(data, Jurisdiction == "NEFMC")
head(ne_data)

list_species <- split(unique(ne_data$`Stock Name`), f = list(unique(ne_data$`Stock Name`)))

# render some reports

test_species <- list_species
purrr::map(test_species, ~rmarkdown::render(here::here("R", "assessmentdata_report_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          data_source = ne_data), 
                                            output_dir = here::here("docs"),
                                            output_file = paste(stringr::str_replace(.x, "/", "&"), 
                                                                ".html", sep = "")))
