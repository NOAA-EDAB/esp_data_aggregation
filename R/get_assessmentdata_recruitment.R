

dat <- assessmentdata::stockAssessmentData
head(dat)

recruit <- dplyr::filter(dat, 
                         Metric == "Recruitment",
                         Region == "Gulf of Maine / Georges Bank" |
                           Region == "Eastern Georges Bank" |
                           Region == "Georges Bank" |
                           Region == "Gulf of Maine" |
                           Region == "Gulf of Maine / Cape Hatteras" |
                           Region == "Georges Bank / Southern New England" |
                           Region == "Southern New England / Mid" |
                           Region == "Gulf of Maine / Northern Georges Bank" |
                           Region == "Southern Georges Bank / Mid" |
                           Region == "Cape Cod / Gulf of Maine")

# render some reports

list_species <- split(unique(recruit$Species), f = list(unique(recruit$Species)))

purrr::map(list_species, ~rmarkdown::render(here::here("R", "assessmentdata_recruitment_template.Rmd"), 
                                            params = list(species_ID = .x,
                                                          data_source = recruit,
                                                          nyear = 20), 
                                            output_dir = here::here("docs"),
                                            output_file = paste(.x, "_recruitment", 
                                                                ".html", sep = "")))

