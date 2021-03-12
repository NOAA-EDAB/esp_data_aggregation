# see function information
?NEesp::render_ind_report

# run a report using package data and package template
NEesp::render_ind_report("Black sea bass")

# run a report using package data and local template
NEesp::render_ind_report("Black sea bass", 
                         input = here::here("bookdown"),
                         params_to_use = list(
                           species_ID = "Black sea bass",
                           path = here::here("action_reports/Black sea bass", "figures//"),
                           latlong_data = NEesp::latlong,
                           shape = NEesp::shape,
                           asmt_sum_data = NEesp::asmt_sum,
                           survey_data = NEesp::survey,
                           ricky_survey_data = NEesp::bio_survey,
                           diet_data = NEesp::allfh,
                           rec_data = NEesp::rec_catch,
                           asmt_data = NEesp::asmt,
                           cond_data = NEesp::cond,
                           risk_data = NEesp::risk,
                           risk_year_hist_data = NEesp::risk_year_hist,
                           risk_year_value_data = NEesp::risk_year_value,
                           risk_species_data = NEesp::risk_species,
                           com_data = NEesp::com_catch,
                           swept_data = NEesp::swept
                         ))

# run a report using local data and local template
source(here::here("R/full_report_functions", "read_data.R"))
NEesp::render_ind_report("Black sea bass", 
                         input = here::here("bookdown"),
                         params_to_use = list(
                           species_ID = "Black sea bass",
                           path = here::here("action_reports/Black sea bass", "figures//"),
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
                         ))
