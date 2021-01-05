rmarkdown::render_site(encoding = 'UTF-8')

source(here::here("R/full_report_functions", "read_data.R"))

setwd(here::here("bookdown"))
bookdown::render_book(input = ".",
                      params = list(species_ID = "Acadian redfish",
                                    
                                    latlong_data = latlong,
                                    shape = shape,
                                    
                                    asmt_sum_data = asmt_sum,
                                    
                                    survey_data = survey_big,
                                    
                                    diet_data = allfh,
                                    
                                    rec_data = rec,
                                    
                                    asmt_data = asmt,
                                    
                                    cond_data = cond,
                                    
                                    risk_data = risk,
                                    
                                    com_data = com,
                                    
                                    swept_data = swept
                      ),
                      output_dir = here::here("docs/bookdown"),
                      output_file = "Acadian_redfish_bookdown")

# create .nojekyll file
file.create(here::here("docs/bookdown", ".nojekyll"))
                      